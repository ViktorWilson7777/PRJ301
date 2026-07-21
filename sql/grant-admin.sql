-- ============================================================
-- LUCY LMS — Cấp quyền Admin & cập nhật password cho tài khoản cũ
-- Chạy script này nếu database đã tồn tại trước khi có cột password
-- ============================================================

USE Lucy;
GO

-- Bước 1: Thêm cột password nếu chưa có
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'app_user' AND COLUMN_NAME = 'password'
)
BEGIN
    ALTER TABLE app_user ADD password NVARCHAR(255) NULL;
    PRINT 'Đã thêm cột password.';
END
GO

-- Bước 2: Cập nhật password = '123456' cho tất cả user hiện tại chưa có password
UPDATE app_user SET password = N'123456' WHERE password IS NULL;
GO

-- Bước 3: Đảm bảo tài khoản admin@lucy.demo tồn tại và có role ADMIN
IF NOT EXISTS (SELECT 1 FROM app_user WHERE email = N'admin@lucy.demo')
BEGIN
    INSERT INTO app_user (full_name, email, display_name, avatar_persona, role, anonymous_mode, credit_balance, reputation_score, created_at, active, password)
    VALUES (N'Admin User', N'admin@lucy.demo', N'LucyAdmin', NULL, N'ADMIN', 0, 1000.0, 100, GETDATE(), 1, N'123456');
    PRINT 'Đã tạo tài khoản admin mới.';
END
ELSE
BEGIN
    -- Keep the role active without resetting a password that was already changed.
    UPDATE app_user 
    SET role = N'ADMIN', password = COALESCE(password, N'123456'), active = 1
    WHERE email = N'admin@lucy.demo';
    PRINT 'Đã cập nhật tài khoản admin.';
END
GO

-- Bước 4: Xem kết quả
SELECT id, full_name, email, display_name, role, credit_balance, active, password
FROM app_user
WHERE role = 'ADMIN';

PRINT 'Hoàn tất. Đăng nhập: admin@lucy.demo / 123456';
