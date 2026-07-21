-- ============================================================
-- LUCY LMS — Seed Data
-- Run AFTER the application has started (tables auto-created by JPA)
-- ============================================================

USE Lucy;
GO

-- ============================================================
-- 0. Xóa sạch dữ liệu cũ để tránh lỗi trùng lặp khóa
-- ============================================================
-- Tắt kiểm tra khóa ngoại (Foreign Key)
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";
-- Xóa toàn bộ dữ liệu trong tất cả các bảng
EXEC sp_MSforeachtable "DELETE FROM ?";
-- Reset lại cột ID tự tăng (Identity) về 0
EXEC sp_MSforeachtable "IF OBJECTPROPERTY(OBJECT_ID('?'), 'TableHasIdentity') = 1 DBCC CHECKIDENT ('?', RESEED, 0)";
-- Bật lại kiểm tra khóa ngoại
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";
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

-- ── Default Login Accounts ──
-- Spring Boot creates these automatically. This MERGE keeps manual SQL seeding
-- compatible and does not overwrite an existing password or account balance.
MERGE INTO app_user AS target
USING (VALUES
    (N'admin@lucy.demo', N'Admin User', N'LucyAdmin', CAST(NULL AS NVARCHAR(100)), N'ADMIN', N'LEARNER', CAST(0 AS bit), 1000.0, 100, CAST(0 AS bit)),
    (N'learner@lucy.demo', N'Anonymous Learner', N'AnonymousPanda', N'CuriousPanda', N'LEARNER', N'LEARNER', CAST(1 AS bit), 50.0, 5, CAST(0 AS bit)),
    (N'miko@lucy.demo', N'Sensei Miko', N'SenseiMiko', CAST(NULL AS NVARCHAR(100)), N'PRO_MENTOR', N'PRO_MENTOR', CAST(0 AS bit), 500.0, 75, CAST(0 AS bit)),
    (N'max@lucy.demo', N'Studio Max', N'StudioMax', CAST(NULL AS NVARCHAR(100)), N'SUPER_CREATOR', N'CONTENT_CREATOR', CAST(0 AS bit), 800.0, 90, CAST(0 AS bit))
) AS source (
    email, full_name, display_name, avatar_persona, role, account_type,
    anonymous_mode, initial_credits, initial_reputation, pro_granted_by_admin
)
ON LOWER(target.email) = LOWER(source.email)
WHEN MATCHED THEN
    UPDATE SET
        target.role = source.role,
        target.account_type = source.account_type,
        target.registration_status = N'APPROVED',
        target.pro_granted_by_admin = source.pro_granted_by_admin,
        target.active = 1,
        target.full_name = COALESCE(NULLIF(target.full_name, N''), source.full_name),
        target.display_name = COALESCE(NULLIF(target.display_name, N''), source.display_name)
WHEN NOT MATCHED THEN
    INSERT (
        full_name, email, display_name, avatar_persona, role, account_type,
        registration_status, anonymous_mode, credit_balance, reputation_score,
        pro_granted_by_admin, created_at, active, password
    )
    VALUES (
        source.full_name, source.email, source.display_name, source.avatar_persona,
        source.role, source.account_type, N'APPROVED', source.anonymous_mode,
        source.initial_credits, source.initial_reputation, source.pro_granted_by_admin,
        GETDATE(), 1, N'123456'
    );

-- Every account has an independent Level 1 track in every language program.
MERGE INTO user_program_level AS target
USING (
    SELECT user_row.id AS user_id, program_row.id AS program_id
    FROM app_user AS user_row
    CROSS JOIN program AS program_row
) AS source
ON target.user_id = source.user_id AND target.program_id = source.program_id
WHEN NOT MATCHED THEN
    INSERT (user_id, program_id, level_number, experience_points, max_hosting_level)
    VALUES (source.user_id, source.program_id, 1, 0, 0);

-- The bundled mentor receives explicit course permissions instead of a global Pro flag.
MERGE INTO course_hosting_permission AS target
USING (
    SELECT user_row.id AS user_id, course_row.id AS course_id
    FROM app_user AS user_row
    CROSS JOIN course AS course_row
    WHERE LOWER(user_row.email) = N'miko@lucy.demo'
) AS source
ON target.user_id = source.user_id AND target.course_id = source.course_id
WHEN MATCHED THEN
    UPDATE SET status = N'APPROVED', grant_source = N'DEFAULT_ACCOUNT', reviewed_at = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (user_id, course_id, status, grant_source, requested_at, reviewed_at)
    VALUES (source.user_id, source.course_id, N'APPROVED', N'DEFAULT_ACCOUNT', GETDATE(), GETDATE());

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
INSERT INTO room (id, title, language_code, level_number, room_type, status, host_user_id, course_id, max_participants, started_at, description)
SELECT 1, N'English Beginner — Daily Conversation', N'EN', 1, N'PUBLIC', N'LIVE',
       id, 1, 20, GETDATE(), N'Practice everyday English conversation with SenseiMiko'
FROM app_user
WHERE email = N'miko@lucy.demo';
SET IDENTITY_INSERT room OFF;

PRINT 'Seed data inserted successfully.';
