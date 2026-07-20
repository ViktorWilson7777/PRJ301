package com.lucy.lms;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DbImporter {
    public static void main(String[] args) {
        String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=Lucy;encrypt=true;trustServerCertificate=true;sendStringParametersAsUnicode=true;";
        String user = "sa";
        String pass = "123456";

        File csvDir = new File("tmp/csv");
        File[] files = csvDir.listFiles((d, name) -> name.endsWith(".csv"));
        if (files == null) return;

        try (Connection conn = DriverManager.getConnection(dbUrl, user, pass)) {
            System.out.println("Connected to DB.");

            int courseOrder = 1;
            for (File file : files) {
                String language = "";
                if (file.getName().toLowerCase().contains("chinese")) language = "Chinese";
                else if (file.getName().toLowerCase().contains("eng")) language = "English";
                else if (file.getName().toLowerCase().contains("ja_")) language = "Japanese";

                String courseTitle = file.getName().replace(".csv", "");

                // Find program id
                Integer programId = null;
                try (PreparedStatement ps = conn.prepareStatement("SELECT TOP 1 id FROM program WHERE title = ?")) {
                    ps.setString(1, language);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) programId = rs.getInt(1);
                    }
                }
                
                if (programId == null) {
                    System.out.println("Warning: Program not found for " + language);
                    continue; // or set to null
                }

                int courseId = 0;
                String sqlCourse = "INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES (?, '', 1, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sqlCourse, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, language.substring(0, Math.min(language.length(), 3)).toUpperCase());
                    ps.setInt(2, courseOrder++);
                    ps.setNString(3, courseTitle);
                    ps.setString(4, language);
                    ps.setInt(5, programId);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) courseId = rs.getInt(1);
                    }
                }

                List<String[]> rows = parseCsv(file);
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
                    int chapterId = 0;
                    String sqlChapter = "INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', ?, ?, ?)";
                    try (PreparedStatement ps = conn.prepareStatement(sqlChapter, Statement.RETURN_GENERATED_KEYS)) {
                        ps.setInt(1, chapterOrder++);
                        ps.setNString(2, chapterEntry.getKey());
                        ps.setInt(3, courseId);
                        ps.executeUpdate();
                        try (ResultSet rs = ps.getGeneratedKeys()) {
                            if (rs.next()) chapterId = rs.getInt(1);
                        }
                    }

                    int lessonOrder = 1;
                    for (Map.Entry<String, List<String[]>> lessonEntry : chapterEntry.getValue().entrySet()) {
                        int lessonId = 0;
                        String sqlLesson = "INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', ?, ?, 'STANDARD', ?, ?)";
                        try (PreparedStatement ps = conn.prepareStatement(sqlLesson, Statement.RETURN_GENERATED_KEYS)) {
                            ps.setInt(1, lessonOrder);
                            ps.setNString(2, lessonEntry.getKey());
                            ps.setInt(3, chapterId);
                            ps.setInt(4, lessonOrder);
                            lessonOrder++;
                            ps.executeUpdate();
                            try (ResultSet rs = ps.getGeneratedKeys()) {
                                if (rs.next()) lessonId = rs.getInt(1);
                            }
                        }

                        String sqlPrompt = "INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, ?, ?, ?)";
                        try (PreparedStatement ps = conn.prepareStatement(sqlPrompt)) {
                            for (String[] row : lessonEntry.getValue()) {
                                String promptType = row[4];
                                String q = row[5];
                                String qSub = row[6];
                                String a = row[7];
                                String aSub = row[8];

                                String instruction = String.format("{\"question\": \"%s\", \"question_sub\": \"%s\", \"answer\": \"%s\", \"answer_sub\": \"%s\"}",
                                        escapeJson(q), escapeJson(qSub), escapeJson(a), escapeJson(aSub));

                                ps.setNString(1, instruction);
                                ps.setString(2, promptType);
                                ps.setInt(3, lessonId);
                                ps.addBatch();
                            }
                            ps.executeBatch();
                        }
                    }
                }
                System.out.println("Imported: " + courseTitle);
            }
            System.out.println("All data imported successfully using JDBC.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }

    private static List<String[]> parseCsv(File file) throws Exception {
        List<String[]> rows = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; }
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
