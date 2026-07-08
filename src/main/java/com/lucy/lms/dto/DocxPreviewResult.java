package com.lucy.lms.dto;

import java.util.ArrayList;
import java.util.List;

public class DocxPreviewResult {

    private String fileName;
    private int lineCount;
    private int chapterCount;
    private int lessonCount;
    private boolean valid;
    private String message;
    private List<DocxPreviewItem> paragraphs = new ArrayList<>();

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getLineCount() {
        return lineCount;
    }

    public void setLineCount(int lineCount) {
        this.lineCount = lineCount;
    }

    public int getChapterCount() {
        return chapterCount;
    }

    public void setChapterCount(int chapterCount) {
        this.chapterCount = chapterCount;
    }

    public int getLessonCount() {
        return lessonCount;
    }

    public void setLessonCount(int lessonCount) {
        this.lessonCount = lessonCount;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<DocxPreviewItem> getParagraphs() {
        return paragraphs;
    }

    public void setParagraphs(List<DocxPreviewItem> paragraphs) {
        this.paragraphs = paragraphs;
    }
}
