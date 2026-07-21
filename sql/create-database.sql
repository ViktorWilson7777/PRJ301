-- ============================================================
-- LUCY LMS — Create Database Script
-- SQL Server
-- ============================================================

USE master;
GO

IF DB_ID(N'Lucy') IS NULL
BEGIN
    CREATE DATABASE Lucy;
    PRINT 'Database Lucy created successfully.';
END
ELSE
BEGIN
    PRINT 'Database Lucy already exists.';
END
GO

USE Lucy;
GO

PRINT 'Database Lucy is ready.';
