-- ============================================================
-- LUCY LMS — Level-Based Room System - Extended Seed Data
-- Adds chapters & lessons with level_number for 100-level system
-- Run AFTER the main seed-data.sql
-- ============================================================

USE Lucy;
GO

-- ── Chapters for English Stage 1 (Course ID = 1) ──
SET IDENTITY_INSERT chapter ON;
INSERT INTO chapter (id, title, description, order_index, course_id) VALUES
(1, N'Greetings & Introductions', N'Learn basic greetings and self-introductions', 1, 1),
(2, N'Daily Routines', N'Talk about everyday activities', 2, 1),
(3, N'Shopping & Numbers', N'Practice shopping vocabulary and numbers', 3, 1),
(4, N'Travel & Directions', N'Navigate conversations about travel', 4, 1);
SET IDENTITY_INSERT chapter OFF;

-- ── Chapters for English Stage 2 (Course ID = 2) ──
SET IDENTITY_INSERT chapter ON;
INSERT INTO chapter (id, title, description, order_index, course_id) VALUES
(5, N'Opinions & Debate', N'Express and discuss opinions', 1, 2),
(6, N'Work & Business', N'Professional English conversations', 2, 2);
SET IDENTITY_INSERT chapter OFF;

-- ── Lessons with Level Numbers ──
SET IDENTITY_INSERT lesson ON;
INSERT INTO lesson (id, type, title, description, order_index, level_number, content_data, chapter_id) VALUES
-- Chapter 1: Greetings (Level 1-3)
(1, N'DOCUMENT', N'Hello & Goodbye', N'Basic greetings: Hello, Hi, Goodbye, See you', 1, 1, N'{"slides":["Hello!","Goodbye!"]}', 1),
(2, N'DOCUMENT', N'My Name Is...', N'Introduce yourself: My name is..., I am from...', 2, 1, N'{"slides":["My name is...","Nice to meet you"]}', 1),
(3, N'QUIZ', N'Greeting Practice', N'Practice greeting phrases in conversation', 3, 2, N'{"questions":["How do you greet someone?"]}', 1),
(4, N'DOCUMENT', N'Asking About Others', N'Questions: What is your name? Where are you from?', 4, 2, NULL, 1),
(5, N'QUIZ', N'Introduction Role Play', N'Role play introducing yourself and asking about others', 5, 3, NULL, 1),

-- Chapter 2: Daily Routines (Level 3-5)
(6, N'DOCUMENT', N'Morning Routine', N'Wake up, brush teeth, have breakfast', 1, 3, N'{"slides":["I wake up at 7am"]}', 2),
(7, N'DOCUMENT', N'Afternoon Activities', N'Work, study, exercise, lunch', 2, 4, NULL, 2),
(8, N'QUIZ', N'Daily Schedule', N'Describe your daily schedule', 3, 4, NULL, 2),
(9, N'DOCUMENT', N'Evening & Night', N'Dinner, hobbies, sleep', 4, 5, NULL, 2),
(10, N'QUIZ', N'Routine Conversation', N'Full conversation about daily routines', 5, 5, NULL, 2),

-- Chapter 3: Shopping (Level 5-8)
(11, N'DOCUMENT', N'Numbers 1-100', N'Learn numbers from 1 to 100', 1, 5, NULL, 3),
(12, N'DOCUMENT', N'At the Store', N'Shopping vocabulary: buy, sell, price, discount', 2, 6, NULL, 3),
(13, N'QUIZ', N'Price Negotiation', N'Practice asking and negotiating prices', 3, 7, NULL, 3),
(14, N'DOCUMENT', N'Online Shopping', N'Vocabulary for online shopping', 4, 8, NULL, 3),

-- Chapter 4: Travel (Level 8-10)
(15, N'DOCUMENT', N'At the Airport', N'Airport vocabulary and phrases', 1, 8, NULL, 4),
(16, N'DOCUMENT', N'Asking Directions', N'How to ask and give directions', 2, 9, NULL, 4),
(17, N'QUIZ', N'Travel Conversation', N'Full travel scenario conversation', 3, 10, NULL, 4),

-- Chapter 5: Opinions (Level 15-20)
(18, N'DOCUMENT', N'Expressing Opinions', N'I think..., In my opinion..., I believe...', 1, 15, NULL, 5),
(19, N'DOCUMENT', N'Agreeing & Disagreeing', N'I agree with..., I disagree because...', 2, 17, NULL, 5),
(20, N'QUIZ', N'Debate Practice', N'Practice debating a given topic', 3, 20, NULL, 5),

-- Chapter 6: Work (Level 20-25)
(21, N'DOCUMENT', N'Job Interview', N'Common interview questions and answers', 1, 20, NULL, 6),
(22, N'DOCUMENT', N'Workplace Communication', N'Email, meeting, presentation vocabulary', 2, 22, NULL, 6),
(23, N'QUIZ', N'Business Role Play', N'Role play a business meeting scenario', 3, 25, NULL, 6);
SET IDENTITY_INSERT lesson OFF;

-- ── Sample Rooms at different levels ──
-- Room 1 already exists at Level 1, let's add more
SET IDENTITY_INSERT room ON;
INSERT INTO room (id, title, language_code, level_number, room_type, status, host_user_id, course_id, chapter_id, max_participants, started_at, description) VALUES
(2, N'EN Greetings Practice — Level 2', N'EN', 2, N'PUBLIC', N'LIVE', 3, 1, 1, 20, GETDATE(), N'Practice basic greetings at Level 2'),
(3, N'Daily Routines Talk — Level 5', N'EN', 5, N'PUBLIC', N'LIVE', 3, 1, 2, 15, GETDATE(), N'Talk about daily activities at Level 5'),
(4, N'Shopping English — Level 7', N'EN', 7, N'PRO_CLASS', N'SCHEDULED', 4, 1, 3, 10, NULL, N'Learn shopping vocabulary at Level 7'),
(5, N'Travel Conversation — Level 10', N'EN', 10, N'PUBLIC', N'LIVE', 3, 1, 4, 20, GETDATE(), N'Practice travel English at Level 10'),
(6, N'Debate Club — Level 20', N'EN', 20, N'PREMIUM', N'SCHEDULED', 4, 2, 5, 12, NULL, N'Advanced debate practice at Level 20');
SET IDENTITY_INSERT room OFF;

-- Update existing Room 1 to have chapter
UPDATE room SET chapter_id = 1 WHERE id = 1;

PRINT 'Level-based seed data inserted successfully.';
