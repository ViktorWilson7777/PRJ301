package com.lucy.lms.service;

import com.lucy.lms.dto.DocxPreviewItem;
import com.lucy.lms.dto.DocxPreviewResult;
import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.ImportFile;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.ImportFileRepository;
import com.lucy.lms.repository.LessonRepository;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@SuppressWarnings("null")
public class DocxImportService {

    private final ImportFileRepository importFileRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;

    private static final Pattern LEVEL_PATTERN =
            Pattern.compile("^LEVEL\\s+(\\d+)\\s*\\|\\s*(.+)$", Pattern.CASE_INSENSITIVE);

    private static final Pattern SUBLEVEL_PATTERN =
            Pattern.compile("^SUBLEVEL\\s+(\\d+)\\s*\\|\\s*(warmup|ice_breaker|discussion|follow_up|practice|wrapup)\\s*\\|\\s*(.+)$",
                    Pattern.CASE_INSENSITIVE);

    public DocxImportService(ImportFileRepository importFileRepository,
                             CourseRepository courseRepository,
                             ChapterRepository chapterRepository,
                             LessonRepository lessonRepository) {
        this.importFileRepository = importFileRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
    }

    public ImportFile importDocx(Long courseId, MultipartFile file) {
        try {
            return importFromLines(courseId, file.getOriginalFilename(), extractLines(file));
        } catch (Exception e) {
            return saveFailedImport(courseId, file.getOriginalFilename(), e.getMessage());
        }
    }

    public ImportFile importDocx(Long courseId, String fileName, byte[] fileBytes) {
        try {
            return importFromLines(courseId, fileName, extractLines(fileBytes));
        } catch (Exception e) {
            return saveFailedImport(courseId, fileName, e.getMessage());
        }
    }

    private ImportFile importFromLines(Long courseId, String fileName, List<String> lines) {
        ImportFile importFile = new ImportFile();

        try {
            Course course = courseRepository.findById(courseId)
                    .orElseThrow(() -> new RuntimeException("Course not found with id = " + courseId));

            importFile.setCourse(course);
            importFile.setFileName(fileName);
            importFile.setImportedAt(LocalDateTime.now());
            importFile.setStatus("PENDING");
            importFile.setErrorMessage(null);

            if (lines.isEmpty()) {
                throw new RuntimeException("DOCX file has no readable text.");
            }

            List<ParsedChapter> parsedChapters = parseStandardFormat(lines);

            validateNoDuplicateLevel(course.getId(), parsedChapters);

            int chapterCount = 0;
            int lessonCount = 0;

            for (ParsedChapter parsedChapter : parsedChapters) {
                Chapter chapter = new Chapter();
                chapter.setCourse(course);
                chapter.setTitle("Level " + parsedChapter.levelNumber + " - " + parsedChapter.title);
                chapter.setDescription(null);
                chapter.setOrderIndex(parsedChapter.levelNumber);

                Chapter savedChapter = chapterRepository.save(chapter);
                chapterCount++;

                for (ParsedLesson parsedLesson : parsedChapter.lessons) {
                    Lesson lesson = new Lesson();
                    lesson.setChapter(savedChapter);
                    lesson.setType(parsedLesson.type);
                    lesson.setTitle(parsedLesson.title);
                    lesson.setOrderIndex(parsedLesson.sublevelNumber);
                    lesson.setDescription(parsedLesson.rawContent);
                    lesson.setContentData(toJsonRawText(parsedLesson.rawContent));

                    lessonRepository.save(lesson);
                    lessonCount++;
                }
            }

            importFile.setStatus("SUCCESS");
            importFile.setErrorMessage(
                    "Imported successfully. Chapters: " + chapterCount +
                            ", Lessons: " + lessonCount +
                            ", Lines: " + lines.size()
            );

        } catch (Exception e) {
            importFile.setStatus("FAILED");
            importFile.setErrorMessage(e.getMessage());
        }

        return importFileRepository.save(importFile);
    }

    private ImportFile saveFailedImport(Long courseId, String fileName, String message) {
        ImportFile importFile = new ImportFile();
        importFile.setFileName(fileName);
        importFile.setImportedAt(LocalDateTime.now());
        importFile.setStatus("FAILED");
        importFile.setErrorMessage(message);
        courseRepository.findById(courseId).ifPresent(importFile::setCourse);
        return importFileRepository.save(importFile);
    }

    public DocxPreviewResult previewDocx(MultipartFile file) {
        return previewDocx(null, file);
    }

    public DocxPreviewResult previewDocx(Long courseId, MultipartFile file) {
        DocxPreviewResult result = new DocxPreviewResult();
        result.setFileName(file.getOriginalFilename());

        try {
            List<String> lines = extractLines(file);
            List<DocxPreviewItem> paragraphs = new ArrayList<>();

            for (int i = 0; i < lines.size(); i++) {
                paragraphs.add(new DocxPreviewItem(i + 1, lines.get(i)));
            }

            result.setParagraphs(paragraphs);
            result.setLineCount(lines.size());

            if (lines.isEmpty()) {
                throw new RuntimeException("DOCX file has no readable text.");
            }

            List<ParsedChapter> parsedChapters = parseStandardFormat(lines);
            if (courseId != null) {
                validateNoDuplicateLevel(courseId, parsedChapters);
            }

            result.setChapterCount(parsedChapters.size());
            result.setLessonCount(countLessons(parsedChapters));
            result.setValid(true);
            result.setMessage("Ready to import. Chapters: " + result.getChapterCount() +
                    ", Lessons: " + result.getLessonCount() +
                    ", Lines: " + result.getLineCount());
        } catch (Exception e) {
            result.setValid(false);
            result.setMessage(e.getMessage());
            if (result.getParagraphs().isEmpty()) {
                result.getParagraphs().add(new DocxPreviewItem(0, "ERROR: " + e.getMessage()));
            }
        }

        return result;
    }

    private List<String> extractLines(MultipartFile file) throws Exception {
        return extractLines(file.getInputStream());
    }

    private List<String> extractLines(byte[] fileBytes) throws Exception {
        return extractLines(new ByteArrayInputStream(fileBytes));
    }

    private List<String> extractLines(InputStream inputStream) throws Exception {
        List<String> lines = new ArrayList<>();

        try (inputStream;
             XWPFDocument document = new XWPFDocument(inputStream)) {

            for (XWPFParagraph paragraph : document.getParagraphs()) {
                String text = paragraph.getText();

                if (text != null) {
                    text = text.trim();
                }

                if (text != null && !text.isEmpty()) {
                    lines.add(text);
                }
            }
        }

        return lines;
    }

    private int countLessons(List<ParsedChapter> chapters) {
        int count = 0;
        for (ParsedChapter chapter : chapters) {
            count += chapter.lessons.size();
        }
        return count;
    }

    private List<ParsedChapter> parseStandardFormat(List<String> lines) {
        List<ParsedChapter> chapters = new ArrayList<>();

        ParsedChapter currentChapter = null;
        ParsedLesson currentLesson = null;
        StringBuilder contentBuffer = new StringBuilder();

        int lineNumber = 0;

        for (String line : lines) {
            lineNumber++;

            Matcher levelMatcher = LEVEL_PATTERN.matcher(line);
            Matcher sublevelMatcher = SUBLEVEL_PATTERN.matcher(line);

            if (levelMatcher.matches()) {
                if (currentLesson != null) {
                    currentLesson.rawContent = contentBuffer.toString().trim();
                    currentLesson = null;
                    contentBuffer = new StringBuilder();
                }

                int levelNumber = Integer.parseInt(levelMatcher.group(1));
                String levelTitle = levelMatcher.group(2).trim();

                currentChapter = new ParsedChapter();
                currentChapter.levelNumber = levelNumber;
                currentChapter.title = levelTitle;

                chapters.add(currentChapter);
                continue;
            }

            if (sublevelMatcher.matches()) {
                if (currentChapter == null) {
                    throw new RuntimeException(
                            "Invalid format at line " + lineNumber +
                                    ": SUBLEVEL appears before LEVEL. Line: " + line
                    );
                }

                if (currentLesson != null) {
                    currentLesson.rawContent = contentBuffer.toString().trim();
                    contentBuffer = new StringBuilder();
                }

                int sublevelNumber = Integer.parseInt(sublevelMatcher.group(1));
                String type = sublevelMatcher.group(2).toLowerCase();
                String sublevelTitle = sublevelMatcher.group(3).trim();

                currentLesson = new ParsedLesson();
                currentLesson.sublevelNumber = sublevelNumber;
                currentLesson.type = type;
                currentLesson.title = sublevelTitle;

                currentChapter.lessons.add(currentLesson);
                continue;
            }

            if (currentChapter == null) {
                // Bỏ qua các dòng giới thiệu nằm trước LEVEL đầu tiên.
                continue;
            }

            if (currentLesson == null) {
                throw new RuntimeException(
                        "Invalid format at line " + lineNumber +
                                ": content appears before SUBLEVEL. Line: " + line
                );
            }

            if (contentBuffer.length() > 0) {
                contentBuffer.append("\n");
            }

            contentBuffer.append(line);
        }

        if (currentLesson != null) {
            currentLesson.rawContent = contentBuffer.toString().trim();
        }

        validateParsedData(chapters);

        return chapters;
    }

    private void validateParsedData(List<ParsedChapter> chapters) {
        if (chapters.isEmpty()) {
            throw new RuntimeException("No LEVEL found. Please use format: LEVEL 1 | Title");
        }

        Set<Integer> levelNumbers = new HashSet<>();

        for (ParsedChapter chapter : chapters) {
            if (!levelNumbers.add(chapter.levelNumber)) {
                throw new RuntimeException("Duplicate LEVEL number: " + chapter.levelNumber);
            }

            if (chapter.title == null || chapter.title.trim().isEmpty()) {
                throw new RuntimeException("LEVEL " + chapter.levelNumber + " has empty title.");
            }

            if (chapter.lessons.isEmpty()) {
                throw new RuntimeException(
                        "LEVEL " + chapter.levelNumber +
                                " has no SUBLEVEL. Each LEVEL must have at least one SUBLEVEL."
                );
            }

            Set<Integer> sublevelNumbers = new HashSet<>();

            for (ParsedLesson lesson : chapter.lessons) {
                if (!sublevelNumbers.add(lesson.sublevelNumber)) {
                    throw new RuntimeException(
                            "Duplicate SUBLEVEL number " + lesson.sublevelNumber +
                                    " in LEVEL " + chapter.levelNumber
                    );
                }

                if (lesson.title == null || lesson.title.trim().isEmpty()) {
                    throw new RuntimeException(
                            "SUBLEVEL " + lesson.sublevelNumber +
                                    " in LEVEL " + chapter.levelNumber +
                                    " has empty title."
                    );
                }
            }
        }
    }

    private void validateNoDuplicateLevel(Long courseId, List<ParsedChapter> parsedChapters) {
        List<Chapter> existingChapters = chapterRepository.findByCourseIdOrderByOrderIndexAsc(courseId);

        Set<Integer> existingLevelNumbers = new HashSet<>();

        for (Chapter chapter : existingChapters) {
            if (chapter.getOrderIndex() != null) {
                existingLevelNumbers.add(chapter.getOrderIndex());
            }
        }

        for (ParsedChapter parsedChapter : parsedChapters) {
            if (existingLevelNumbers.contains(parsedChapter.levelNumber)) {
                throw new RuntimeException(
                        "LEVEL " + parsedChapter.levelNumber +
                                " already exists in this Course. Please delete old data before importing again."
                );
            }
        }
    }

    private String toJsonRawText(String rawText) {
        return "{\"rawText\":\"" + escapeJson(rawText) + "\"}";
    }

    private String escapeJson(String text) {
        if (text == null) {
            return "";
        }

        return text
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", "\\n");
    }

    private static class ParsedChapter {
        int levelNumber;
        String title;
        List<ParsedLesson> lessons = new ArrayList<>();
    }

    private static class ParsedLesson {
        int sublevelNumber;
        String type;
        String title;
        String rawContent = "";
    }
}
