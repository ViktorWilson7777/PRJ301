-- ============================================================
-- LUCY LMS — Create Database Script
-- SQL Server
-- ============================================================

-- Create database (run in master context)
-- USE master;
-- GO
-- IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Lucy')
-- BEGIN
--     CREATE DATABASE Lucy
--     COLLATE Latin1_General_100_CI_AS_SC_UTF8;
-- END
-- GO

-- NOTE: If your SQL Server does not support UTF8 collation,
-- use the default collation. NVARCHAR columns handle Unicode regardless.

CREATE DATABASE Lucy;
GO

USE Lucy;
GO

PRINT 'Database Lucy created successfully.';
