-- ============================================================
-- LUCY LMS — Reset Import Data
-- Use to clear imported content and re-import fresh
-- Delete order respects foreign key constraints
-- ============================================================

USE Lucy;
GO

-- 1. Delete AI generated questions
DELETE FROM ai_generated_question;
PRINT 'Deleted ai_generated_question';

-- 2. Delete AI prompt templates
DELETE FROM ai_prompt_template;
PRINT 'Deleted ai_prompt_template';

-- 3. Delete lessons
DELETE FROM lesson;
PRINT 'Deleted lesson';

-- 4. Delete chapters
DELETE FROM chapter;
PRINT 'Deleted chapter';

-- 5. Delete import files
DELETE FROM import_file;
PRINT 'Deleted import_file';

PRINT 'Reset complete. You can now re-import DOCX files.';
