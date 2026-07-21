package com.lucy.lms;

import java.io.BufferedReader;
import java.io.File;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class SqlGenerator {
    public static void main(String[] args) {
        File csvDir = new File("tmp/csv");
        File[] files = csvDir.listFiles((d, name) -> name.endsWith(".csv"));
        if (files == null) return;

        try (PrintWriter writer = new PrintWriter("tmp/import_data.sql", StandardCharsets.UTF_8)) {
            writer.println("BEGIN TRANSACTION;");
            writer.println("DECLARE @CourseId INT, @ChapterId INT, @LessonId INT, @ProgId INT;");
            writer.println();

            int courseOrder = 1;

            for (File file : files) {
                String language = "";
                if (file.getName().toLowerCase().contains("chinese")) language = "Chinese";
                else if (file.getName().toLowerCase().contains("eng")) language = "English";
                else if (file.getName().toLowerCase().contains("ja_")) language = "Japanese";

                String courseTitle = file.getName().replace(".csv", "");
                
                writer.printf("-- Course: %s\n", courseTitle);
                
                // Find program id
                writer.printf("  SELECT TOP 1 @ProgId = id FROM program WHERE title = '%s';\n", escapeSql(language));
                
                writer.printf("INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('%s', N'', 1, %d, N'%s', '%s', @ProgId);\n",
                        escapeSql(language.substring(0, Math.min(language.length(), 3)).toUpperCase()), courseOrder++, escapeSql(courseTitle), escapeSql(language));
                writer.println("SET @CourseId = SCOPE_IDENTITY();");

                // Parse CSV rows
                List<String[]> rows = parseCsv(file);
                
                // Group by Level -> SubLevel -> Prompts
                Map<String, Map<String, List<String[]>>> data = new LinkedHashMap<>();
                for (String[] row : rows) {
                    if (row.length < 9) continue;
                    String level = row[2];
                    String subLevel = row[3];
                    data.putIfAbsent(level, new LinkedHashMap<>());
                    data.get(level).putIfAbsent(subLevel, new ArrayList<>());
                    data.get(level).get(subLevel).add(row);
                }

                int chapterOrder = 1;
                for (Map.Entry<String, Map<String, List<String[]>>> chapterEntry : data.entrySet()) {
                    String levelTitle = chapterEntry.getKey();
                    writer.printf("\n  -- Chapter: %s\n", levelTitle);
                    writer.printf("  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', %d, N'%s', @CourseId);\n",
                            chapterOrder++, escapeSql(levelTitle));
                    writer.println("  SET @ChapterId = SCOPE_IDENTITY();");

                    int lessonOrder = 1;
                    for (Map.Entry<String, List<String[]>> lessonEntry : chapterEntry.getValue().entrySet()) {
                        String subLevelTitle = lessonEntry.getKey();
                        writer.printf("\n    -- Lesson: %s\n", subLevelTitle);
                        writer.printf("    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', %d, N'%s', 'STANDARD', @ChapterId, %d);\n",
                                lessonOrder, escapeSql(subLevelTitle), lessonOrder);
                        lessonOrder++;
                        writer.println("    SET @LessonId = SCOPE_IDENTITY();");

                        for (String[] row : lessonEntry.getValue()) {
                            String promptType = row[4];
                            String q = row[5];
                            String qSub = row[6];
                            String a = row[7];
                            String aSub = row[8];
                            
                            // Create a JSON-like string for prompt_instruction to preserve all info
                            String instruction = String.format("{\"question\": \"%s\", \"question_sub\": \"%s\", \"answer\": \"%s\", \"answer_sub\": \"%s\"}",
                                    escapeJson(q), escapeJson(qSub), escapeJson(a), escapeJson(aSub));

                            writer.printf("      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'%s', '%s', @LessonId);\n",
                                    escapeSql(instruction), escapeSql(promptType));
                        }
                    }
                }
                writer.println();
            }
            writer.println("COMMIT TRANSACTION;");
            System.out.println("SQL Script generated successfully at tmp/import_data.sql");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String escapeSql(String s) {
        if (s == null) return "";
        return s.replace("'", "''");
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }

    private static List<String[]> parseCsv(File file) throws Exception {
        List<String[]> rows = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new java.io.InputStreamReader(new java.io.FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; } // skip header
                // simple CSV parse assuming format exactly as written by DocxToCsvConverter (quoted strings separated by commas)
                String[] cols = line.split("\",\"");
                for (int i = 0; i < cols.length; i++) {
                    cols[i] = cols[i].replace("\"", "");
                }
                rows.add(cols);
            }
        }
        return rows;
    }
}
