-- ============================================================
-- LUCY LMS — Seed Data
-- Run AFTER the application has started (tables auto-created by JPA)
-- ============================================================

USE Lucy;
GO

-- ── Programs (Languages) ──
SET IDENTITY_INSERT program ON;
INSERT INTO program (id, code, title, description, is_published) VALUES
(1, N'EN', N'English', N'English language learning program', 1),
(2, N'ZH', N'Chinese', N'中文学习项目 — Chinese language learning', 1),
(3, N'JA', N'Japanese', N'日本語学習 — Japanese language learning', 1);
SET IDENTITY_INSERT program OFF;

-- ── Courses (Stages) ──
SET IDENTITY_INSERT course ON;
INSERT INTO course (id, code, title, description, level, order_index, program_id) VALUES
(1, N'EN-S1', N'English Stage 1', N'Beginner English conversation', N'Beginner', 1, 1),
(2, N'EN-S2', N'English Stage 2', N'Intermediate English discussion', N'Intermediate', 2, 1),
(3, N'ZH-S1', N'Chinese Stage 1', N'初级中文会话', N'Beginner', 1, 2),
(4, N'JA-S1', N'Japanese Stage 1', N'初級日本語会話', N'Beginner', 1, 3);
SET IDENTITY_INSERT course OFF;

-- ── Users ──
SET IDENTITY_INSERT app_user ON;
INSERT INTO app_user (id, full_name, email, display_name, avatar_persona, role, anonymous_mode, credit_balance, reputation_score, created_at, active, password) VALUES
(1, N'Admin User', N'admin@lucy.demo', N'LucyAdmin', NULL, N'ADMIN', 0, 1000.0, 100, GETDATE(), 1, N'123456'),
(2, N'Anonymous Learner', N'learner@lucy.demo', N'AnonymousPanda', N'CuriousPanda🐼', N'LEARNER', 1, 50.0, 5, GETDATE(), 1, N'123456'),
(3, N'Sensei Miko', N'miko@lucy.demo', N'SenseiMiko', NULL, N'PRO_MENTOR', 0, 500.0, 75, GETDATE(), 1, N'123456'),
(4, N'Studio Max', N'max@lucy.demo', N'StudioMax', NULL, N'SUPER_CREATOR', 0, 800.0, 90, GETDATE(), 1, N'123456');
SET IDENTITY_INSERT app_user OFF;

-- ── Billing Plans ──
SET IDENTITY_INSERT billing_plan ON;
INSERT INTO billing_plan (id, name, price, monthly_ai_limit, monthly_import_limit, max_room_participants, allow_podcast_recording, active) VALUES
(1, N'Free', 0.00, 5, 2, 10, 0, 1),
(2, N'Pro', 9.99, 50, 20, 30, 0, 1),
(3, N'Super', 19.99, 200, 100, 100, 1, 1);
SET IDENTITY_INSERT billing_plan OFF;

-- ── Gifts ──
SET IDENTITY_INSERT gift ON;
INSERT INTO gift (id, name, icon, credit_cost, active) VALUES
(1, N'Star', N'⭐', 10, 1),
(2, N'Coffee', N'☕', 25, 1),
(3, N'Firework', N'🎆', 50, 1),
(4, N'Rose', N'🌹', 15, 1),
(5, N'Diamond', N'💎', 100, 1);
SET IDENTITY_INSERT gift OFF;

-- ── Sample Room ──
SET IDENTITY_INSERT room ON;
INSERT INTO room (id, title, language_code, level_number, room_type, status, host_user_id, course_id, max_participants, started_at, description) VALUES
(1, N'English Beginner — Daily Conversation', N'EN', 1, N'PUBLIC', N'LIVE', 3, 1, 20, GETDATE(), N'Practice everyday English conversation with SenseiMiko');
SET IDENTITY_INSERT room OFF;

PRINT 'Seed data inserted successfully.';
