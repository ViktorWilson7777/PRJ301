package com.lucy.lms;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

import java.io.FileInputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class DataExtractor {
    public static void main(String[] args) {
        String filePath = "fixed 8 flat file/Chinese_level_1-30_LucyLMS_Ready.docx";
        String outPath = "tmp/extract_output.txt";
        
        try (FileInputStream fis = new FileInputStream(filePath);
             XWPFDocument document = new XWPFDocument(fis);
             PrintWriter writer = new PrintWriter(outPath, StandardCharsets.UTF_8)) {
            
            List<XWPFParagraph> paragraphs = document.getParagraphs();
            for (int i = 0; i < Math.min(100, paragraphs.size()); i++) {
                String text = paragraphs.get(i).getText();
                if (text != null && !text.trim().isEmpty()) {
                    writer.println(text.trim());
                }
            }
            System.out.println("Extraction finished.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
