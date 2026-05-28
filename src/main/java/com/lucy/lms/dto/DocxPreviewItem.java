package com.lucy.lms.dto;

public class DocxPreviewItem {

    private int index;
    private String text;

    public DocxPreviewItem() {
    }

    public DocxPreviewItem(int index, String text) {
        this.index = index;
        this.text = text;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}