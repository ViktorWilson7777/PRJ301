package com.lucy.lms;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class DocxToCsvConverter {
    public static void main(String[] args) {
        File dir = new File("fixed 8 flat file");
        File outDir = new File("tmp/csv");
        outDir.mkdirs();
        
        File[] files = dir.listFiles((d, name) -> name.endsWith(".docx"));
        if (files == null) return;
        
        for (File file : files) {
            String language = "";
            boolean isChinese = false;
            if (file.getName().toLowerCase().contains("chinese")) { language = "Chinese"; isChinese = true; }
            else if (file.getName().toLowerCase().contains("eng")) { language = "English"; }
            else if (file.getName().toLowerCase().contains("ja_")) { language = "Japanese"; }
            
            String outFilePath = "tmp/csv/" + file.getName().replace(".docx", ".csv");
            
            try (FileInputStream fis = new FileInputStream(file);
                 XWPFDocument document = new XWPFDocument(fis);
                 PrintWriter writer = new PrintWriter(outFilePath, StandardCharsets.UTF_8)) {
                
                // CSV Header
                writer.println("Language,File,Level,SubLevel,PromptType,Question,Question_Sub,Answer,Answer_Sub");
                
                List<XWPFParagraph> paragraphs = document.getParagraphs();
                
                String curLevel = "";
                String curSubLevel = "";
                String curPromptType = "";
                String curQuestion = "";
                String curQuestionSub = "";
                
                String curAnswer = "";
                String curAnswerSub = "";
                
                boolean parsingAnswer = false;
                
                for (XWPFParagraph p : paragraphs) {
                    String text = p.getText().trim();
                    if (text.isEmpty()) continue;
                    
                    if (text.startsWith("LEVEL")) {
                        curLevel = text;
                        curSubLevel = ""; curPromptType = ""; curQuestion = ""; curQuestionSub = "";
                        curAnswer = ""; curAnswerSub = ""; parsingAnswer = false;
                    } else if (text.startsWith("SUBLEVEL")) {
                        // flush previous if Chinese
                        if (isChinese && (!curQuestion.isEmpty() || !curAnswer.isEmpty()) && parsingAnswer) {
                            writeRow(writer, language, file.getName(), curLevel, curSubLevel, curPromptType, curQuestion, curQuestionSub, curAnswer, curAnswerSub);
                        }
                        
                        String[] parts = text.split("\\|", 3);
                        curSubLevel = parts.length > 0 ? parts[0].trim() : "";
                        curPromptType = parts.length > 1 ? parts[1].trim() : "";
                        curQuestion = parts.length > 2 ? parts[2].trim() : "";
                        curQuestionSub = "";
                        curAnswer = ""; curAnswerSub = ""; parsingAnswer = false;
                    } else {
                        if (isChinese) {
                            if (text.startsWith("\uD83D\uDC49") || text.startsWith("👉")) {
                                if (parsingAnswer && (!curAnswer.isEmpty() || !curQuestion.isEmpty())) {
                                    writeRow(writer, language, file.getName(), curLevel, curSubLevel, curPromptType, curQuestion, curQuestionSub, curAnswer, curAnswerSub);
                                }
                                curAnswer = text.replace("👉", "").replace("\uD83D\uDC49", "").trim();
                                curAnswerSub = "";
                                parsingAnswer = true;
                            } else {
                                if (parsingAnswer) {
                                    if (curAnswerSub.isEmpty()) curAnswerSub = text;
                                    else curAnswerSub += " " + text;
                                } else {
                                    if (curQuestionSub.isEmpty()) curQuestionSub = text;
                                    else curQuestionSub += " " + text;
                                }
                            }
                        } else {
                            // For English and Japanese, every line under SUBLEVEL is a prompt instruction
                            // We can map it to "Answer" just to align with the CSV columns, or just "Question"
                            writeRow(writer, language, file.getName(), curLevel, curSubLevel, curPromptType, curQuestion, "", text, "");
                        }
                    }
                }
                if (isChinese && (!curQuestion.isEmpty() || !curAnswer.isEmpty())) {
                    writeRow(writer, language, file.getName(), curLevel, curSubLevel, curPromptType, curQuestion, curQuestionSub, curAnswer, curAnswerSub);
                }
                
                System.out.println("Converted: " + file.getName());
                
            } catch (Exception e) {
                System.err.println("Error processing " + file.getName());
                e.printStackTrace();
            }
        }
    }
    
    private static void writeRow(PrintWriter writer, String lang, String file, String level, String subLevel, 
                                 String type, String q, String qSub, String a, String aSub) {
        writer.printf("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                escape(lang), escape(file), escape(level), escape(subLevel), escape(type), 
                escape(q), escape(qSub), escape(a), escape(aSub));
    }
    
    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\"", "\"\"");
    }
}
