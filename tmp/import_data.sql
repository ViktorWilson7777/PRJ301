BEGIN TRANSACTION;
DECLARE @CourseId INT, @ChapterId INT, @LessonId INT, @ProgId INT;

-- Course: Chinese_level_1-30_LucyLMS_Ready
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'Chinese';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('CHI', N'', 1, 1, N'Chinese_level_1-30_LucyLMS_Ready', 'Chinese', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 1 | 介绍
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 1 | 介绍', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你叫什么名字？", "question_sub": "nǐ jiào shénme míngzi?", "answer": "我叫……", "answer_sub": "wǒ jiào ……"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你是哪国人？", "question_sub": "nǐ shì nǎ guó rén?", "answer": "我是越南人。", "answer_sub": "wǒ shì yuènán rén"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你是哪国人？", "question_sub": "nǐ shì nǎ guó rén?", "answer": "我是中国人。", "answer_sub": "wǒ shì zhōngguó rén"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你做什么工作？", "question_sub": "nǐ zuò shénme gōngzuò?", "answer": "我是学生。", "answer_sub": "wǒ shì xuéshēng"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你做什么工作？", "question_sub": "nǐ zuò shénme gōngzuò?", "answer": "我是老师。", "answer_sub": "wǒ shì lǎoshī"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在哪儿工作/学习？", "question_sub": "nǐ zài nǎr gōngzuò / xuéxí?", "answer": "我在学校学习。", "answer_sub": "wǒ zài xuéxiào xuéxí"}', 'practice', @LessonId);

  -- Chapter: LEVEL 2 | 我的家
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 2 | 我的家', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你家有几口人？", "question_sub": "nǐ jiā yǒu jǐ kǒu rén?", "answer": "我家有四口人。", "answer_sub": "wǒ jiā yǒu sì kǒu rén"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你爸爸做什么？", "question_sub": "nǐ bàba zuò shénme?", "answer": "我爸爸是医生。他在医院工作。", "answer_sub": "wǒ bàba shì yīshēng. tā zài yīyuàn gōngzuò"}', 'discussion', @LessonId);

  -- Chapter: LEVEL 3 | 我的朋友
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 3 | 我的朋友', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有好朋友吗？", "question_sub": "nǐ yǒu hǎo péngyou ma?", "answer": "我有一个好朋友。", "answer_sub": "wǒ yǒu yí gè hǎo péngyou"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有好朋友吗？", "question_sub": "nǐ yǒu hǎo péngyou ma?", "answer": "我有很多朋友。", "answer_sub": "wǒ yǒu hěn duō péngyou"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她是哪国人？", "question_sub": "tā shì nǎ guó rén?", "answer": "他/她是越南人。", "answer_sub": "tā shì yuènán rén"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她是哪国人？", "question_sub": "tā shì nǎ guó rén?", "answer": "他/她是中国人。", "answer_sub": "tā shì zhōngguó rén"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她叫什么名字？", "question_sub": "tā jiào shénme míngzi?", "answer": "她叫……", "answer_sub": "tā jiào ……"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她今年多大？", "question_sub": "tā jīnnián duō dà?", "answer": "她今年……岁。", "answer_sub": "tā jīnnián …… suì"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她是学生吗？", "question_sub": "tā shì xuéshēng ma?", "answer": "是，他/她是学生。", "answer_sub": "shì, tā shì xuéshēng"}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她是学生吗？", "question_sub": "tā shì xuéshēng ma?", "answer": "不是，她不是学生。他/她是……", "answer_sub": "bú shì, tā bú shì xuéshēng. tā shì ……"}', 'wrapup', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她在哪儿学习/工作？", "question_sub": "tā zài nǎr xuéxí / gōngzuò?", "answer": "他/她在学校学习。", "answer_sub": "tā zài xuéxiào xuéxí"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她在哪儿学习/工作？", "question_sub": "tā zài nǎr xuéxí / gōngzuò?", "answer": "他/她在公司工作。", "answer_sub": "tā zài gōngsī gōngzuò"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 7
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 7, N'SUBLEVEL 7', 'STANDARD', @ChapterId, 7);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你们做什么？", "question_sub": "nǐmen zuò shénme?", "answer": "我们一起学习汉语。", "answer_sub": "wǒmen yìqǐ xuéxí hànyǔ"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你们做什么？", "question_sub": "nǐmen zuò shénme?", "answer": "我们一起吃饭。", "answer_sub": "wǒmen yìqǐ chīfàn"}', 'practice', @LessonId);

  -- Chapter: LEVEL 4 | 李老师的女儿
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 4 | 李老师的女儿', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "李老师的女儿叫什么名字？", "question_sub": "lǐ lǎoshī de nǚ''ér jiào shénme míngzi?", "answer": "她叫……", "answer_sub": "tā jiào ……"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "她今年多大？", "question_sub": "tā jīnnián duō dà?", "answer": "她今年……岁。", "answer_sub": "tā jīnnián …… suì"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "她做什么工作？", "question_sub": "tā zuò shénme gōngzuò?", "answer": "她是学生。", "answer_sub": "tā shì xuéshēng"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "她做什么工作？", "question_sub": "tā zuò shénme gōngzuò?", "answer": "她是……", "answer_sub": "tā shì ……"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "她在哪儿学习/工作？", "question_sub": "tā zài nǎr xuéxí / gōngzuò?", "answer": "她在学校学习。", "answer_sub": "tā zài xuéxiào xuéxí"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "她在哪儿学习/工作？", "question_sub": "tā zài nǎr xuéxí / gōngzuò?", "answer": "她在公司工作。", "answer_sub": "tā zài gōngsī gōngzuò"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你知道李老师的女儿喜欢什么吗？", "question_sub": "nǐ zhīdào lǐ lǎoshī de nǚ''ér xǐhuan shénme ma?", "answer": "不知道。", "answer_sub": "bù zhīdào"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 5 | 我的学校
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 5 | 我的学校', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校大吗？", "question_sub": "nǐ de xuéxiào dà ma?", "answer": "很大。", "answer_sub": "hěn dà"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校大吗？", "question_sub": "nǐ de xuéxiào dà ma?", "answer": "不太大。", "answer_sub": "bú tài dà"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点去学校？", "question_sub": "nǐ jǐ diǎn qù xuéxiào?", "answer": "上午八点。", "answer_sub": "shàngwǔ bā diǎn"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点去学校？", "question_sub": "nǐ jǐ diǎn qù xuéxiào?", "answer": "上午九点。", "answer_sub": "shàngwǔ jiǔ diǎn"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么学什么？", "question_sub": "nǐ xǐhuān xué shénme?", "answer": "我喜欢学汉语。", "answer_sub": "wǒ xǐhuān xué hànyǔ"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么学什么？", "question_sub": "nǐ xǐhuān xué shénme?", "answer": "我喜欢学英语。", "answer_sub": "wǒ xǐhuān xué yīngyǔ"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有多少学生？", "question_sub": "nǐ de xuéxiào yǒu duōshao xuéshēng?", "answer": "有很多学生。", "answer_sub": "yǒu hěn duō xuéshēng"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有多少学生？", "question_sub": "nǐ de xuéxiào yǒu duōshao xuéshēng?", "answer": "有一千多个学生。", "answer_sub": "yǒu yì qiān duō gè xuéshēng"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有哪国老师？", "question_sub": "nǐ de xuéxiào yǒu nǎ guó lǎoshī?", "answer": "有中国老师。", "answer_sub": "yǒu zhōngguó lǎoshī"}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有哪国老师？", "question_sub": "nǐ de xuéxiào yǒu nǎ guó lǎoshī?", "answer": "也有越南老师。", "answer_sub": "yě yǒu yuènán lǎoshī"}', 'wrapup', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有哪国学生？", "question_sub": "nǐ de xuéxiào yǒu nǎ guó xuéshēng?", "answer": "有越南学生。", "answer_sub": "yǒu yuènán xuéshēng"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校有哪国学生？", "question_sub": "nǐ de xuéxiào yǒu nǎ guó xuéshēng?", "answer": "也有中国学生。", "answer_sub": "yě yǒu zhōngguó xuéshēng"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 7
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 7, N'SUBLEVEL 7', 'STANDARD', @ChapterId, 7);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校里有商店吗？", "question_sub": "nǐ de xuéxiào lǐ yǒu shāngdiàn ma?", "answer": "有。", "answer_sub": "yǒu"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的学校里有商店吗？", "question_sub": "nǐ de xuéxiào lǐ yǒu shāngdiàn ma?", "answer": "没有。", "answer_sub": "méi yǒu"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 8
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 8, N'SUBLEVEL 8', 'STANDARD', @ChapterId, 8);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学校的前面有什么？", "question_sub": "xuéxiào de qiánmiàn yǒu shénme?", "answer": "有咖啡店。", "answer_sub": "yǒu kāfēidiàn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学校的前面有什么？", "question_sub": "xuéxiào de qiánmiàn yǒu shénme?", "answer": "有书店。", "answer_sub": "yǒu shūdiàn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学校的前面有什么？", "question_sub": "xuéxiào de qiánmiàn yǒu shénme?", "answer": "有商店。", "answer_sub": "yǒu shāngdiàn"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 9
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 9, N'SUBLEVEL 9', 'STANDARD', @ChapterId, 9);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你爱你的学校吗？", "question_sub": "nǐ ài nǐ de xuéxiào ma?", "answer": "爱。", "answer_sub": "ài"}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你爱你的学校吗？", "question_sub": "nǐ ài nǐ de xuéxiào ma?", "answer": "很爱。", "answer_sub": "hěn ài"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 6 | 东西在哪儿？
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 6 | 东西在哪儿？', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的电脑/汉语书/杯子在哪儿？", "question_sub": "nǐ de diànnǎo / hànyǔ shū / bēizi zài nǎr?", "answer": "我的电脑在桌子上。", "answer_sub": "wǒ de diànnǎo zài zhuōzi shàng"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的电脑/汉语书/杯子在哪儿？", "question_sub": "nǐ de diànnǎo / hànyǔ shū / bēizi zài nǎr?", "answer": "我的汉语书在桌子上。", "answer_sub": "wǒ de hànyǔ shū zài zhuōzi shàng"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的电脑/汉语书/杯子在哪儿？", "question_sub": "nǐ de diànnǎo / hànyǔ shū / bēizi zài nǎr?", "answer": "我的杯子在椅子下面。", "answer_sub": "wǒ de bēizi zài yǐzi xiàmiàn"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "桌子上有什么？", "question_sub": "zhuōzi shàng yǒu shénme?", "answer": "桌子上有一本书和一台电脑。", "answer_sub": "zhuōzi shàng yǒu yì běn shū hé yì tái diànnǎo"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "桌子上有汉语书吗？", "question_sub": "zhuōzi shàng yǒu hànyǔ shū ma?", "answer": "有。", "answer_sub": "yǒu"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 7 | 喝茶
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 7 | 喝茶', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢喝哪国茶？", "question_sub": "nǐ xǐhuān hē nǎ guó chá?", "answer": "我喜欢中国茶。", "answer_sub": "wǒ xǐhuān zhōngguó chá"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢喝哪国茶？", "question_sub": "nǐ xǐhuān hē nǎ guó chá?", "answer": "我喜欢越南茶。", "answer_sub": "wǒ xǐhuān yuènán chá"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哪种茶好喝？", "question_sub": "nǎ zhǒng chá hǎohē?", "answer": "中国茶很好喝。", "answer_sub": "zhōngguó chá hěn hǎohē"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哪种茶好喝？", "question_sub": "nǎ zhǒng chá hǎohē?", "answer": "越南茶很好喝。", "answer_sub": "yuènán chá hěn hǎohē"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候喝茶？", "question_sub": "nǐ shénme shíhou hē chá?", "answer": "我上午喝茶。", "answer_sub": "wǒ shàngwǔ hē chá"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候喝茶？", "question_sub": "nǐ shénme shíhou hē chá?", "answer": "我中午喝茶。", "answer_sub": "wǒ zhōngwǔ hē chá"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候喝茶？", "question_sub": "nǐ shénme shíhou hē chá?", "answer": "我吃饭后喝茶。", "answer_sub": "wǒ chīfàn hòu hē chá"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和谁喝茶？", "question_sub": "nǐ hé shéi hē chá?", "answer": "我和朋友一起喝茶。", "answer_sub": "wǒ hé péngyou yìqǐ hē chá"}', 'practice', @LessonId);

  -- Chapter: LEVEL 8 | 你喜欢做什么？
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 8 | 你喜欢做什么？', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢做什么？", "question_sub": "nǐ xǐhuān zuò shénme?", "answer": "我喜欢看电影。", "answer_sub": "wǒ xǐhuān kàn diànyǐng"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢做什么？", "question_sub": "nǐ xǐhuān zuò shénme?", "answer": "我喜欢看电视。", "answer_sub": "wǒ xǐhuān kàn diànshì"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢做什么？", "question_sub": "nǐ xǐhuān zuò shénme?", "answer": "我喜欢去旅游。", "answer_sub": "wǒ xǐhuān qù lǚyóu"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢做什么？", "question_sub": "nǐ xǐhuān zuò shénme?", "answer": "我喜欢看书。", "answer_sub": "wǒ xǐhuān kàn shū"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢做什么？", "question_sub": "nǐ xǐhuān zuò shénme?", "answer": "我喜欢做越南菜。", "answer_sub": "wǒ xǐhuān zuò yuènán cài"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么喜欢？", "question_sub": "wèishénme xǐhuān?", "answer": "因为很有意思。", "answer_sub": "yīnwèi hěn yǒuyìsi"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么喜欢？", "question_sub": "wèishénme xǐhuān?", "answer": "因为看电视、看书对学习汉语有帮助。", "answer_sub": "yīnwèi kàn diànshì, kàn shū duì xuéxí hànyǔ yǒu bāngzhù"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候看电影/看电视/看书？", "question_sub": "nǐ shénme shíhou kàn diànyǐng / kàn diànshì / kàn shū?", "answer": "星期六/星期天。", "answer_sub": "xīngqīliù / xīngqītiān"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候看电影/看电视/看书？", "question_sub": "nǐ shénme shíhou kàn diànyǐng / kàn diànshì / kàn shū?", "answer": "上午/中午/下午/晚上。", "answer_sub": "shàngwǔ / zhōngwǔ / xiàwǔ / wǎnshang"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 9 | 你每天做什么？
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 9 | 你每天做什么？', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点起床？", "question_sub": "nǐ jǐ diǎn qǐchuáng?", "answer": "我七点起床。", "answer_sub": "wǒ qī diǎn qǐchuáng"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点起床？", "question_sub": "nǐ jǐ diǎn qǐchuáng?", "answer": "我六点起床。", "answer_sub": "wǒ liù diǎn qǐchuáng"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你早上做什么？", "question_sub": "nǐ zǎoshang zuò shénme?", "answer": "我吃早饭。", "answer_sub": "wǒ chī zǎofàn"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你早上做什么？", "question_sub": "nǐ zǎoshang zuò shénme?", "answer": "我去学校。", "answer_sub": "wǒ qù xuéxiào"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你早上/中午/晚上几点吃饭？在哪儿吃？", "question_sub": "nǐ zǎoshang / zhōngwǔ / wǎnshang jǐ diǎn chīfàn? zài nǎr chī?", "answer": "我中午十一点吃饭。", "answer_sub": "wǒ zhōngwǔ shíyī diǎn chīfàn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你早上/中午/晚上几点吃饭？在哪儿吃？", "question_sub": "nǐ zǎoshang / zhōngwǔ / wǎnshang jǐ diǎn chīfàn? zài nǎr chī?", "answer": "我在家/学校吃饭。", "answer_sub": "wǒ zài jiā / xuéxiào chīfàn"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "晚上做什么？", "question_sub": "wǎnshang zuò shénme?", "answer": "我看书。", "answer_sub": "wǒ kàn shū"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "晚上做什么？", "question_sub": "wǎnshang zuò shénme?", "answer": "我看电视。", "answer_sub": "wǒ kàn diànshì"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "晚上做什么？", "question_sub": "wǎnshang zuò shénme?", "answer": "我学习汉语。", "answer_sub": "wǒ xuéxí hànyǔ"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点睡觉？", "question_sub": "nǐ jǐ diǎn shuìjiào?", "answer": "我十点睡觉。", "answer_sub": "wǒ shí diǎn shuìjiào"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 10 | 吃饭
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 10 | 吃饭', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢吃什么？", "question_sub": "nǐ xǐhuān chī shénme?", "answer": "我喜欢吃米饭。", "answer_sub": "wǒ xǐhuān chī mǐfàn"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢吃什么？", "question_sub": "nǐ xǐhuān chī shénme?", "answer": "我喜欢吃面条。", "answer_sub": "wǒ xǐhuān chī miàntiáo"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢吃什么？", "question_sub": "nǐ xǐhuān chī shénme?", "answer": "我喜欢吃羊肉。", "answer_sub": "wǒ xǐhuān chī yángròu"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你会做什么菜？", "question_sub": "nǐ huì zuò shénme cài?", "answer": "我会做越南菜/中国菜/美国菜。", "answer_sub": "wǒ huì zuò yuènán cài / zhōngguó cài / měiguó cài"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你会做什么菜？", "question_sub": "nǐ huì zuò shénme cài?", "answer": "我不会做饭。", "answer_sub": "wǒ bú huì zuòfàn"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你家谁做饭？", "question_sub": "nǐ jiā shéi zuòfàn?", "answer": "我做饭。", "answer_sub": "wǒ zuòfàn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你家谁做饭？", "question_sub": "nǐ jiā shéi zuòfàn?", "answer": "我妈妈做饭。", "answer_sub": "wǒ māma zuòfàn"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在哪儿吃？", "question_sub": "nǐ zài nǎr chī?", "answer": "我在家吃。", "answer_sub": "wǒ zài jiā chī"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在哪儿吃？", "question_sub": "nǐ zài nǎr chī?", "answer": "我在外面吃。", "answer_sub": "wǒ zài wàimiàn chī"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你饭后吃水果吗？", "question_sub": "nǐ fànhòu chī shuǐguǒ ma?", "answer": "吃饭后，我吃水果。", "answer_sub": "chīfàn hòu, wǒ chī shuǐguǒ"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 11 | 买东西
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 11 | 买东西', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你经常去哪儿买东西？", "question_sub": "nǐ jīngcháng qù nǎr mǎi dōngxi?", "answer": "我去商店买东西。", "answer_sub": "wǒ qù shāngdiàn mǎi dōngxi"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你经常去哪儿买东西？", "question_sub": "nǐ jīngcháng qù nǎr mǎi dōngxi?", "answer": "我在网上买东西。", "answer_sub": "wǒ zài wǎngshàng mǎi dōngxi"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢买什么？", "question_sub": "nǐ xǐhuān mǎi shénme?", "answer": "我喜欢买衣服/手表。", "answer_sub": "wǒ xǐhuān mǎi yīfu / shǒubiǎo"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢买什么？", "question_sub": "nǐ xǐhuān mǎi shénme?", "answer": "我喜欢买好吃的东西。", "answer_sub": "wǒ xǐhuān mǎi hǎochī de dōngxi"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候去买东西？", "question_sub": "nǐ shénme shíhou qù mǎi dōngxi?", "answer": "星期六/星期天。", "answer_sub": "xīngqīliù / xīngqītiān"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候去买东西？", "question_sub": "nǐ shénme shíhou qù mǎi dōngxi?", "answer": "上午/中午/下午/晚上。", "answer_sub": "shàngwǔ / zhōngwǔ / xiàwǔ / wǎnshang"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 12 | 时间
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 12 | 时间', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天几月几号？", "question_sub": "jīntiān jǐ yuè jǐ hào?", "answer": "今天四月六号。", "answer_sub": "jīntiān sì yuè liù hào"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "现在几点？", "question_sub": "xiànzài jǐ diǎn?", "answer": "现在下午三点。", "answer_sub": "xiànzài xiàwǔ sān diǎn"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "现在几点？", "question_sub": "xiànzài jǐ diǎn?", "answer": "现在中午十二点半。", "answer_sub": "xiànzài zhōngwǔ shí''èr diǎn bàn"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点起床/睡觉/吃早饭/午饭？", "question_sub": "nǐ jǐ diǎn qǐchuáng / shuìjiào / chī zǎofàn / chī wǔfàn?", "answer": "我十一点。", "answer_sub": "wǒ shíyī diǎn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你几点起床/睡觉/吃早饭/午饭？", "question_sub": "nǐ jǐ diǎn qǐchuáng / shuìjiào / chī zǎofàn / chī wǔfàn?", "answer": "我十点。", "answer_sub": "wǒ shí diǎn"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 13 | 天气
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 13 | 天气', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天天气怎么样？", "question_sub": "jīntiān tiānqì zěnmeyàng?", "answer": "很热。", "answer_sub": "hěn rè"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天天气怎么样？", "question_sub": "jīntiān tiānqì zěnmeyàng?", "answer": "很冷。", "answer_sub": "hěn lěng"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天天气怎么样？", "question_sub": "jīntiān tiānqì zěnmeyàng?", "answer": "不太热。", "answer_sub": "bú tài rè"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天天气怎么样？", "question_sub": "jīntiān tiānqì zěnmeyàng?", "answer": "不冷也不热。", "answer_sub": "bù lěng yě bù rè"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么天气？", "question_sub": "nǐ xǐhuān shénme tiānqì?", "answer": "我喜欢冷/热的天气。", "answer_sub": "wǒ xǐhuān lěng / rè de tiānqì"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么天气？", "question_sub": "nǐ xǐhuān shénme tiānqì?", "answer": "我喜欢晴天。", "answer_sub": "wǒ xǐhuān qíngtiān"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "下雨天你做什么？", "question_sub": "xiàyǔ tiān nǐ zuò shénme?", "answer": "我在家看电影。", "answer_sub": "wǒ zài jiā kàn diànyǐng"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 14 | 怎么去？
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 14 | 怎么去？', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你会开车吗？", "question_sub": "nǐ huì kāichē ma?", "answer": "我会开车。", "answer_sub": "wǒ huì kāichē"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你会开车吗？", "question_sub": "nǐ huì kāichē ma?", "answer": "我不会开车。", "answer_sub": "wǒ bú huì kāichē"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么去学校/北京/……？", "question_sub": "nǐ zěnme qù xuéxiào / Běijīng /…?", "answer": "我坐出租车去。", "answer_sub": "wǒ zuò chūzūchē qù"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么去学校/北京/……？", "question_sub": "nǐ zěnme qù xuéxiào / Běijīng /…?", "answer": "我坐公共汽车去。", "answer_sub": "wǒ zuò gōnggòngqìchē qù"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "要多长时间？", "question_sub": "yào duō cháng shíjiān?", "answer": "要二十分钟。", "answer_sub": "yào èrshí fēnzhōng"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "要多长时间？", "question_sub": "yào duō cháng shíjiān?", "answer": "要一个小时。", "answer_sub": "yào yí gè xiǎoshí"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你为什么不开车来学校？", "question_sub": "nǐ wèishénme bù kāichē lái xuéxiào?", "answer": "我不会开车。", "answer_sub": "wǒ bú huì kāichē"}', 'practice', @LessonId);

  -- Chapter: LEVEL 15 | 看电影
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 15 | 看电影', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢看电影吗？", "question_sub": "nǐ xǐhuān kàn diànyǐng ma?", "answer": "很喜欢。", "answer_sub": "hěn xǐhuān"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢看电影吗？", "question_sub": "nǐ xǐhuān kàn diànyǐng ma?", "answer": "不喜欢。", "answer_sub": "bù xǐhuān"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢哪国电影？", "question_sub": "nǐ xǐhuān nǎ guó diànyǐng?", "answer": "我喜欢中国电影。", "answer_sub": "wǒ xǐhuān zhōngguó diànyǐng"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢哪国电影？", "question_sub": "nǐ xǐhuān nǎ guó diànyǐng?", "answer": "我喜欢越南电影。", "answer_sub": "wǒ xǐhuān yuènán diànyǐng"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和谁一起看电影？", "question_sub": "nǐ hé shéi yìqǐ kàn diànyǐng?", "answer": "和朋友/同学。", "answer_sub": "hé péngyou / tóngxué"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 16 | 运动
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 16 | 运动', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢运动吗？", "question_sub": "nǐ xǐhuān yùndòng ma?", "answer": "喜欢。", "answer_sub": "xǐhuān"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢运动吗？", "question_sub": "nǐ xǐhuān yùndòng ma?", "answer": "不太喜欢。", "answer_sub": "bú tài xǐhuān"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么运动？", "question_sub": "nǐ xǐhuān shénme yùndòng?", "answer": "我喜欢跑步。", "answer_sub": "wǒ xǐhuān pǎobù"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么运动？", "question_sub": "nǐ xǐhuān shénme yùndòng?", "answer": "我喜欢打篮球。", "answer_sub": "wǒ xǐhuān dǎ lánqiú"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么运动？", "question_sub": "nǐ xǐhuān shénme yùndòng?", "answer": "我喜欢踢足球。", "answer_sub": "wǒ xǐhuān tī zúqiú"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候去运动？", "question_sub": "nǐ shénme shíhou qù yùndòng?", "answer": "每天。", "answer_sub": "měitiān"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候去运动？", "question_sub": "nǐ shénme shíhou qù yùndòng?", "answer": "星期六/星期天。", "answer_sub": "xīngqīliù / xīngqītiān"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 17 | 工作
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 17, N'LEVEL 17 | 工作', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你做什么工作？", "question_sub": "nǐ zuò shénme gōngzuò?", "answer": "我是老师。", "answer_sub": "wǒ shì lǎoshī"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你做什么工作？", "question_sub": "nǐ zuò shénme gōngzuò?", "answer": "我是学生。", "answer_sub": "wǒ shì xuéshēng"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的工作忙吗？", "question_sub": "nǐ de gōngzuò máng ma?", "answer": "很忙。", "answer_sub": "hěn máng"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的工作忙吗？", "question_sub": "nǐ de gōngzuò máng ma?", "answer": "不太忙。", "answer_sub": "bú tài máng"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点开始工作？", "question_sub": "nǐ měitiān jǐ diǎn kāishǐ gōngzuò?", "answer": "我每天上午八点开始工作。", "answer_sub": "wǒ měitiān shàngwǔ bā diǎn kāishǐ gōngzuò"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点回家？", "question_sub": "nǐ měitiān jǐ diǎn huí jiā?", "answer": "我每天晚上六点回家。", "answer_sub": "wǒ měitiān wǎnshang liù diǎn huí jiā"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢你的工作吗？", "question_sub": "nǐ xǐhuān nǐ de gōngzuò ma?", "answer": "喜欢。", "answer_sub": "xǐhuān"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 18 | 学习汉语
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 18, N'LEVEL 18 | 学习汉语', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候开始学习汉语？", "question_sub": "nǐ shénme shíhou kāishǐ xuéxí hànyǔ?", "answer": "我从二十岁的时候开始学习汉语。", "answer_sub": "wǒ cóng èrshí suì de shíhou kāishǐ xuéxí hànyǔ"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你什么时候开始学习汉语？", "question_sub": "nǐ shénme shíhou kāishǐ xuéxí hànyǔ?", "answer": "我从2026年开始学习汉语。", "answer_sub": "wǒ cóng èr líng èr liù nián kāishǐ xuéxí hànyǔ"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得汉语难吗？", "question_sub": "nǐ juéde hànyǔ nán ma?", "answer": "有一点难。", "answer_sub": "yǒu yìdiǎn nán"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得汉语难吗？", "question_sub": "nǐ juéde hànyǔ nán ma?", "answer": "不太难。", "answer_sub": "bú tài nán"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你为什么学汉语？", "question_sub": "nǐ wèishénme xué hànyǔ?", "answer": "因为我在中国公司工作。", "answer_sub": "yīnwèi wǒ zài zhōngguó gōngsī gōngzuò"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你为什么学汉语？", "question_sub": "nǐ wèishénme xué hànyǔ?", "answer": "因为我想找到好工作。", "answer_sub": "yīnwèi wǒ xiǎng zhǎodào hǎo gōngzuò"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 19 | 打电话
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 19, N'LEVEL 19 | 打电话', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问李老师在吗？", "question_sub": "qǐngwèn lǐ lǎoshī zài ma?", "answer": "在。", "answer_sub": "zài"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问李老师在吗？", "question_sub": "qǐngwèn lǐ lǎoshī zài ma?", "answer": "不在。", "answer_sub": "bú zài"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问你找李老师有什么事情吗？", "question_sub": "qǐngwèn nǐ zhǎo lǐ lǎoshī yǒu shénme shìqing ma?", "answer": "我有一个问题想问李老师。", "answer_sub": "wǒ yǒu yí gè wèntí xiǎng wèn lǐ lǎoshī"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问你找李老师有什么事情吗？", "question_sub": "qǐngwèn nǐ zhǎo lǐ lǎoshī yǒu shénme shìqing ma?", "answer": "我要问他……", "answer_sub": "wǒ yào wèn tā ……"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有老师/李月的电话吗？", "question_sub": "nǐ yǒu lǎoshī / lǐ yuè de diànhuà ma?", "answer": "有。", "answer_sub": "yǒu"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有老师/李月的电话吗？", "question_sub": "nǐ yǒu lǎoshī / lǐ yuè de diànhuà ma?", "answer": "没有。", "answer_sub": "méi yǒu"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 20 | 旅游
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 20, N'LEVEL 20 | 旅游', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢旅游吗？", "question_sub": "nǐ xǐhuān lǚyóu ma?", "answer": "喜欢。", "answer_sub": "xǐhuān"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢旅游吗？", "question_sub": "nǐ xǐhuān lǚyóu ma?", "answer": "不太喜欢。", "answer_sub": "bú tài xǐhuān"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去过中国吗？", "question_sub": "nǐ qùguo zhōngguó ma?", "answer": "去过中国。", "answer_sub": "qùguo zhōngguó"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去过中国吗？", "question_sub": "nǐ qùguo zhōngguó ma?", "answer": "没去过中国。", "answer_sub": "méi qùguo zhōngguó"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去过哪儿旅游？", "question_sub": "nǐ qùguo nǎr lǚyóu?", "answer": "我去过中国/美国。", "answer_sub": "wǒ qùguo zhōngguó / měiguó"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得北京几月最漂亮？", "question_sub": "nǐ juéde běijīng jǐ yuè zuì piàoliang?", "answer": "我觉得北京九月最漂亮。", "answer_sub": "wǒ juéde běijīng jiǔ yuè zuì piàoliang"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和谁去旅游？", "question_sub": "nǐ hé shéi qù lǚyóu?", "answer": "和家人。", "answer_sub": "hé jiārén"}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 21 | 星期天
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 21, N'LEVEL 21 | 星期天', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "星期天你做什么？", "question_sub": "xīngqītiān nǐ zuò shénme?", "answer": "我在家休息。", "answer_sub": "wǒ zài jiā xiūxi"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "星期天你做什么？", "question_sub": "xīngqītiān nǐ zuò shénme?", "answer": "我去书店看书。", "answer_sub": "wǒ qù shūdiàn kàn shū"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "星期天你做什么？", "question_sub": "xīngqītiān nǐ zuò shénme?", "answer": "我去商店买东西。", "answer_sub": "wǒ qù shāngdiàn mǎi dōngxi"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和谁一起？", "question_sub": "nǐ hé shéi yìqǐ?", "answer": "和朋友。", "answer_sub": "hé péngyou"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和谁一起？", "question_sub": "nǐ hé shéi yìqǐ?", "answer": "和家人。", "answer_sub": "hé jiārén"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "星期天你觉得怎么样？", "question_sub": "xīngqītiān nǐ juéde zěnmeyàng?", "answer": "很开心。", "answer_sub": "hěn kāixīn"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 22 | 生日
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 22, N'LEVEL 22 | 生日', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的生日是几月几号？", "question_sub": "nǐ de shēngrì shì jǐ yuè jǐ hào?", "answer": "我的生日是五月一号。", "answer_sub": "wǒ de shēngrì shì wǔ yuè yī hào"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的生日是几月几号？", "question_sub": "nǐ de shēngrì shì jǐ yuè jǐ hào?", "answer": "是十月二十号。", "answer_sub": "shì shí yuè èrshí hào"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的生日是几月几号？", "question_sub": "nǐ de shēngrì shì jǐ yuè jǐ hào?", "answer": "是三月三号。", "answer_sub": "shì sān yuè sān hào"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你生日的时候经常做什么？", "question_sub": "nǐ shēngrì de shíhou jīngcháng zuò shénme?", "answer": "我和朋友一起去玩儿。", "answer_sub": "wǒ hé péngyou yìqǐ qù wánr"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你生日的时候经常做什么？", "question_sub": "nǐ shēngrì de shíhou jīngcháng zuò shénme?", "answer": "我在家过生日。", "answer_sub": "wǒ zài jiā guò shēngrì"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你生日的时候经常做什么？", "question_sub": "nǐ shēngrì de shíhou jīngcháng zuò shénme?", "answer": "我出去吃饭。", "answer_sub": "wǒ chūqù chīfàn"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢过生日吗？为什么？", "question_sub": "nǐ xǐhuān guò shēngrì ma? wèishénme?", "answer": "我很喜欢，因为很开心。", "answer_sub": "wǒ hěn xǐhuān, yīnwèi hěn kāixīn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢过生日吗？为什么？", "question_sub": "nǐ xǐhuān guò shēngrì ma? wèishénme?", "answer": "喜欢，可以和朋友一起过生日。", "answer_sub": "xǐhuān, kěyǐ hé péngyou yìqǐ guò shēngrì"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朋友的生日，你送给他什么？", "question_sub": "péngyou de shēngrì, nǐ sòng gěi tā shénme?", "answer": "一本书。", "answer_sub": "yì běn shū"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朋友的生日，你送给他什么？", "question_sub": "péngyou de shēngrì, nǐ sòng gěi tā shénme?", "answer": "一块手表。", "answer_sub": "yí kuài shǒubiǎo"}', 'practice', @LessonId);

  -- Chapter: LEVEL 23 | 上课
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 23, N'LEVEL 23 | 上课', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点上课？", "question_sub": "nǐ měitiān jǐ diǎn shàng kè?", "answer": "我八点上课。", "answer_sub": "wǒ bā diǎn shàng kè"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点上课？", "question_sub": "nǐ měitiān jǐ diǎn shàng kè?", "answer": "我九点开始上课。", "answer_sub": "wǒ jiǔ diǎn kāishǐ shàng kè"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你今天有什么课？", "question_sub": "nǐ jīntiān yǒu shénme kè?", "answer": "我有汉语课。", "answer_sub": "wǒ yǒu hànyǔ kè"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你今天有什么课？", "question_sub": "nǐ jīntiān yǒu shénme kè?", "answer": "我有英语课。", "answer_sub": "wǒ yǒu yīngyǔ kè"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢上课吗？", "question_sub": "nǐ xǐhuan shàng kè ma?", "answer": "我很喜欢。", "answer_sub": "wǒ hěn xǐhuan"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 24 | 你的汉语老师
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 24, N'LEVEL 24 | 你的汉语老师', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的汉语老师是哪国人？", "question_sub": "nǐ de hànyǔ lǎoshī shì nǎ guó rén?", "answer": "他/她是越南人。", "answer_sub": "tā shì yuènán rén"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的汉语老师是哪国人？", "question_sub": "nǐ de hànyǔ lǎoshī shì nǎ guó rén?", "answer": "他/她是中国人。", "answer_sub": "tā shì zhōngguó rén"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他今年多大？", "question_sub": "tā jīnnián duō dà?", "answer": "他今年……岁。", "answer_sub": "tā jīnnián …… suì"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你们是从什么时候认识的？", "question_sub": "nǐmen shì cóng shénme shíhou rènshi de?", "answer": "我们是从今年认识的。", "answer_sub": "wǒmen shì cóng jīnnián rènshi de"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你们是从什么时候认识的？", "question_sub": "nǐmen shì cóng shénme shíhou rènshi de?", "answer": "我们是从2026年认识的。", "answer_sub": "wǒmen shì cóng èr líng èr liù nián rènshi de"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她的工作忙吗？", "question_sub": "tā de gōngzuò máng ma?", "answer": "很忙。", "answer_sub": "hěn máng"}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她的工作忙吗？", "question_sub": "tā de gōngzuò máng ma?", "answer": "不太忙。", "answer_sub": "bú tài máng"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她喜欢做什么？", "question_sub": "tā xǐhuān zuò shénme?", "answer": "喜欢运动/看电影/看电视/看书。", "answer_sub": "xǐhuān yùndòng / kàn diànyǐng / kàn diànshì / kàn shū"}', 'wrapup', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "他/她经常帮助学生学汉语吗？", "question_sub": "tā jīngcháng bāngzhù xuéshēng xué hànyǔ ma?", "answer": "很经常。", "answer_sub": "hěn jīngcháng"}', 'discussion', @LessonId);

  -- Chapter: LEVEL 25 | 生病
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 25, N'LEVEL 25 | 生病', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么了？", "question_sub": "nǐ zěnme le?", "answer": "我身体不太好。", "answer_sub": "wǒ shēntǐ bú tài hǎo"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去看医生了吗？", "question_sub": "nǐ qù kàn yīshēng le ma?", "answer": "去了，医生让我吃药。", "answer_sub": "qù le, yīshēng ràng wǒ chī yào"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去看医生了吗？", "question_sub": "nǐ qù kàn yīshēng le ma?", "answer": "还没有，我下午去。", "answer_sub": "hái méi yǒu, wǒ xiàwǔ qù"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "生病的时候我们要怎么做？", "question_sub": "shēngbìng de shíhou wǒmen yào zěnme zuò?", "answer": "我们要在家休息，多喝水。", "answer_sub": "wǒmen yào zài jiā xiūxi, duō hē shuǐ"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "生病的时候我们要怎么做？", "question_sub": "shēngbìng de shíhou wǒmen yào zěnme zuò?", "answer": "我们要吃药，早点睡觉。", "answer_sub": "wǒmen yào chī yào, zǎodiǎn shuìjiào"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 26 | 请帮助我
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 26, N'LEVEL 26 | 请帮助我', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你可以帮我吗？", "question_sub": "nǐ kěyǐ bāng wǒ ma?", "answer": "可以，我帮你。", "answer_sub": "kěyǐ, wǒ bāng nǐ"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你可以帮我吗？", "question_sub": "nǐ kěyǐ bāng wǒ ma?", "answer": "好的，你说吧。", "answer_sub": "hǎo de, nǐ shuō ba"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你可以帮我吗？", "question_sub": "nǐ kěyǐ bāng wǒ ma?", "answer": "不好意思，我现在有点忙。", "answer_sub": "bù hǎoyìsi, wǒ xiànzài yǒu diǎn máng"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，你可以帮我买一杯咖啡/一本书吗？", "question_sub": "qǐngwèn, nǐ kěyǐ bāng wǒ mǎi yì bēi kāfēi / yì běn shū ma?", "answer": "可以。", "answer_sub": "kěyǐ"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，你可以帮我买一杯咖啡/一本书吗？", "question_sub": "qǐngwèn, nǐ kěyǐ bāng wǒ mǎi yì bēi kāfēi / yì běn shū ma?", "answer": "不好意思，我现在没时间。", "answer_sub": "bù hǎoyìsi, wǒ xiànzài méi shíjiān"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "别人帮你的时候，你怎么说？", "question_sub": "biérén bāng nǐ de shíhou, nǐ zěnme shuō?", "answer": "谢谢你！", "answer_sub": "xièxie nǐ"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "别人帮你的时候，你怎么说？", "question_sub": "biérén bāng nǐ de shíhou, nǐ zěnme shuō?", "answer": "太感谢了！", "answer_sub": "tài gǎnxiè le"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 27 | 颜色
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 27, N'LEVEL 27 | 颜色', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢/不喜欢什么颜色？", "question_sub": "nǐ zuì xǐhuān / bù xǐhuān shénme yánsè?", "answer": "红色/粉色/黑色/白色。", "answer_sub": "hóngsè / fěnsè / hēisè / báisè"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有红色/粉色/黑色/白色的手表/手机/电脑吗？", "question_sub": "nǐ yǒu hóngsè / fěnsè / hēisè / báisè de shǒubiǎo / shǒujī / diànnǎo ma?", "answer": "有。", "answer_sub": "yǒu"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有红色/粉色/黑色/白色的手表/手机/电脑吗？", "question_sub": "nǐ yǒu hóngsè / fěnsè / hēisè / báisè de shǒubiǎo / shǒujī / diànnǎo ma?", "answer": "没有。", "answer_sub": "méi yǒu"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "红色的手表比黑色的手表贵吗？", "question_sub": "hóngsè de shǒubiǎo bǐ hēisè de shǒubiǎo guì ma?", "answer": "红色的手表比黑色的手表贵一些。", "answer_sub": "hóngsè de shǒubiǎo bǐ hēisè de shǒubiǎo guì yìdiǎn"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 28 | 问距离（Hỏi khoảng cách）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 28, N'LEVEL 28 | 问距离（Hỏi khoảng cách）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "这儿离学校/公司/商店远吗？", "question_sub": "zhèr lí xuéxiào / gōngsī / shāngdiàn yuǎn ma?", "answer": "不远，走路十分钟就到。", "answer_sub": "bù yuǎn, zǒulù shí fēnzhōng jiù dào"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "这儿离学校/公司/商店远吗？", "question_sub": "zhèr lí xuéxiào / gōngsī / shāngdiàn yuǎn ma?", "answer": "有一点远，要坐车。", "answer_sub": "yǒu yìdiǎn yuǎn, yào zuò chē"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "这儿离学校/公司/商店远吗？", "question_sub": "zhèr lí xuéxiào / gōngsī / shāngdiàn yuǎn ma?", "answer": "很远，我每天坐公交车去。", "answer_sub": "hěn yuǎn, wǒ měitiān zuò gōngjiāochē qù"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "从你家到学校/公司/商店要多长时间？", "question_sub": "cóng nǐ jiā dào xuéxiào / gōngsī / shāngdiàn yào duō cháng shíjiān?", "answer": "二十分钟。", "answer_sub": "èrshí fēnzhōng"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "从你家到学校/公司/商店要多长时间？", "question_sub": "cóng nǐ jiā dào xuéxiào / gōngsī / shāngdiàn yào duō cháng shíjiān?", "answer": "很近，十分钟就到了。", "answer_sub": "hěn jìn, shí fēnzhōng jiù dào le"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么去学校？为什么？", "question_sub": "nǐ zěnme qù xuéxiào? wèishénme?", "answer": "我坐公交车去，因为有点远。", "answer_sub": "wǒ zuò gōngjiāochē qù, yīnwèi yǒu diǎn yuǎn"}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 29 | 你会写汉字吗？
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 29, N'LEVEL 29 | 你会写汉字吗？', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，你会写汉字吗？", "question_sub": "qǐngwèn, nǐ huì xiě hànzì ma?", "answer": "会，我会写一点。", "answer_sub": "huì, wǒ huì xiě yìdiǎn"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你写汉字写得好吗？", "question_sub": "nǐ xiě hànzì xiě de hǎo ma?", "answer": "不太好，还在学习。", "answer_sub": "bú tài hǎo, hái zài xuéxí"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你写汉字写得好吗？", "question_sub": "nǐ xiě hànzì xiě de hǎo ma?", "answer": "我写汉字写得很好。", "answer_sub": "wǒ xiě hànzì xiě de hěn hǎo"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得写汉字难不难？", "question_sub": "nǐ juéde xiě hànzì nán bu nán?", "answer": "很难。", "answer_sub": "hěn nán"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得写汉字难不难？", "question_sub": "nǐ juéde xiě hànzì nán bu nán?", "answer": "有一点难。", "answer_sub": "yǒu yìdiǎn nán"}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么？", "question_sub": "wèishénme?", "answer": "因为有很多汉字。", "answer_sub": "yīnwèi yǒu hěn duō hànzì"}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天的汉字你写完了吗？", "question_sub": "jīntiān de hànzì nǐ xiě wán le ma?", "answer": "我写完了。", "answer_sub": "wǒ xiě wán le"}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今天的汉字你写完了吗？", "question_sub": "jīntiān de hànzì nǐ xiě wán le ma?", "answer": "我还没写完。", "answer_sub": "wǒ hái méi xiě wán"}', 'wrapup', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "这个汉字你会写吗？", "question_sub": "zhè ge hànzì nǐ huì xiě ma?", "answer": "我会写。", "answer_sub": "wǒ huì xiě"}', 'discussion', @LessonId);

  -- Chapter: LEVEL 30 | 问路（Hỏi đường）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 30, N'LEVEL 30 | 问路（Hỏi đường）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，学校/医院/宾馆在哪儿？", "question_sub": "qǐngwèn, xuéxiào / yīyuàn / bīnguǎn zài nǎr?", "answer": "在前面。", "answer_sub": "zài qiánmiàn"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，学校/医院/宾馆在哪儿？", "question_sub": "qǐngwèn, xuéxiào / yīyuàn / bīnguǎn zài nǎr?", "answer": "在那边的路口。", "answer_sub": "zài nàbian de lùkǒu"}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "请问，学校/医院/宾馆在哪儿？", "question_sub": "qǐngwèn, xuéxiào / yīyuàn / bīnguǎn zài nǎr?", "answer": "在学校/商店旁边。", "answer_sub": "zài xuéxiào / shāngdiàn pángbiān"}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "从这儿怎么去学校/商店？", "question_sub": "cóng zhèr zěnme qù xuéxiào / shāngdiàn?", "answer": "一直走。", "answer_sub": "yìzhí zǒu"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "从这儿怎么去学校/商店？", "question_sub": "cóng zhèr zěnme qù xuéxiào / shāngdiàn?", "answer": "一直走，到前面的路口再往右走。", "answer_sub": "yìzhí zǒu, dào qiánmiàn de lùkǒu zài wǎng yòu zǒu"}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "从这儿怎么去学校/商店？", "question_sub": "cóng zhèr zěnme qù xuéxiào / shāngdiàn?", "answer": "往左走。", "answer_sub": "wǎng zuǒ zǒu"}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "离这儿远吗？", "question_sub": "lí zhèr yuǎn ma?", "answer": "不远，很近。", "answer_sub": "bù yuǎn, hěn jìn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "离这儿远吗？", "question_sub": "lí zhèr yuǎn ma?", "answer": "有一点远。", "answer_sub": "yǒu yìdiǎn yuǎn"}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "离这儿远吗？", "question_sub": "lí zhèr yuǎn ma?", "answer": "不太远，走路十分钟就到了。", "answer_sub": "bú tài yuǎn, zǒulù shí fēnzhōng jiù dào le"}', 'follow_up', @LessonId);

-- Course: Chinese_level_31-100_LucyLMS_Ready
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'Chinese';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('CHI', N'', 1, 2, N'Chinese_level_31-100_LucyLMS_Ready', 'Chinese', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 31 | 我的学习计划
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 31 | 我的学习计划', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在有什么学习计划？", "question_sub": "nǐ xiànzài yǒu shénme xuéxí jìhuà?", "answer": "我现在的计划是每天学习两个小时中文，也复习以前学过的课。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在有什么学习计划？", "question_sub": "nǐ xiànzài yǒu shénme xuéxí jìhuà?", "answer": "我这个学期想把中文学好，所以每天都会听录音和练习说话。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你一般怎么学习？", "question_sub": "nǐ yībān zěnme xuéxí?", "answer": "我一般在家看书，也用手机学新单词。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你一般怎么学习？", "question_sub": "nǐ yībān zěnme xuéxí?", "answer": "我喜欢跟同学一起学习，这样可以互相帮助。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习难吗？为什么？", "question_sub": "nǐ juéde xuéxí nán ma? wèishénme?", "answer": "有一点难，因为有很多新单词。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 32 | 我的周末
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 32 | 我的周末', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的周末一般怎么过？", "question_sub": "nǐ de zhōumò yībān zěnme guò?", "answer": "我的周末比较轻松，我会在家休息或者看电影。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的周末一般怎么过？", "question_sub": "nǐ de zhōumò yībān zěnme guò?", "answer": "周末我喜欢和朋友一起出去，比如去喝咖啡。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你周末常和谁一起？", "question_sub": "nǐ zhōumò cháng hé shéi yìqǐ?", "answer": "我常和朋友一起，有时候也和家人一起。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你周末常和谁一起？", "question_sub": "nǐ zhōumò cháng hé shéi yìqǐ?", "answer": "我一般一个人，因为我喜欢安静。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得周末重要吗？为什么？", "question_sub": "nǐ juéde zhōumò zhòngyào ma? wèishénme?", "answer": "很重要，因为可以休息。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 33 | 我的旅行经历
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 33 | 我的旅行经历', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去过哪些地方？", "question_sub": "nǐ qùguo nǎxiē dìfang?", "answer": "我去过岘港和河内，这些地方很漂亮。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你去过哪些地方？", "question_sub": "nǐ qùguo nǎxiē dìfang?", "answer": "我去过中国，去了北京。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在那儿做了什么？", "question_sub": "nǐ zài nàr zuò le shénme?", "answer": "我看了很多地方，也吃了很多好吃的。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在那儿做了什么？", "question_sub": "nǐ zài nàr zuò le shénme?", "answer": "我拍了照片，还买了一些东西。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢旅行吗？为什么？", "question_sub": "nǐ xǐhuān lǚxíng ma? wèishénme?", "answer": "我很喜欢，因为可以放松。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 34 | 学习中文的困难
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 34 | 学习中文的困难', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习中文难在哪里？", "question_sub": "nǐ juéde xuéxí zhōngwén nán zài nǎlǐ?", "answer": "我觉得记单词很难，因为很容易忘记。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习中文难在哪里？", "question_sub": "nǐ juéde xuéxí zhōngwén nán zài nǎlǐ?", "answer": "我觉得说中文比较难，有时候说不好。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么解决这个问题？", "question_sub": "nǐ zěnme jiějué zhège wèntí?", "answer": "我每天复习单词，也多听录音。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么解决这个问题？", "question_sub": "nǐ zěnme jiějué zhège wèntí?", "answer": "我会多说中文，也请老师帮我。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在有进步吗？", "question_sub": "nǐ xiànzài yǒu jìnbù ma?", "answer": "有，我现在可以说简单的句子。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 35 | 我的梦想
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 35 | 我的梦想', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的梦想是什么？", "question_sub": "nǐ de mèngxiǎng shì shénme?", "answer": "我的梦想是当老师。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的梦想是什么？", "question_sub": "nǐ de mèngxiǎng shì shénme?", "answer": "我想在公司工作。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么？", "question_sub": "wèishénme?", "answer": "因为我喜欢教学生。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么？", "question_sub": "wèishénme?", "answer": "因为这个工作很好。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在做什么准备？", "question_sub": "nǐ xiànzài zuò shénme zhǔnbèi?", "answer": "我现在认真学习。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 36 | 手机的使用
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 36 | 手机的使用', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天用手机多长时间？", "question_sub": "nǐ měitiān yòng shǒujī duō cháng shíjiān?", "answer": "我每天用三四个小时。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天用手机多长时间？", "question_sub": "nǐ měitiān yòng shǒujī duō cháng shíjiān?", "answer": "我用得比较多，大概五个小时。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常用手机做什么？", "question_sub": "nǐ cháng yòng shǒujī zuò shénme?", "answer": "我用手机聊天、看视频。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常用手机做什么？", "question_sub": "nǐ cháng yòng shǒujī zuò shénme?", "answer": "我用手机听音乐、学习。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得用手机多好吗？", "question_sub": "nǐ juéde yòng shǒujī duō hǎo ma?", "answer": "不太好，对身体不好。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 37 | 健康生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 37 | 健康生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时怎么保持健康？", "question_sub": "nǐ píngshí zěnme bǎochí jiànkāng?", "answer": "我每天运动，也注意吃饭。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时怎么保持健康？", "question_sub": "nǐ píngshí zěnme bǎochí jiànkāng?", "answer": "我早睡早起，多喝水。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常运动吗？", "question_sub": "nǐ cháng yùndòng ma?", "answer": "我一周运动两三次。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常运动吗？", "question_sub": "nǐ cháng yùndòng ma?", "answer": "我每天走路。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得健康重要吗？为什么？", "question_sub": "nǐ juéde jiànkāng zhòngyào ma? wèishénme?", "answer": "很重要，因为身体好很重要。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 38 | 压力
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 38 | 压力', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有压力吗？", "question_sub": "nǐ yǒu yālì ma?", "answer": "有一点，比如学习压力。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有压力吗？", "question_sub": "nǐ yǒu yālì ma?", "answer": "有时候有，因为事情很多。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么放松？", "question_sub": "nǐ zěnme fàngsōng?", "answer": "我听音乐。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么放松？", "question_sub": "nǐ zěnme fàngsōng?", "answer": "我和朋友聊天。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "压力多好吗？", "question_sub": "yālì duō hǎo ma?", "answer": "不太好，会很累。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 39 | 网络生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 39 | 网络生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天上网吗？", "question_sub": "nǐ měitiān shàngwǎng ma?", "answer": "我每天都上网。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天上网吗？", "question_sub": "nǐ měitiān shàngwǎng ma?", "answer": "我不常上网。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你上网做什么？", "question_sub": "nǐ shàngwǎng zuò shénme?", "answer": "我看视频，也聊天。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你上网做什么？", "question_sub": "nǐ shàngwǎng zuò shénme?", "answer": "我看新闻，也学习。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得上网好吗？", "question_sub": "nǐ juéde shàngwǎng hǎo ma?", "answer": "很方便，但是不能太多。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 40 | 看书
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 40 | 看书', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢看书吗？", "question_sub": "nǐ xǐhuān kàn shū ma?", "answer": "我很喜欢。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢看书吗？", "question_sub": "nǐ xǐhuān kàn shū ma?", "answer": "我不太喜欢。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你看什么书？", "question_sub": "nǐ kàn shénme shū?", "answer": "我看小说。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你看什么书？", "question_sub": "nǐ kàn shénme shū?", "answer": "我看学习的书。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你多久看一次？", "question_sub": "nǐ duō jiǔ kàn yí cì?", "answer": "我每天看一点。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 41 | 学习和生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 41 | 学习和生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习和生活容易安排吗？", "question_sub": "nǐ juéde xuéxí hé shēnghuó róngyì ānpái ma?", "answer": "有一点难，因为时间不多。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习和生活容易安排吗？", "question_sub": "nǐ juéde xuéxí hé shēnghuó róngyì ānpái ma?", "answer": "还可以，我会安排时间。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么安排时间？", "question_sub": "nǐ zěnme ānpái shíjiān?", "answer": "我先学习，再休息。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么安排时间？", "question_sub": "nǐ zěnme ānpái shíjiān?", "answer": "我每天都有计划。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得休息重要吗？", "question_sub": "nǐ juéde xiūxi zhòngyào ma?", "answer": "很重要，可以放松。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 42 | 我的爱好变化
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 42 | 我的爱好变化', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在的爱好和以前一样吗？", "question_sub": "nǐ xiànzài de àihào hé yǐqián yíyàng ma?", "answer": "不一样，我现在更喜欢运动。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在的爱好和以前一样吗？", "question_sub": "nǐ xiànzài de àihào hé yǐqián yíyàng ma?", "answer": "有一点一样，我还是喜欢听音乐。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么会有变化？", "question_sub": "wèishénme huì yǒu biànhuà?", "answer": "因为我想更健康。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么会有变化？", "question_sub": "wèishénme huì yǒu biànhuà?", "answer": "因为我有新的朋友。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得有爱好重要吗？", "question_sub": "nǐ juéde yǒu àihào zhòngyào ma?", "answer": "很重要，可以让生活更有意思。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 43 | 我的同学
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 43 | 我的同学', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的同学怎么样？", "question_sub": "nǐ de tóngxué zěnmeyàng?", "answer": "我的同学很友好，也很热情。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的同学怎么样？", "question_sub": "nǐ de tóngxué zěnmeyàng?", "answer": "大家都很好，学习也很认真。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常和同学做什么？", "question_sub": "nǐ cháng hé tóngxué zuò shénme?", "answer": "我们一起学习，也一起吃饭。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你常和同学做什么？", "question_sub": "nǐ cháng hé tóngxué zuò shénme?", "answer": "我们有时候一起出去玩。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢和同学一起学习吗？为什么？", "question_sub": "nǐ xǐhuān hé tóngxué yìqǐ xuéxí ma? wèishénme?", "answer": "喜欢，因为可以互相帮助。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 44 | 我的老师（进阶）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 44 | 我的老师（进阶）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢的老师是谁？为什么？", "question_sub": "nǐ zuì xǐhuān de lǎoshī shì shéi? wèishénme?", "answer": "我最喜欢中文老师，因为她上课很有意思。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢的老师是谁？为什么？", "question_sub": "nǐ zuì xǐhuān de lǎoshī shì shéi? wèishénme?", "answer": "我喜欢英语老师，因为他很耐心。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "老师上课时你一般做什么？", "question_sub": "lǎoshī shàng kè shí nǐ yībān zuò shénme?", "answer": "我认真听讲，也做笔记。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "老师上课时你一般做什么？", "question_sub": "lǎoshī shàng kè shí nǐ yībān zuò shénme?", "answer": "我回答问题，也参加讨论。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得老师重要吗？为什么？", "question_sub": "nǐ juéde lǎoshī zhòngyào ma? wèishénme?", "answer": "很重要，因为老师可以帮助我们学习。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 45 | 我的房间
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 45 | 我的房间', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的房间大吗？有什么？", "question_sub": "nǐ de fángjiān dà ma? yǒu shénme?", "answer": "不太大，有一张床和一张桌子。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的房间大吗？有什么？", "question_sub": "nǐ de fángjiān dà ma? yǒu shénme?", "answer": "我的房间很干净，还有很多书。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢你的房间吗？为什么？", "question_sub": "nǐ xǐhuān nǐ de fángjiān ma? wèishénme?", "answer": "很喜欢，因为很安静。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢你的房间吗？为什么？", "question_sub": "nǐ xǐhuān nǐ de fángjiān ma? wèishénme?", "answer": "喜欢，因为很舒服。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时在房间做什么？", "question_sub": "nǐ píngshí zài fángjiān zuò shénme?", "answer": "我在房间学习。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 46 | 我的作息时间
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 46 | 我的作息时间', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点睡觉？", "question_sub": "nǐ měitiān jǐ diǎn shuìjiào?", "answer": "我每天十一点睡觉。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天几点睡觉？", "question_sub": "nǐ měitiān jǐ diǎn shuìjiào?", "answer": "我十点半睡觉。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得你的作息规律吗？", "question_sub": "nǐ juéde nǐ de zuòxī guīlǜ ma?", "answer": "比较规律。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得你的作息规律吗？", "question_sub": "nǐ juéde nǐ de zuòxī guīlǜ ma?", "answer": "不太规律。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得早睡早起好吗？为什么？", "question_sub": "nǐ juéde zǎo shuì zǎo qǐ hǎo ma? wèishénme?", "answer": "很好，对身体好。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 47 | 吃饭习惯
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 17, N'LEVEL 47 | 吃饭习惯', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天按时吃饭吗？", "question_sub": "nǐ měitiān àn shí chīfàn ma?", "answer": "我每天都按时吃饭。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天按时吃饭吗？", "question_sub": "nǐ měitiān àn shí chīfàn ma?", "answer": "有时候不按时。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢在家吃还是在外面吃？", "question_sub": "nǐ xǐhuān zài jiā chī háishì zài wàimiàn chī?", "answer": "我喜欢在家吃。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢在家吃还是在外面吃？", "question_sub": "nǐ xǐhuān zài jiā chī háishì zài wàimiàn chī?", "answer": "我更喜欢在外面吃。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么？", "question_sub": "wèishénme?", "answer": "因为在家比较健康。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 48 | 去超市
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 18, N'LEVEL 48 | 去超市', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你多久去一次超市？", "question_sub": "nǐ duō jiǔ qù yí cì chāoshì?", "answer": "我一周去一次。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你多久去一次超市？", "question_sub": "nǐ duō jiǔ qù yí cì chāoshì?", "answer": "我有时候去。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你一般买什么？", "question_sub": "nǐ yībān mǎi shénme?", "answer": "我买吃的和水果。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你一般买什么？", "question_sub": "nǐ yībān mǎi shénme?", "answer": "我买日常用品。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢一个人去还是和朋友一起去？", "question_sub": "nǐ xǐhuān yí gè rén qù háishì hé péngyou yìqǐ qù?", "answer": "我喜欢一个人去。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 49 | 交通工具
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 19, N'LEVEL 49 | 交通工具', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时用什么交通工具？", "question_sub": "nǐ píngshí yòng shénme jiāotōng gōngjù?", "answer": "我骑车。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时用什么交通工具？", "question_sub": "nǐ píngshí yòng shénme jiāotōng gōngjù?", "answer": "我坐公交车。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么选择这种方式？", "question_sub": "wèishénme xuǎnzé zhèzhǒng fāngshì?", "answer": "因为方便。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么选择这种方式？", "question_sub": "wèishénme xuǎnzé zhèzhǒng fāngshì?", "answer": "因为比较便宜。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得交通方便吗？", "question_sub": "nǐ juéde jiāotōng fāngbiàn ma?", "answer": "很方便。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 50 | 天气的影响
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 20, N'LEVEL 50 | 天气的影响', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "天气会影响你的心情吗？", "question_sub": "tiānqì huì yǐngxiǎng nǐ de xīnqíng ma?", "answer": "会，下雨天我不太开心。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "天气会影响你的心情吗？", "question_sub": "tiānqì huì yǐngxiǎng nǐ de xīnqíng ma?", "answer": "会，晴天我很高兴。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么天气？", "question_sub": "nǐ xǐhuān shénme tiānqì?", "answer": "我喜欢凉快的天气。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢什么天气？", "question_sub": "nǐ xǐhuān shénme tiānqì?", "answer": "我喜欢晴天。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "不同天气你会做什么？", "question_sub": "bùtóng tiānqì nǐ huì zuò shénme?", "answer": "下雨天我在家休息。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 51 | 看电影（进阶）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 21, N'LEVEL 51 | 看电影（进阶）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最近看了什么电影？", "question_sub": "nǐ zuìjìn kàn le shénme diànyǐng?", "answer": "我最近看了一部爱情电影。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最近看了什么电影？", "question_sub": "nǐ zuìjìn kàn le shénme diànyǐng?", "answer": "我看了一部很有意思的电影。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得这部电影怎么样？", "question_sub": "nǐ juéde zhè bù diànyǐng zěnmeyàng?", "answer": "我觉得很好看。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得这部电影怎么样？", "question_sub": "nǐ juéde zhè bù diànyǐng zěnmeyàng?", "answer": "我觉得一般。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢在家看还是去电影院？为什么？", "question_sub": "nǐ xǐhuān zài jiā kàn háishì qù diànyǐngyuàn? wèishénme?", "answer": "我喜欢在家看，因为方便。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 52 | 听音乐（进阶）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 22, N'LEVEL 52 | 听音乐（进阶）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天听音乐吗？", "question_sub": "nǐ měitiān tīng yīnyuè ma?", "answer": "我每天都会听。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你每天听音乐吗？", "question_sub": "nǐ měitiān tīng yīnyuè ma?", "answer": "我有时候听。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢听什么音乐？", "question_sub": "nǐ xǐhuān tīng shénme yīnyuè?", "answer": "我喜欢流行音乐。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢听什么音乐？", "question_sub": "nǐ xǐhuān tīng shénme yīnyuè?", "answer": "我喜欢轻音乐。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "音乐对你有什么影响？", "question_sub": "yīnyuè duì nǐ yǒu shénme yǐngxiǎng?", "answer": "可以让我放松。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 53 | 饮食习惯
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 23, N'LEVEL 53 | 饮食习惯', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得你的饮食健康吗？", "question_sub": "nǐ juéde nǐ de yǐnshí jiànkāng ma?", "answer": "比较健康，我少吃油腻的食物。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得你的饮食健康吗？", "question_sub": "nǐ juéde nǐ de yǐnshí jiànkāng ma?", "answer": "不太健康，我经常吃外卖。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢吃什么？", "question_sub": "nǐ zuì xǐhuān chī shénme?", "answer": "我最喜欢吃米饭和蔬菜。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢吃什么？", "question_sub": "nǐ zuì xǐhuān chī shénme?", "answer": "我很喜欢吃越南菜。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得饮食重要吗？", "question_sub": "nǐ juéde yǐnshí zhòngyào ma?", "answer": "很重要，饮食影响健康。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 54 | 学习方法
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 24, N'LEVEL 54 | 学习方法', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么学习方法最有效？", "question_sub": "nǐ juéde shénme xuéxí fāngfǎ zuì yǒuxiào?", "answer": "我觉得每天复习最重要。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么学习方法最有效？", "question_sub": "nǐ juéde shénme xuéxí fāngfǎ zuì yǒuxiào?", "answer": "我觉得多练习说话最有效。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么记单词？", "question_sub": "nǐ zěnme jì dāncí?", "answer": "我用卡片记单词。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么记单词？", "question_sub": "nǐ zěnme jì dāncí?", "answer": "我每天用手机复习。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得听力重要吗？", "question_sub": "nǐ juéde tīnglì zhòngyào ma?", "answer": "很重要，可以帮助说话。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 55 | 朋友关系
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 25, N'LEVEL 55 | 朋友关系', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得朋友重要吗？为什么？", "question_sub": "nǐ juéde péngyou zhòngyào ma? wèishénme?", "answer": "很重要，朋友可以帮助我。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得朋友重要吗？为什么？", "question_sub": "nǐ juéde péngyou zhòngyào ma? wèishénme?", "answer": "很重要，有朋友生活更快乐。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和朋友常做什么？", "question_sub": "nǐ hé péngyou cháng zuò shénme?", "answer": "我们一起吃饭，也一起学习。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和朋友常做什么？", "question_sub": "nǐ hé péngyou cháng zuò shénme?", "answer": "我们有时候一起去看电影。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得维持友情需要什么？", "question_sub": "nǐ juéde wéichí yǒuqíng xūyào shénme?", "answer": "需要互相理解和支持。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 56 | 家庭关系
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 26, N'LEVEL 56 | 家庭关系', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和家人的关系怎么样？", "question_sub": "nǐ hé jiārén de guānxi zěnmeyàng?", "answer": "我和家人关系很好。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你和家人的关系怎么样？", "question_sub": "nǐ hé jiārén de guānxi zěnmeyàng?", "answer": "我很爱我的家人。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你家人对你的学习有什么看法？", "question_sub": "nǐ jiārén duì nǐ de xuéxí yǒu shénme kànfǎ?", "answer": "他们支持我学习。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你家人对你的学习有什么看法？", "question_sub": "nǐ jiārén duì nǐ de xuéxí yǒu shénme kànfǎ?", "answer": "他们希望我努力学习。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时怎么帮助家人？", "question_sub": "nǐ píngshí zěnme bāngzhù jiārén?", "answer": "我帮忙做家务。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 57 | 计划与目标
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 27, N'LEVEL 57 | 计划与目标', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你今年有什么目标？", "question_sub": "nǐ jīnnián yǒu shénme mùbiāo?", "answer": "我的目标是把中文学好。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你今年有什么目标？", "question_sub": "nǐ jīnnián yǒu shénme mùbiāo?", "answer": "我想找到一份好工作。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么实现自己的目标？", "question_sub": "nǐ zěnme shíxiàn zìjǐ de mùbiāo?", "answer": "我每天坚持学习。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么实现自己的目标？", "question_sub": "nǐ zěnme shíxiàn zìjǐ de mùbiāo?", "answer": "我会制定计划，一步一步来。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得目标重要吗？", "question_sub": "nǐ juéde mùbiāo zhòngyào ma?", "answer": "很重要，有目标才有方向。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 58 | 城市与农村
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 28, N'LEVEL 58 | 城市与农村', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢住在城市还是农村？", "question_sub": "nǐ xǐhuān zhù zài chéngshì háishì nóngcūn?", "answer": "我喜欢住在城市，因为很方便。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢住在城市还是农村？", "question_sub": "nǐ xǐhuān zhù zài chéngshì háishì nóngcūn?", "answer": "我喜欢农村，因为很安静。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "城市和农村有什么不同？", "question_sub": "chéngshì hé nóngcūn yǒu shénme bùtóng?", "answer": "城市交通方便，但是空气不好。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "城市和农村有什么不同？", "question_sub": "chéngshì hé nóngcūn yǒu shénme bùtóng?", "answer": "农村空气好，但是不太方便。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你现在住在哪里？", "question_sub": "nǐ xiànzài zhù zài nǎlǐ?", "answer": "我住在城市。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 59 | 环境保护
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 29, N'LEVEL 59 | 环境保护', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得环境问题重要吗？", "question_sub": "nǐ juéde huánjìng wèntí zhòngyào ma?", "answer": "很重要，我们要保护环境。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得环境问题重要吗？", "question_sub": "nǐ juéde huánjìng wèntí zhòngyào ma?", "answer": "很重要，因为影响我们的生活。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时怎么保护环境？", "question_sub": "nǐ píngshí zěnme bǎohù huánjìng?", "answer": "我少用塑料袋。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时怎么保护环境？", "question_sub": "nǐ píngshí zěnme bǎohù huánjìng?", "answer": "我尽量坐公交车。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得每个人都有责任保护环境吗？", "question_sub": "nǐ juéde měi gè rén dōu yǒu zérèn bǎohù huánjìng ma?", "answer": "有责任，每个人都要参与。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 60 | 科技与生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 30, N'LEVEL 60 | 科技与生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "科技对你的生活有什么影响？", "question_sub": "kējì duì nǐ de shēnghuó yǒu shénme yǐngxiǎng?", "answer": "科技让我的生活更方便。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "科技对你的生活有什么影响？", "question_sub": "kējì duì nǐ de shēnghuó yǒu shénme yǐngxiǎng?", "answer": "科技帮助我学习和工作。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得科技的发展好吗？", "question_sub": "nǐ juéde kējì de fāzhǎn hǎo ma?", "answer": "很好，可以解决很多问题。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得科技的发展好吗？", "question_sub": "nǐ juéde kējì de fāzhǎn hǎo ma?", "answer": "好，但是也有一些问题。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢哪种科技产品？", "question_sub": "nǐ zuì xǐhuān nǎzhǒng kējì chǎnpǐn?", "answer": "我最喜欢手机。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 61 | 文化差异
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 31, N'LEVEL 61 | 文化差异', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你了解中国文化吗？", "question_sub": "nǐ liǎojiě zhōngguó wénhuà ma?", "answer": "我了解一点，比如春节和中秋节。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你了解中国文化吗？", "question_sub": "nǐ liǎojiě zhōngguó wénhuà ma?", "answer": "我很感兴趣，想多了解。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "中国文化和越南文化有什么不同？", "question_sub": "zhōngguó wénhuà hé yuènán wénhuà yǒu shénme bùtóng?", "answer": "饮食不一样，但是都很好吃。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "中国文化和越南文化有什么不同？", "question_sub": "zhōngguó wénhuà hé yuènán wénhuà yǒu shénme bùtóng?", "answer": "节日有一些不同，但很多习惯相似。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得了解别国文化重要吗？", "question_sub": "nǐ juéde liǎojiě bié guó wénhuà zhòngyào ma?", "answer": "很重要，可以增进理解。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 62 | 工作与学习的平衡
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 32, N'LEVEL 62 | 工作与学习的平衡', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得工作和学习可以同时进行吗？", "question_sub": "nǐ juéde gōngzuò hé xuéxí kěyǐ tóngshí jìnxíng ma?", "answer": "可以，但需要合理安排时间。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得工作和学习可以同时进行吗？", "question_sub": "nǐ juéde gōngzuò hé xuéxí kěyǐ tóngshí jìnxíng ma?", "answer": "有点难，因为时间有限。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么平衡工作和学习？", "question_sub": "nǐ zěnme pínghéng gōngzuò hé xuéxí?", "answer": "我每天制定计划。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么平衡工作和学习？", "question_sub": "nǐ zěnme pínghéng gōngzuò hé xuéxí?", "answer": "我先完成重要的事情。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得哪个更重要？", "question_sub": "nǐ juéde nǎ gè gèng zhòngyào?", "answer": "两个都重要，缺一不可。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 63 | 感恩与感谢
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 33, N'LEVEL 63 | 感恩与感谢', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得感恩重要吗？", "question_sub": "nǐ juéde gǎn''ēn zhòngyào ma?", "answer": "很重要，要感谢帮助我们的人。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得感恩重要吗？", "question_sub": "nǐ juéde gǎn''ēn zhòngyào ma?", "answer": "很重要，感恩让人更快乐。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最感谢谁？为什么？", "question_sub": "nǐ zuì gǎnxiè shéi? wèishénme?", "answer": "我最感谢我的父母，因为他们支持我。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最感谢谁？为什么？", "question_sub": "nǐ zuì gǎnxiè shéi? wèishénme?", "answer": "我很感谢我的老师，因为他们教了我很多。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么表达感谢？", "question_sub": "nǐ zěnme biǎodá gǎnxiè?", "answer": "我说谢谢，也会送礼物。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 64 | 节假日
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 34, N'LEVEL 64 | 节假日', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢哪个节日？为什么？", "question_sub": "nǐ xǐhuān nǎ gè jiérì? wèishénme?", "answer": "我喜欢春节，因为可以和家人在一起。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢哪个节日？为什么？", "question_sub": "nǐ xǐhuān nǎ gè jiérì? wèishénme?", "answer": "我喜欢中秋节，因为可以赏月。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "节日的时候你一般做什么？", "question_sub": "jiérì de shíhou nǐ yībān zuò shénme?", "answer": "我和家人一起吃饭。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "节日的时候你一般做什么？", "question_sub": "jiérì de shíhou nǐ yībān zuò shénme?", "answer": "我和朋友一起庆祝。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得节日重要吗？", "question_sub": "nǐ juéde jiérì zhòngyào ma?", "answer": "很重要，可以和家人团聚。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 65 | 志愿服务
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 35, N'LEVEL 65 | 志愿服务', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你参加过志愿活动吗？", "question_sub": "nǐ cānjiā guò zhìyuàn huódòng ma?", "answer": "参加过，我帮助过社区活动。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你参加过志愿活动吗？", "question_sub": "nǐ cānjiā guò zhìyuàn huódòng ma?", "answer": "没有，但我很想参加。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得做志愿者有什么好处？", "question_sub": "nǐ juéde zuò zhìyuàn zhě yǒu shénme hǎochù?", "answer": "可以帮助别人，也可以学到很多。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得做志愿者有什么好处？", "question_sub": "nǐ juéde zuò zhìyuàn zhě yǒu shénme hǎochù?", "answer": "可以让社会更好。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你愿意参加什么类型的志愿活动？", "question_sub": "nǐ yuànyì cānjiā shénme lèixíng de zhìyuàn huódòng?", "answer": "我想帮助老人或者孩子。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 66 | 个人成长
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 36, N'LEVEL 66 | 个人成长', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己最大的进步是什么？", "question_sub": "nǐ juéde zìjǐ zuìdà de jìnbù shì shénme?", "answer": "我的中文进步了很多。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己最大的进步是什么？", "question_sub": "nǐ juéde zìjǐ zuìdà de jìnbù shì shénme?", "answer": "我变得更有耐心了。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己哪里还需要改进？", "question_sub": "nǐ juéde zìjǐ nǎlǐ hái xūyào gǎijìn?", "answer": "我需要更努力学习。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己哪里还需要改进？", "question_sub": "nǐ juéde zìjǐ nǎlǐ hái xūyào gǎijìn?", "answer": "我需要更好地管理时间。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么看待自己的成长？", "question_sub": "nǐ zěnme kàndài zìjǐ de chéngzhǎng?", "answer": "成长是一个慢慢进步的过程。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 67 | 社交与人际关系
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 37, N'LEVEL 67 | 社交与人际关系', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得建立良好人际关系重要吗？", "question_sub": "nǐ juéde jiànlì liánghǎo rénjì guānxi zhòngyào ma?", "answer": "很重要，人际关系影响生活质量。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得建立良好人际关系重要吗？", "question_sub": "nǐ juéde jiànlì liánghǎo rénjì guānxi zhòngyào ma?", "answer": "很重要，有好的人际关系可以互相帮助。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么和新朋友相处？", "question_sub": "nǐ zěnme hé xīn péngyou xiāngchǔ?", "answer": "我主动打招呼，也认真倾听。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么和新朋友相处？", "question_sub": "nǐ zěnme hé xīn péngyou xiāngchǔ?", "answer": "我尊重他们，也分享自己的想法。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得沟通能力重要吗？", "question_sub": "nǐ juéde gōutōng nénglì zhòngyào ma?", "answer": "很重要，好的沟通可以解决问题。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 68 | 创造力
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 38, N'LEVEL 68 | 创造力', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己有创造力吗？", "question_sub": "nǐ juéde zìjǐ yǒu chuàngzàolì ma?", "answer": "有一点，我喜欢想新的方法。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自己有创造力吗？", "question_sub": "nǐ juéde zìjǐ yǒu chuàngzàolì ma?", "answer": "我觉得自己可以更有创造力。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么培养创造力？", "question_sub": "nǐ zěnme péiyǎng chuàngzàolì?", "answer": "我通过阅读和观察来培养。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么培养创造力？", "question_sub": "nǐ zěnme péiyǎng chuàngzàolì?", "answer": "我喜欢尝试新事物。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得创造力对工作有帮助吗？", "question_sub": "nǐ juéde chuàngzàolì duì gōngzuò yǒu bāngzhù ma?", "answer": "很有帮助，可以解决问题。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 69 | 责任感
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 39, N'LEVEL 69 | 责任感', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得有责任感重要吗？", "question_sub": "nǐ juéde yǒu zérèngǎn zhòngyào ma?", "answer": "很重要，责任感让人更可靠。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得有责任感重要吗？", "question_sub": "nǐ juéde yǒu zérèngǎn zhòngyào ma?", "answer": "很重要，这样别人才能信任你。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在哪些方面有责任感？", "question_sub": "nǐ zài nǎxiē fāngmiàn yǒu zérèngǎn?", "answer": "在学习方面，我认真完成作业。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你在哪些方面有责任感？", "question_sub": "nǐ zài nǎxiē fāngmiàn yǒu zérèngǎn?", "answer": "在家庭方面，我帮助家人。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么培养责任感？", "question_sub": "nǐ zěnme péiyǎng zérèngǎn?", "answer": "从小事做起，认真对待每件事。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 70 | 语言学习策略
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 40, N'LEVEL 70 | 语言学习策略', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学外语最难的是什么？", "question_sub": "nǐ juéde xué wàiyǔ zuì nán de shì shénme?", "answer": "我觉得发音最难。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学外语最难的是什么？", "question_sub": "nǐ juéde xué wàiyǔ zuì nán de shì shénme?", "answer": "我觉得记住语法规则很难。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你用什么方法提高口语？", "question_sub": "nǐ yòng shénme fāngfǎ tígāo kǒuyǔ?", "answer": "我每天练习说话。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你用什么方法提高口语？", "question_sub": "nǐ yòng shénme fāngfǎ tígāo kǒuyǔ?", "answer": "我看中文视频，模仿发音。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得语言环境重要吗？", "question_sub": "nǐ juéde yǔyán huánjìng zhòngyào ma?", "answer": "很重要，可以快速提高。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 71 | 传统与现代
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 41, N'LEVEL 71 | 传统与现代', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得传统文化重要吗？", "question_sub": "nǐ juéde chuántǒng wénhuà zhòngyào ma?", "answer": "很重要，是我们的根。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得传统文化重要吗？", "question_sub": "nǐ juéde chuántǒng wénhuà zhòngyào ma?", "answer": "很重要，可以让我们了解历史。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "传统文化和现代生活有冲突吗？", "question_sub": "chuántǒng wénhuà hé xiàndài shēnghuó yǒu chōngtū ma?", "answer": "有时候有，但可以找到平衡。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "传统文化和现代生活有冲突吗？", "question_sub": "chuántǒng wénhuà hé xiàndài shēnghuó yǒu chōngtū ma?", "answer": "不太有，可以互相结合。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么在现代生活中保持传统？", "question_sub": "nǐ zěnme zài xiàndài shēnghuó zhōng bǎochí chuántǒng?", "answer": "我们家每年都过传统节日。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 72 | 教育的意义
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 42, N'LEVEL 72 | 教育的意义', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得教育的目的是什么？", "question_sub": "nǐ juéde jiàoyù de mùdì shì shénme?", "answer": "教育的目的是让人获得知识和能力。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得教育的目的是什么？", "question_sub": "nǐ juéde jiàoyù de mùdì shì shénme?", "answer": "教育也是培养人格和价值观的过程。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学校教育和家庭教育哪个更重要？", "question_sub": "nǐ juéde xuéxiào jiàoyù hé jiātíng jiàoyù nǎ gè gèng zhòngyào?", "answer": "两个都很重要，互相补充。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学校教育和家庭教育哪个更重要？", "question_sub": "nǐ juéde xuéxiào jiàoyù hé jiātíng jiàoyù nǎ gè gèng zhòngyào?", "answer": "家庭教育更基础，影响性格。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得自学能力重要吗？", "question_sub": "nǐ juéde zìxué nénglì zhòngyào ma?", "answer": "很重要，可以不断进步。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 73 | 媒体与信息
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 43, N'LEVEL 73 | 媒体与信息', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你从哪里获取新闻？", "question_sub": "nǐ cóng nǎlǐ huòqǔ xīnwén?", "answer": "我从手机上看新闻。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你从哪里获取新闻？", "question_sub": "nǐ cóng nǎlǐ huòqǔ xīnwén?", "answer": "我看电视新闻。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得网络信息可靠吗？", "question_sub": "nǐ juéde wǎngluò xìnxī kěkào ma?", "answer": "不一定，要分辨真假。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得网络信息可靠吗？", "question_sub": "nǐ juéde wǎngluò xìnxī kěkào ma?", "answer": "有些可靠，但要注意辨别。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么判断信息的真假？", "question_sub": "nǐ zěnme pànduàn xìnxī de zhēnjiǎ?", "answer": "我会查看多个来源。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 74 | 全球化
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 44, N'LEVEL 74 | 全球化', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得全球化对生活有什么影响？", "question_sub": "nǐ juéde quánqiúhuà duì shēnghuó yǒu shénme yǐngxiǎng?", "answer": "全球化让我们可以了解更多文化。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得全球化对生活有什么影响？", "question_sub": "nǐ juéde quánqiúhuà duì shēnghuó yǒu shénme yǐngxiǎng?", "answer": "全球化带来了更多机会。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "全球化有什么问题？", "question_sub": "quánqiúhuà yǒu shénme wèntí?", "answer": "文化差异可能带来误解。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "全球化有什么问题？", "question_sub": "quánqiúhuà yǒu shénme wèntí?", "answer": "一些传统文化可能受到影响。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得学习外语和全球化有关系吗？", "question_sub": "nǐ juéde xuéxí wàiyǔ hé quánqiúhuà yǒu guānxi ma?", "answer": "有关系，外语是沟通的桥梁。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 75 | 人生规划
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 45, N'LEVEL 75 | 人生规划', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你对未来有什么规划？", "question_sub": "nǐ duì wèilái yǒu shénme guīhuà?", "answer": "我计划继续学习，找到好工作。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你对未来有什么规划？", "question_sub": "nǐ duì wèilái yǒu shénme guīhuà?", "answer": "我希望能在中国工作一段时间。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得规划未来重要吗？", "question_sub": "nǐ juéde guīhuà wèilái zhòngyào ma?", "answer": "很重要，有计划才有方向。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得规划未来重要吗？", "question_sub": "nǐ juéde guīhuà wèilái zhòngyào ma?", "answer": "很重要，可以更好地实现目标。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得人生中最重要的事情是什么？", "question_sub": "nǐ juéde rénshēng zhōng zuì zhòngyào de shìqing shì shénme?", "answer": "我觉得健康和家人最重要。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 76 | 文学与艺术
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 46, N'LEVEL 76 | 文学与艺术', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢文学或者艺术吗？", "question_sub": "nǐ xǐhuān wénxué huòzhě yìshù ma?", "answer": "我喜欢看小说。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你喜欢文学或者艺术吗？", "question_sub": "nǐ xǐhuān wénxué huòzhě yìshù ma?", "answer": "我对绘画很感兴趣。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得文学和艺术对生活有什么意义？", "question_sub": "nǐ juéde wénxué hé yìshù duì shēnghuó yǒu shénme yìyì?", "answer": "可以丰富我们的精神生活。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得文学和艺术对生活有什么意义？", "question_sub": "nǐ juéde wénxué hé yìshù duì shēnghuó yǒu shénme yìyì?", "answer": "可以帮助我们理解世界。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你有创作的经历吗？", "question_sub": "nǐ yǒu chuàngzuò de jīnglì ma?", "answer": "我写过日记和短文。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 77 | 经济与消费
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 47, N'LEVEL 77 | 经济与消费', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么管理自己的钱？", "question_sub": "nǐ zěnme guǎnlǐ zìjǐ de qián?", "answer": "我会记录每天的消费。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你怎么管理自己的钱？", "question_sub": "nǐ zěnme guǎnlǐ zìjǐ de qián?", "answer": "我尽量不乱花钱。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得节省重要吗？", "question_sub": "nǐ juéde jiéshěng zhòngyào ma?", "answer": "很重要，可以为未来做准备。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得节省重要吗？", "question_sub": "nǐ juéde jiéshěng zhòngyào ma?", "answer": "很重要，但也要适当消费。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你对购物有什么看法？", "question_sub": "nǐ duì gòuwù yǒu shénme kànfǎ?", "answer": "我喜欢买需要的东西，不乱买。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 78 | 心理健康
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 48, N'LEVEL 78 | 心理健康', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得心理健康重要吗？", "question_sub": "nǐ juéde xīnlǐ jiànkāng zhòngyào ma?", "answer": "很重要，和身体健康一样重要。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得心理健康重要吗？", "question_sub": "nǐ juéde xīnlǐ jiànkāng zhòngyào ma?", "answer": "很重要，影响我们的生活质量。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你遇到困难时怎么调整心情？", "question_sub": "nǐ yùdào kùnnán shí zěnme tiáozhěng xīnqíng?", "answer": "我和朋友或家人聊天。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你遇到困难时怎么调整心情？", "question_sub": "nǐ yùdào kùnnán shí zěnme tiáozhěng xīnqíng?", "answer": "我通过运动来放松。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得求助重要吗？", "question_sub": "nǐ juéde qiúzhù zhòngyào ma?", "answer": "很重要，遇到问题要找人帮忙。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 79 | 合理饮食
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 49, N'LEVEL 79 | 合理饮食', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得均衡饮食重要吗？", "question_sub": "nǐ juéde jūnhéng yǐnshí zhòngyào ma?", "answer": "很重要，可以保持健康。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得均衡饮食重要吗？", "question_sub": "nǐ juéde jūnhéng yǐnshí zhòngyào ma?", "answer": "很重要，不同食物提供不同营养。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么食物最健康？", "question_sub": "nǐ juéde shénme shíwù zuì jiànkāng?", "answer": "我觉得蔬菜和水果最健康。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么食物最健康？", "question_sub": "nǐ juéde shénme shíwù zuì jiànkāng?", "answer": "我认为均衡摄入各种食物最重要。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你平时注意饮食吗？", "question_sub": "nǐ píngshí zhùyì yǐnshí ma?", "answer": "比较注意，我少吃油腻食物。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 80 | 运动与健康
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 50, N'LEVEL 80 | 运动与健康', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得运动和健康有什么关系？", "question_sub": "nǐ juéde yùndòng hé jiànkāng yǒu shénme guānxi?", "answer": "运动可以增强体质，减少生病。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得运动和健康有什么关系？", "question_sub": "nǐ juéde yùndòng hé jiànkāng yǒu shénme guānxi?", "answer": "运动对身心都有好处。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢什么运动？为什么？", "question_sub": "nǐ zuì xǐhuān shénme yùndòng? wèishénme?", "answer": "我喜欢跑步，因为简单方便。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你最喜欢什么运动？为什么？", "question_sub": "nǐ zuì xǐhuān shénme yùndòng? wèishénme?", "answer": "我喜欢游泳，因为对身体很好。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得多久运动一次合适？", "question_sub": "nǐ juéde duō jiǔ yùndòng yí cì héshì?", "answer": "我觉得每天运动最好。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 81 | 自我发展
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 51, N'LEVEL 81 | 自我发展', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为一个人应该如何不断提升自己？", "question_sub": "nǐ rènwéi yí gè rén yīnggāi rúhé bùduàn tíshēng zìjǐ?", "answer": "我认为一个人不仅要不断学习新知识，而且要通过实践提高自己的能力。只有把学到的东西用在实际生活中，才能真正进步。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为一个人应该如何不断提升自己？", "question_sub": "nǐ rènwéi yí gè rén yīnggāi rúhé bùduàn tíshēng zìjǐ?", "answer": "在我看来，自我发展需要长期坚持。一方面要学习，另一方面也要反思自己的不足，这样才能慢慢提高。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自我发展的过程中最重要的是什么？", "question_sub": "zìwǒ fāzhǎn de guòchéng zhōng zuì zhòngyào de shì shénme?", "answer": "我觉得最重要的是坚持，因为很多人一开始很努力，但后来就放弃了。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 82 | 机会与选择
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 52, N'LEVEL 82 | 机会与选择', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为机会重要还是选择重要？", "question_sub": "nǐ rènwéi jīhuì zhòngyào háishì xuǎnzé zhòngyào?", "answer": "我认为两者都很重要，但是选择更关键。因为即使有机会，如果选择不对，也很难成功。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为机会重要还是选择重要？", "question_sub": "nǐ rènwéi jīhuì zhòngyào háishì xuǎnzé zhòngyào?", "answer": "在我看来，机会决定开始，而选择决定结果。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "当机会来临时，你通常怎么做决定？", "question_sub": "dāng jīhuì láilín shí, nǐ tōngcháng zěnme zuò juédìng?", "answer": "我会先分析利与弊，然后再做决定，而不是马上行动。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 83 | 金钱观
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 53, N'LEVEL 83 | 金钱观', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你如何看待金钱在生活中的作用？", "question_sub": "nǐ rúhé kàndài jīnqián zài shēnghuó zhōng de zuòyòng?", "answer": "我认为金钱非常重要，因为它可以满足基本生活需求，但它并不能代表一切。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你如何看待金钱在生活中的作用？", "question_sub": "nǐ rúhé kàndài jīnqián zài shēnghuó zhōng de zuòyòng?", "answer": "金钱不仅可以带来方便，而且可以让人有更多选择，但不能带来真正的幸福。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为有钱就一定幸福吗？为什么？", "question_sub": "nǐ rènwéi yǒu qián jiù yīdìng xìngfú ma? wèishénme?", "answer": "不一定，因为幸福还包括感情、健康等方面。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 84 | 网络对社会的影响
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 54, N'LEVEL 84 | 网络对社会的影响', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "网络的发展对社会有哪些积极和消极影响？", "question_sub": "wǎngluò de fāzhǎn duì shèhuì yǒu nǎxiē jījí hé xiāojí yǐngxiǎng?", "answer": "一方面，网络让信息传播更快，也方便人们交流；另一方面，也带来了虚假信息等问题。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "网络的发展对社会有哪些积极和消极影响？", "question_sub": "wǎngluò de fāzhǎn duì shèhuì yǒu nǎxiē jījí hé xiāojí yǐngxiǎng?", "answer": "网络不仅提高了效率，而且改变了人们的生活方式，但同时也让人更加依赖电子产品。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为人们是否应该减少使用网络？", "question_sub": "nǐ rènwéi rénmen shìfǒu yīnggāi jiǎnshǎo shǐyòng wǎngluò?", "answer": "我觉得不需要完全减少，而是要合理使用。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 85 | 阅读的意义
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 55, N'LEVEL 85 | 阅读的意义', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "在信息时代，阅读还有必要吗？", "question_sub": "zài xìnxī shídài, yuèdú hái yǒu bìyào ma?", "answer": "我认为非常有必要，因为阅读可以提高思考能力，而不仅仅是获取信息。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "在信息时代，阅读还有必要吗？", "question_sub": "zài xìnxī shídài, yuèdú hái yǒu bìyào ma?", "answer": "即使现在有很多视频，人们也不能完全放弃阅读。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为应该读什么样的书？", "question_sub": "nǐ rènwéi yīnggāi dú shénme yàng de shū?", "answer": "应该根据自己的需要选择，比如提高专业能力或扩大知识面。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 86 | 时间管理
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 56, N'LEVEL 86 | 时间管理', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么很多人觉得时间不够用？", "question_sub": "wèishénme hěn duō rén juéde shíjiān bú gòu yòng?", "answer": "因为他们没有合理安排时间，容易浪费时间。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么很多人觉得时间不够用？", "question_sub": "wèishénme hěn duō rén juéde shíjiān bú gòu yòng?", "answer": "一方面事情太多，另一方面没有计划。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "如何提高时间利用效率？", "question_sub": "rúhé tígāo shíjiān lìyòng xiàolǜ?", "answer": "我觉得应该先做重要的事情，而不是先做简单的事情。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 87 | 努力与天赋
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 57, N'LEVEL 87 | 努力与天赋', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "努力和天赋哪个更重要？", "question_sub": "nǔlì hé tiānfù nǎ gè gèng zhòngyào?", "answer": "我认为努力更重要，因为天赋只是基础，而成功需要长期努力。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "努力和天赋哪个更重要？", "question_sub": "nǔlì hé tiānfù nǎ gè gèng zhòngyào?", "answer": "天赋可以帮助一个人更快进步，但如果不努力，也不会成功。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你如何看待【努力一定成功】这句话？", "question_sub": "nǐ rúhé kàndài nǔlì yīdìng chénggōng zhè jù huà?", "answer": "我觉得不完全正确，但努力是成功的重要条件。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 88 | 团队合作
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 58, N'LEVEL 88 | 团队合作', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么团队合作越来越重要？", "question_sub": "wèishénme tuánduì hézuò yuèlái yuè zhòngyào?", "answer": "因为现在很多工作都需要多个人一起完成。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么团队合作越来越重要？", "question_sub": "wèishénme tuánduì hézuò yuèlái yuè zhòngyào?", "answer": "团队合作不仅可以提高效率，而且可以互相学习。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "如何成为一个好的团队成员？", "question_sub": "rúhé chéngwéi yí gè hǎo de tuánduì chéngyuán?", "answer": "要有责任感，也要学会沟通。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 89 | 失败的价值
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 59, N'LEVEL 89 | 失败的价值', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失败对一个人有什么意义？", "question_sub": "shībài duì yí gè rén yǒu shénme yìyì?", "answer": "失败可以让人发现自己的问题，从而改进。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失败对一个人有什么意义？", "question_sub": "shībài duì yí gè rén yǒu shénme yìyì?", "answer": "在我看来，失败不仅是结束，也是新的开始。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "面对失败应该怎么做？", "question_sub": "miànduì shībài yīnggāi zěnme zuò?", "answer": "应该总结经验，而不是放弃。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 90 | 学习态度
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 60, N'LEVEL 90 | 学习态度', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "什么是好的学习态度？", "question_sub": "shénme shì hǎo de xuéxí tàidu?", "answer": "好的学习态度是认真、主动，并且坚持。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "什么是好的学习态度？", "question_sub": "shénme shì hǎo de xuéxí tàidu?", "answer": "不仅要完成任务，而且要真正理解内容。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学习过程中最容易出现的问题是什么？", "question_sub": "xuéxí guòchéng zhōng zuì róngyì chūxiàn de wèntí shì shénme?", "answer": "很多人缺乏耐心，容易放弃。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 91 | 生活方式选择
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 61, N'LEVEL 91 | 生活方式选择', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "什么样的生活方式更健康？", "question_sub": "shénme yàng de shēnghuó fāngshì gèng jiànkāng?", "answer": "我认为规律的生活方式最健康，比如早睡早起。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "什么样的生活方式更健康？", "question_sub": "shénme yàng de shēnghuó fāngshì gèng jiànkāng?", "answer": "不仅要注意饮食，还要保持良好的心态。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "现代人的生活方式有什么问题？", "question_sub": "xiàndài rén de shēnghuó fāngshì yǒu shénme wèntí?", "answer": "很多人工作压力大，经常熬夜。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 92 | 情绪管理
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 62, N'LEVEL 92 | 情绪管理', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么情绪管理很重要？", "question_sub": "wèishénme qíngxù guǎnlǐ hěn zhòngyào?", "answer": "因为情绪会影响我们的判断和行为。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么情绪管理很重要？", "question_sub": "wèishénme qíngxù guǎnlǐ hěn zhòngyào?", "answer": "如果不能控制情绪，就容易做出错误决定。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你通常如何调节自己的情绪？", "question_sub": "nǐ tōngcháng rúhé tiáojié zìjǐ de qíngxù?", "answer": "我会先冷静下来，然后再思考问题。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 93 | 竞争与合作
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 63, N'LEVEL 93 | 竞争与合作', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "竞争和合作哪个更重要？", "question_sub": "jìngzhēng hé hézuò nǎ gè gèng zhòngyào?", "answer": "我认为两者都重要，需要根据情况选择。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "竞争和合作哪个更重要？", "question_sub": "jìngzhēng hé hézuò nǎ gè gèng zhòngyào?", "answer": "一方面竞争可以提高能力，另一方面合作可以提高效率。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "过度竞争会带来什么问题？", "question_sub": "guòdù jìngzhēng huì dài lái shénme wèntí?", "answer": "可能会影响人际关系。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 94 | 未来社会发展
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 64, N'LEVEL 94 | 未来社会发展', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为未来社会会发生哪些变化？", "question_sub": "nǐ rènwéi wèilái shèhuì huì fāshēng nǎxiē biànhuà?", "answer": "科技会更加发达，人们的生活会更加方便。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为未来社会会发生哪些变化？", "question_sub": "nǐ rènwéi wèilái shèhuì huì fāshēng nǎxiē biànhuà?", "answer": "同时竞争也会更加激烈。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人们需要具备什么能力？", "question_sub": "rénmen xūyào jùbèi shénme nénglì?", "answer": "需要学习能力和适应能力。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 95 | 道德与选择
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 65, N'LEVEL 95 | 道德与选择', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "面对困难选择时，你会考虑什么？", "question_sub": "miànduì kùnnán xuǎnzé shí, nǐ huì kǎolǜ shénme?", "answer": "我会考虑对别人和社会的影响。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "面对困难选择时，你会考虑什么？", "question_sub": "miànduì kùnnán xuǎnzé shí, nǐ huì kǎolǜ shénme?", "answer": "我会坚持自己的原则。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么道德很重要？", "question_sub": "wèishénme dàodé hěn zhòngyào?", "answer": "因为它可以保证社会的稳定。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 96 | 人生意义
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 66, N'LEVEL 96 | 人生意义', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为人生的意义是什么？", "question_sub": "nǐ rènwéi rénshēng de yìyì shì shénme?", "answer": "我认为人生的意义在于实现自己的价值。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你认为人生的意义是什么？", "question_sub": "nǐ rènwéi rénshēng de yìyì shì shénme?", "answer": "也在于帮助别人，让社会变得更好。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "每个人的人生意义一样吗？", "question_sub": "měi gè rén de rénshēng yìyì yíyàng ma?", "answer": "不一样，因为每个人的目标不同。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 97 | 幸福与成功的关系
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 67, N'LEVEL 97 | 幸福与成功的关系', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福和成功之间有什么关系？", "question_sub": "xìngfú hé chénggōng zhī jiān yǒu shénme guānxi?", "answer": "成功可以带来幸福，但不是唯一因素。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福和成功之间有什么关系？", "question_sub": "xìngfú hé chénggōng zhī jiān yǒu shénme guānxi?", "answer": "幸福更重要，因为成功不一定让人快乐。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "如果必须选择，你会选哪个？", "question_sub": "rúguǒ bìxū xuǎnzé, nǐ huì xuǎn nǎ gè?", "answer": "我会选择幸福。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 98 | 终身学习
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 68, N'LEVEL 98 | 终身学习', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么人应该终身学习？", "question_sub": "wèishénme rén yīnggāi zhōngshēn xuéxí?", "answer": "因为社会变化很快，不学习就会落后。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "为什么人应该终身学习？", "question_sub": "wèishénme rén yīnggāi zhōngshēn xuéxí?", "answer": "学习不仅是为了工作，也是为了提升自己。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你打算如何继续学习？", "question_sub": "nǐ dǎsuàn rúhé jìxù xuéxí?", "answer": "我会通过阅读和上网学习新知识。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 99 | 自信的重要性
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 69, N'LEVEL 99 | 自信的重要性', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自信对一个人有什么影响？", "question_sub": "zìxìn duì yí gè rén yǒu shénme yǐngxiǎng?", "answer": "自信可以让人更勇敢面对挑战。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自信对一个人有什么影响？", "question_sub": "zìxìn duì yí gè rén yǒu shénme yǐngxiǎng?", "answer": "也可以提高成功的可能性。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "如何建立自信？", "question_sub": "rúhé jiànlì zìxìn?", "answer": "通过不断成功的小经验。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 100 | 人生观
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 70, N'LEVEL 100 | 人生观', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的人生观是什么？", "question_sub": "nǐ de rénshēngguān shì shénme?", "answer": "我认为应该努力工作，同时也要享受生活。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你的人生观是什么？", "question_sub": "nǐ de rénshēngguān shì shénme?", "answer": "人生不仅要成功，也要快乐。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么样的人生是成功的？", "question_sub": "nǐ juéde shénme yàng de rénshēng shì chénggōng de?", "answer": "我觉得实现目标的人生是成功的。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "你觉得什么样的人生是成功的？", "question_sub": "nǐ juéde shénme yàng de rénshēng shì chénggōng de?", "answer": "能够让自己和家人幸福就是成功。", "answer_sub": ""}', 'discussion', @LessonId);

-- Course: ENG 1 -30
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'English';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('ENG', N'', 1, 3, N'ENG 1 -30', 'English', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 1 | SAYING WHO I AM
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 1 | SAYING WHO I AM', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My name", "question_sub": "", "answer": "My full name", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My name", "question_sub": "", "answer": "My nickname", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My name", "question_sub": "", "answer": "How people call me", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Where I’m from", "question_sub": "", "answer": "Country", "answer_sub": ""}', 'ice_breaker', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Where I’m from", "question_sub": "", "answer": "City", "answer_sub": ""}', 'ice_breaker', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Where I’m from", "question_sub": "", "answer": "One simple fact", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Me now", "question_sub": "", "answer": "Student / worker", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Me now", "question_sub": "", "answer": "Simple sentence: “I am…”", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "One thing about me", "question_sub": "", "answer": "I like…", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "One thing about me", "question_sub": "", "answer": "I don’t like…", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Repeat & swap", "question_sub": "", "answer": "Ask and answer with partners", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Mini story", "question_sub": "", "answer": "“My name is… I’m from… I am…”", "answer_sub": ""}', 'wrapup', @LessonId);

-- Course: ENG 31-60
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'English';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('ENG', N'', 1, 4, N'ENG 31-60', 'English', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 31 | MY TYPICAL WEEK
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 31 | MY TYPICAL WEEK', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Weekdays routine", "question_sub": "", "answer": "Talk about a normal weekday from morning to night.", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Weekdays routine", "question_sub": "", "answer": "(What time you wake up, work/study, rest)", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Weekend routine", "question_sub": "", "answer": "Compare what you do on weekends vs weekdays.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Busy vs free days", "question_sub": "", "answer": "Describe a busy day and a free day.", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Busy vs free days", "question_sub": "", "answer": "Say which one you prefer and why (simple reasons).", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Study/work balance", "question_sub": "", "answer": "Explain how you balance work/study and rest.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Changes in my week", "question_sub": "", "answer": "Talk about changes in your routine recently.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Weekly summary story", "question_sub": "", "answer": "Tell the story of one full week in your life.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 32 | TIME MANAGEMENT
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 32 | TIME MANAGEMENT', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Morning time", "question_sub": "", "answer": "Describe your morning routine and how you use time.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Busy hours", "question_sub": "", "answer": "Talk about the busiest time of your day.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Being late / early", "question_sub": "", "answer": "Share experiences of being late or early.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Planning the day", "question_sub": "", "answer": "Explain how you plan your day (or don’t).", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Time problems", "question_sub": "", "answer": "Talk about problems with time (too busy, tired).", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Better time habits", "question_sub": "", "answer": "Explain one habit you want to improve.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 33 | FOOD, HABITS & LIFESTYLE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 33 | FOOD, HABITS & LIFESTYLE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily meals", "question_sub": "", "answer": "Describe what you eat in a normal day.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Eating habits", "question_sub": "", "answer": "Talk about eating times, snacks, drinks.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Cooking vs eating out", "question_sub": "", "answer": "Compare eating at home and eating outside.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Healthy vs unhealthy", "question_sub": "", "answer": "Give examples of healthy and unhealthy habits.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Food changes", "question_sub": "", "answer": "Talk about changes in your eating habits.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Lifestyle reflection", "question_sub": "", "answer": "Explain how food affects your daily life.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 34 | PLACES I OFTEN GO
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 34 | PLACES I OFTEN GO', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Work/study places", "question_sub": "", "answer": "Describe places where you work or study.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Food & coffee places", "question_sub": "", "answer": "Talk about cafes or restaurants you like.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Shopping places", "question_sub": "", "answer": "Describe where you usually shop.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Relaxing places", "question_sub": "", "answer": "Talk about places where you relax.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Why I like them", "question_sub": "", "answer": "Explain why you like these places.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My daily map", "question_sub": "", "answer": "Describe your daily movement between places.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 35 | PEOPLE IN MY DAILY LIFE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 35 | PEOPLE IN MY DAILY LIFE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "People at work/school", "question_sub": "", "answer": "Talk about people you meet every day.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Friends & classmates", "question_sub": "", "answer": "Describe your friends or classmates.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Family contact", "question_sub": "", "answer": "Explain how often you talk to family.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Neighbors", "question_sub": "", "answer": "Talk about your neighbors or people nearby.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Communication style", "question_sub": "", "answer": "Describe how you communicate with people.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "People summary", "question_sub": "", "answer": "Summarize who is important in your daily life.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 36 | PAST EXPERIENCES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 36 | PAST EXPERIENCES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Good experience", "question_sub": "", "answer": "Tell a positive experience from the past.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Bad experience", "question_sub": "", "answer": "Describe a difficult or unpleasant experience.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "First-time experience", "question_sub": "", "answer": "Talk about doing something for the first time.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "What I learned", "question_sub": "", "answer": "Explain what you learned from that experience.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Feelings then & now", "question_sub": "", "answer": "Compare how you felt then and now.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Experience story", "question_sub": "", "answer": "Tell the full story clearly.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 37 | TRAVEL & TRANSPORTATION
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 37 | TRAVEL & TRANSPORTATION', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily commuting", "question_sub": "", "answer": "Describe how you travel daily.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Transport problems", "question_sub": "", "answer": "Talk about problems with transport.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Travel preferences", "question_sub": "", "answer": "Explain how you prefer to travel and why.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Past trip", "question_sub": "", "answer": "Describe a trip you took before.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Travel plans", "question_sub": "", "answer": "Talk about a trip you want to take.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Travel story", "question_sub": "", "answer": "Tell a complete travel story.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 38 | STUDYING & LEARNING
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 38 | STUDYING & LEARNING', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Subjects I study", "question_sub": "", "answer": "Describe what you study or learned before.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Learning methods", "question_sub": "", "answer": "Explain how you usually study.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Learning difficulties", "question_sub": "", "answer": "Talk about difficulties in learning.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Studying with others", "question_sub": "", "answer": "Compare studying alone vs with others.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Improving learning", "question_sub": "", "answer": "Explain how you want to improve.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Learning reflection", "question_sub": "", "answer": "Reflect on your learning journey.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 39 | WORK TASKS & RESPONSIBILITIES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 39 | WORK TASKS & RESPONSIBILITIES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My main tasks", "question_sub": "", "answer": "Describe your main daily tasks.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily responsibilities", "question_sub": "", "answer": "Talk about responsibilities at work/study.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Easy tasks", "question_sub": "", "answer": "Explain tasks you find easy.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Difficult tasks", "question_sub": "", "answer": "Describe tasks you find difficult.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Working with others", "question_sub": "", "answer": "Talk about teamwork experiences.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Workday summary", "question_sub": "", "answer": "Describe one full work/study day.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 40 | COMMUNICATION PROBLEMS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 40 | COMMUNICATION PROBLEMS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Language problems", "question_sub": "", "answer": "Talk about problems speaking or understanding.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Misunderstandings", "question_sub": "", "answer": "Describe a misunderstanding.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Asking for repetition", "question_sub": "", "answer": "Practice asking people to repeat or explain.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Clarifying meaning", "question_sub": "", "answer": "Explain how you clarify information.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Solving communication issues", "question_sub": "", "answer": "Talk about solutions.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Communication story", "question_sub": "", "answer": "Tell a communication problem story.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 41 | LIKES, DISLIKES & REASONS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 41 | LIKES, DISLIKES & REASONS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Things I like in daily life", "question_sub": "", "answer": "Talk about activities, food, places, or habits you like.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Things I dislike", "question_sub": "", "answer": "Describe things you don’t enjoy in daily life.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Giving reasons", "question_sub": "", "answer": "Explain why you like or dislike something (because, so).", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Changing preferences", "question_sub": "", "answer": "Talk about something you liked before but not now (or vice versa).", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Comparing preferences", "question_sub": "", "answer": "Compare two things you like or dislike (A vs B).", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Personal taste summary", "question_sub": "", "answer": "Summarize what your likes say about you.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 42 | MAKING CHOICES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 42 | MAKING CHOICES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily small choices", "question_sub": "", "answer": "Talk about choices you make every day (food, clothes, time).", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Study/work choices", "question_sub": "", "answer": "Describe choices related to study or work.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Choosing between two options", "question_sub": "", "answer": "Explain how you choose A or B.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Simple pros & cons", "question_sub": "", "answer": "Talk about good and bad points of a choice.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Satisfied or regretful choices", "question_sub": "", "answer": "Describe a choice you feel good or bad about.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Decision story", "question_sub": "", "answer": "Tell the story of one decision from start to result.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 43 | TECHNOLOGY IN DAILY LIFE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 43 | TECHNOLOGY IN DAILY LIFE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily phone use", "question_sub": "", "answer": "Describe how you use your phone every day.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Apps and tools", "question_sub": "", "answer": "Talk about apps or tools you often use.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Benefits of technology", "question_sub": "", "answer": "Explain how technology helps your life.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Problems with technology", "question_sub": "", "answer": "Describe problems or stress caused by technology.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Technology habits", "question_sub": "", "answer": "Talk about good or bad tech habits.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Technology reflection", "question_sub": "", "answer": "Summarize how technology affects your life.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 44 | ENTERTAINMENT & MEDIA
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 44 | ENTERTAINMENT & MEDIA', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Movies and series", "question_sub": "", "answer": "Describe movies or series you watch.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Music and audio", "question_sub": "", "answer": "Talk about music you like and when you listen.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Online entertainment", "question_sub": "", "answer": "Describe YouTube, TikTok, games, or online content.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Entertainment habits", "question_sub": "", "answer": "Explain how often and when you relax with media.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Watching alone or with others", "question_sub": "", "answer": "Compare entertainment alone vs with friends.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Entertainment story", "question_sub": "", "answer": "Tell a story about a memorable entertainment experience.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 45 | SHOPPING & SERVICES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 45 | SHOPPING & SERVICES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Shopping habits", "question_sub": "", "answer": "Describe what and how often you shop.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Online vs offline shopping", "question_sub": "", "answer": "Compare shopping online and in stores.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Price, quality & choice", "question_sub": "", "answer": "Talk about how you choose products.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Service experiences", "question_sub": "", "answer": "Describe good or bad service experiences.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Customer problems", "question_sub": "", "answer": "Talk about problems and how you solved them.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Shopping story", "question_sub": "", "answer": "Tell a full shopping experience story.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 46 | SOCIAL SITUATIONS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 46 | SOCIAL SITUATIONS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Meeting new people", "question_sub": "", "answer": "Describe how you meet new people.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Starting conversations", "question_sub": "", "answer": "Talk about common small talk topics.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Keeping conversations going", "question_sub": "", "answer": "Explain how you continue a conversation.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Feeling shy or confident", "question_sub": "", "answer": "Describe your feelings in social situations.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Social difficulties", "question_sub": "", "answer": "Talk about problems in social communication.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Social experience story", "question_sub": "", "answer": "Tell a story about a social situation.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 47 | WORKING WITH OTHERS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 17, N'LEVEL 47 | WORKING WITH OTHERS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Group tasks", "question_sub": "", "answer": "Describe tasks you do in a group.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Roles in teamwork", "question_sub": "", "answer": "Explain your role when working with others.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Teamwork problems", "question_sub": "", "answer": "Talk about problems in teamwork.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Giving opinions politely", "question_sub": "", "answer": "Practice sharing opinions politely.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Solving team issues", "question_sub": "", "answer": "Explain how problems were solved.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Teamwork reflection", "question_sub": "", "answer": "Summarize what you learned about teamwork.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 48 | DAILY PROBLEMS & SOLUTIONS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 18, N'LEVEL 48 | DAILY PROBLEMS & SOLUTIONS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Common daily problems", "question_sub": "", "answer": "Describe problems at work, study, or home.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Causes of problems", "question_sub": "", "answer": "Explain why these problems happen.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Asking for help", "question_sub": "", "answer": "Talk about how you ask for help.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Giving simple solutions", "question_sub": "", "answer": "Suggest simple ways to solve problems.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Results of solutions", "question_sub": "", "answer": "Explain what happened after solving the problem.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Problem-solving story", "question_sub": "", "answer": "Tell a full problem → solution story.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 49 | HEALTH, STRESS & BALANCE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 19, N'LEVEL 49 | HEALTH, STRESS & BALANCE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Feeling tired or stressed", "question_sub": "", "answer": "Describe when and why you feel tired.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Sources of stress", "question_sub": "", "answer": "Talk about things that cause stress.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Relaxing activities", "question_sub": "", "answer": "Explain what helps you relax.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Healthy habits", "question_sub": "", "answer": "Describe habits for better health.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Work–life balance", "question_sub": "", "answer": "Talk about balancing work/study and rest.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Health reflection", "question_sub": "", "answer": "Summarize your health and balance situation.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 50 | PLANS & DECISIONS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 20, N'LEVEL 50 | PLANS & DECISIONS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Short-term plans", "question_sub": "", "answer": "Describe plans for this week or month.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Changing plans", "question_sub": "", "answer": "Talk about plans that changed.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Planning with others", "question_sub": "", "answer": "Explain how you plan with friends or colleagues.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Difficult plans", "question_sub": "", "answer": "Describe plans that are hard to make.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Results of planning", "question_sub": "", "answer": "Talk about success or failure of plans.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Planning summary", "question_sub": "", "answer": "Summarize your planning style.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 51 | LIFE CHANGES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 21, N'LEVEL 51 | LIFE CHANGES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Life before", "question_sub": "", "answer": "Describe your life in the past.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Life now", "question_sub": "", "answer": "Talk about your current life.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Big changes", "question_sub": "", "answer": "Describe one important life change.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Small daily changes", "question_sub": "", "answer": "Talk about small changes in habits.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Positive & negative changes", "question_sub": "", "answer": "Compare good and bad changes.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Life change story", "question_sub": "", "answer": "Tell the story of a life change.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 52 | GOALS & MOTIVATION
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 22, N'LEVEL 52 | GOALS & MOTIVATION', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Personal goals", "question_sub": "", "answer": "Describe goals in your personal life.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Study or work goals", "question_sub": "", "answer": "Talk about career or study goals.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Motivation sources", "question_sub": "", "answer": "Explain what motivates you.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Difficulties and obstacles", "question_sub": "", "answer": "Talk about problems in reaching goals.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Staying motivated", "question_sub": "", "answer": "Describe how you keep going.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Goal reflection", "question_sub": "", "answer": "Summarize your goals and motivation.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 53 | DAILY LIFE COMPARISONS
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 23, N'LEVEL 53 | DAILY LIFE COMPARISONS', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Daily routines comparison", "question_sub": "", "answer": "Compare your life with others’.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "City vs quiet life", "question_sub": "", "answer": "Compare different living styles.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Work/study styles", "question_sub": "", "answer": "Compare ways of working or studying.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Past vs present", "question_sub": "", "answer": "Compare your past and present life.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Preferences", "question_sub": "", "answer": "Explain which you prefer and why.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Comparison summary", "question_sub": "", "answer": "Summarize your comparisons.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 54 | GIVING SIMPLE ADVICE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 24, N'LEVEL 54 | GIVING SIMPLE ADVICE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Common problems", "question_sub": "", "answer": "Describe common problems people have.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Giving advice", "question_sub": "", "answer": "Give advice using should / can.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Advice to friends", "question_sub": "", "answer": "Talk about advice you gave or received.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Good vs bad advice", "question_sub": "", "answer": "Compare helpful and unhelpful advice.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Following advice", "question_sub": "", "answer": "Talk about results of following advice.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Advice role-play", "question_sub": "", "answer": "Simulate giving advice in a situation.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 55 | PROBLEM-SOLVING TALK
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 25, N'LEVEL 55 | PROBLEM-SOLVING TALK', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Explaining a problem clearly", "question_sub": "", "answer": "Describe a problem step by step.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Causes of the problem", "question_sub": "", "answer": "Explain why it happened.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Possible solutions", "question_sub": "", "answer": "Suggest different solutions.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Choosing a solution", "question_sub": "", "answer": "Explain why you chose one solution.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Results", "question_sub": "", "answer": "Describe the outcome.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Problem case story", "question_sub": "", "answer": "Tell the full problem-solving story.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 56 | WORK & STUDY EXPERIENCES
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 26, N'LEVEL 56 | WORK & STUDY EXPERIENCES', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Best experiences", "question_sub": "", "answer": "Talk about a positive work/study experience.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Difficult moments", "question_sub": "", "answer": "Describe a challenging situation.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Mistakes and learning", "question_sub": "", "answer": "Talk about mistakes you made.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "People involved", "question_sub": "", "answer": "Describe people in that experience.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Changes after experience", "question_sub": "", "answer": "Explain how you changed.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Experience summary", "question_sub": "", "answer": "Summarize the experience.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 57 | OPINIONS ABOUT DAILY LIFE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 27, N'LEVEL 57 | OPINIONS ABOUT DAILY LIFE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Work vs study life", "question_sub": "", "answer": "Share opinions on work and study.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Busy vs relaxed life", "question_sub": "", "answer": "Compare two lifestyles.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Online vs offline life", "question_sub": "", "answer": "Talk about modern life.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Good and bad points", "question_sub": "", "answer": "Explain advantages and disadvantages.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Personal opinion", "question_sub": "", "answer": "Share your preference.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Opinion reflection", "question_sub": "", "answer": "Summarize your views.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 58 | EXPLAINING IDEAS CLEARLY
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 28, N'LEVEL 58 | EXPLAINING IDEAS CLEARLY', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Explaining routines", "question_sub": "", "answer": "Explain how you do something daily.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Explaining a process", "question_sub": "", "answer": "Describe steps of a simple process.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Giving examples", "question_sub": "", "answer": "Support ideas with examples.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Clarifying meaning", "question_sub": "", "answer": "Practice making ideas clear.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Checking understanding", "question_sub": "", "answer": "Ask if others understand.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Clear explanation story", "question_sub": "", "answer": "Explain something from start to end.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 59 | PREPARING FOR THE FUTURE
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 29, N'LEVEL 59 | PREPARING FOR THE FUTURE', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Future study or work ideas", "question_sub": "", "answer": "Talk about future directions.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Skills to learn", "question_sub": "", "answer": "Describe skills you want to improve.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Possible challenges", "question_sub": "", "answer": "Talk about future difficulties.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Preparation plans", "question_sub": "", "answer": "Explain how you prepare.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Hope and worries", "question_sub": "", "answer": "Share hopes and worries.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Future vision talk", "question_sub": "", "answer": "Describe your future life.", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 60 | MY LIFE, MY VOICE (STAGE EXIT)
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 30, N'LEVEL 60 | MY LIFE, MY VOICE (STAGE EXIT)', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My past", "question_sub": "", "answer": "Talk about where you started.", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My present", "question_sub": "", "answer": "Describe your current life.", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My strengths", "question_sub": "", "answer": "Talk about what you do well.", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My challenges", "question_sub": "", "answer": "Describe difficulties you face.", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "My future direction", "question_sub": "", "answer": "Talk about where you are going.", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "Full life narrative", "question_sub": "", "answer": "Tell your life story confidently.", "answer_sub": ""}', 'wrapup', @LessonId);

-- Course: JA_STAGE_1_LEVEL_1-30
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'Japanese';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('JAP', N'', 1, 5, N'JA_STAGE_1_LEVEL_1-30', 'Japanese', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 1 | 自己紹介
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 1 | 自己紹介', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "名前", "question_sub": "", "answer": "フルネーム", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "名前", "question_sub": "", "answer": "ニックネーム", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "出身", "question_sub": "", "answer": "国", "answer_sub": ""}', 'ice_breaker', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "出身", "question_sub": "", "answer": "都市", "answer_sub": ""}', 'ice_breaker', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "出身", "question_sub": "", "answer": "簡単な情報", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在の自分", "question_sub": "", "answer": "学生", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在の自分", "question_sub": "", "answer": "社会人", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分について", "question_sub": "", "answer": "好き", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分について", "question_sub": "", "answer": "嫌い", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "質問と応答", "question_sub": "", "answer": "質疑応答の練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "ミニストーリー", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "まとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 2 | 国と言語
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 2 | 国と言語', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分の国", "question_sub": "", "answer": "私の国について", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "使用言語", "question_sub": "", "answer": "話す言葉", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "周囲の言語", "question_sub": "", "answer": "周りの人が話す言葉", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "英語との関わり", "question_sub": "", "answer": "英語の利用", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "簡単な比較", "question_sub": "", "answer": "言語と言語の比較", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "本日のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 3 | 挨拶とマナー
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 3 | 挨拶とマナー', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "挨拶", "question_sub": "", "answer": "日常の挨拶", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "別れの表現", "question_sub": "", "answer": "さようならの表現", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "感謝と謝罪", "question_sub": "", "answer": "ありがとうとごめんなさい", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "短い会話", "question_sub": "", "answer": "日常のショートトーク", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ロールプレイ", "question_sub": "", "answer": "場面ごとの役割演技", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "wrapup | 反復練習", "question_sub": "", "answer": "繰り返しの練習", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 4 | 年齢と家族
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 4 | 年齢と家族', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "年齢", "question_sub": "", "answer": "私の年齢", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家族構成", "question_sub": "", "answer": "私の家族", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "同居者", "question_sub": "", "answer": "一緒に住んでいる人", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "簡単な説明", "question_sub": "", "answer": "家族の特徴", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家族について質問", "question_sub": "", "answer": "質問の練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ミニトーク", "question_sub": "", "answer": "家族についての短いお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 5 | 私の家
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 5 | 私の家', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "住んでいる場所", "question_sub": "", "answer": "私の地域", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家とアパート", "question_sub": "", "answer": "住居の種類", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "部屋", "question_sub": "", "answer": "私の部屋", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "お気に入りの場所", "question_sub": "", "answer": "家の中で好きなところ", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "比較", "question_sub": "", "answer": "昔の家と今の家の比較", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家のストーリー", "question_sub": "", "answer": "私の家のお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 6 | 日課
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 6 | 日課', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朝", "question_sub": "", "answer": "朝のルーティン", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "勉強と仕事", "question_sub": "", "answer": "日中の活動", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "夜", "question_sub": "", "answer": "夜の過ごし方", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間表現", "question_sub": "", "answer": "時間の言い方", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "平日 vs 週末", "question_sub": "", "answer": "平日の過ごし方と週末の過ごし方", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日のストーリー", "question_sub": "", "answer": "私の1日のお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 7 | 食べ物と飲み物
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 7 | 食べ物と飲み物', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朝食・昼食・夕食", "question_sub": "", "answer": "毎日の食事", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな食べ物", "question_sub": "", "answer": "大好物の話", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きと嫌い", "question_sub": "", "answer": "食べ物の好み", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな飲み物", "question_sub": "", "answer": "よく飲むもの", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食事の質問", "question_sub": "", "answer": "レストランでの会話練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日のまとめ", "question_sub": "", "answer": "食事についてのまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 8 | 趣味と自由時間
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 8 | 趣味と自由時間', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自由時間の活動", "question_sub": "", "answer": "暇な時の過ごし方", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "室内と屋外", "question_sub": "", "answer": "インドアアクティビティとアウトドアアクティビティ", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "週末の趣味", "question_sub": "", "answer": "土日の楽しみ", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友達と", "question_sub": "", "answer": "友達と一緒にすること", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "趣味の紹介", "question_sub": "", "answer": "自分の趣味を説明する練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "趣味に関するお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 9 | 周辺の場所
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 9 | 周辺の場所', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "店・カフェ・スーパー", "question_sub": "", "answer": "よく行くお店", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "近いと遠い", "question_sub": "", "answer": "距離の表現", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "簡単な道案内", "question_sub": "", "answer": "道に迷ったときの表現", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分のエリア", "question_sub": "", "answer": "近所のおすすめスポット", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "場所の質問", "question_sub": "", "answer": "位置を尋ねる練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "周辺環境のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 10 | 昨日
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 10 | 昨日', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "昨日の朝・昼・夜", "question_sub": "", "answer": "昨日の時間帯ごとの行動", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "行ったこと", "question_sub": "", "answer": "昨日したこと", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去の出来事", "question_sub": "", "answer": "楽しかったこと", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "質問", "question_sub": "", "answer": "過去の行動を尋ねる", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去形の練習", "question_sub": "", "answer": "動詞の過去形を使った発話", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "昨日の出来事のストーリー", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 11 | 買い物
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 11 | 買い物', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "買い物", "question_sub": "", "answer": "よく買うもの", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きなお店", "question_sub": "", "answer": "お気に入りのショップ", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "値段", "question_sub": "", "answer": "いくらですか", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "服のサイズ", "question_sub": "", "answer": "サイズと色", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "店員との会話", "question_sub": "", "answer": "買い物のロールプレイ", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "買い物のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 12 | 外食
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 12 | 外食', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "レストラン", "question_sub": "", "answer": "よく行くレストラン", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "メニュー", "question_sub": "", "answer": "食べたいものを選ぶ", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "注文", "question_sub": "", "answer": "これをお願いします", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "味の表現", "question_sub": "", "answer": "美味しいと辛い", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "注文の練習", "question_sub": "", "answer": "店員に注文するロールプレイ", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "外食의トークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 13 | 交通
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 13 | 交通', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "乗り物", "question_sub": "", "answer": "よく使う交通手段", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "駅とバス停", "question_sub": "", "answer": "移動の拠点", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "行き方", "question_sub": "", "answer": "目的地への移動方法", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間と費用", "question_sub": "", "answer": "どれくらいかかりますか", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "道を尋ねる", "question_sub": "", "answer": "駅への行き方を尋ねる練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "交通機関のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 14 | 天気と服装
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 14 | 天気と服装', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今日の天気", "question_sub": "", "answer": "天気の表現", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな季節", "question_sub": "", "answer": "春夏秋冬", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "服装", "question_sub": "", "answer": "今日の服", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "天気と活動", "question_sub": "", "answer": "雨の日の過ごし方", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "天気の会話", "question_sub": "", "answer": "明日の天気について話す練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "天気と服装のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 15 | 週末
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 15 | 週末', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今週末の予定", "question_sub": "", "answer": "土日のプラン", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "週末の天気", "question_sub": "", "answer": "週末の天候", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "誰と過ごすか", "question_sub": "", "answer": "家族や友達", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "行きたい場所", "question_sub": "", "answer": "週末のお出かけスポット", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "予定を立てる", "question_sub": "", "answer": "友達を誘う練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "週末のプランまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 16 | 仕事と勉強
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 16 | 仕事と勉強', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在の活動", "question_sub": "", "answer": "仕事か勉強か", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場と学校", "question_sub": "", "answer": "活動している場所", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "内容", "question_sub": "", "answer": "何について勉強しているか", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "同僚とクラスメイト", "question_sub": "", "answer": "周りの人々", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "業務と時間割", "question_sub": "", "answer": "1日のスケジュールを話す練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "仕事と勉強のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 17 | スキル
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 17, N'LEVEL 17 | スキル', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "できること", "question_sub": "", "answer": "得意なこと", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "パソコンのスキル", "question_sub": "", "answer": "ITツールの利用", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "言語スキル", "question_sub": "", "answer": "話せる言葉", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "これから学びたいこと", "question_sub": "", "answer": "未来のスキル", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自己PR", "question_sub": "", "answer": "自分のスキルを説明する練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "スキルのトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 18 | 健康
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 18, N'LEVEL 18 | 健康', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "今日の体調", "question_sub": "", "answer": "体調の表現", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "運動", "question_sub": "", "answer": "健康のためにすること", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "睡眠", "question_sub": "", "answer": "毎日の睡眠時間", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "病院", "question_sub": "", "answer": "風邪をひいたとき", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アドバイス", "question_sub": "", "answer": "健康的な生活について話す練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "健康のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 19 | 友達
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 19, N'LEVEL 19 | 友達', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "親友", "question_sub": "", "answer": "一番の友達", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "出会った場所", "question_sub": "", "answer": "友達との出会い", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "一緒にすること", "question_sub": "", "answer": "遊ぶ内容", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友達の性格", "question_sub": "", "answer": "どんな人ですか", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友達の紹介", "question_sub": "", "answer": "大切な友達を説明する練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "友達のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 20 | お気に入り
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 20, N'LEVEL 20 | お気に入り', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きなもの", "question_sub": "", "answer": "私のお気に入り", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "映画と音楽", "question_sub": "", "answer": "エンタメの好み", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "本とゲーム", "question_sub": "", "answer": "趣味の詳細", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "理由", "question_sub": "", "answer": "なぜ好きですか", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "おすすめ", "question_sub": "", "answer": "お気に入りのものを人に勧める練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "お気に入りのまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 21 | 旅行
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 21, N'LEVEL 21 | 旅行', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "行ったことがある場所", "question_sub": "", "answer": "過去の旅行", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "旅行の持ち物", "question_sub": "", "answer": "バッグの中身", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな旅行スタイル", "question_sub": "", "answer": "山か海か", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "次に行きたい場所", "question_sub": "", "answer": "未来の旅", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "旅行計画", "question_sub": "", "answer": "次の休みの計画を話す練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "旅行のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 22 | 祝日
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 22, N'LEVEL 22 | 祝日', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分の国の祝日", "question_sub": "", "answer": "お休みの日", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "特別な食べ物", "question_sub": "", "answer": "祝日に食べるもの", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過ごし方", "question_sub": "", "answer": "イベントの日", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "伝統的な行事", "question_sub": "", "answer": "お祭りや習慣", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "祝日の説明", "question_sub": "", "answer": "外国人に祝日を説明する練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "祝日のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 23 | 日常問題
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 23, N'LEVEL 23 | 日常問題', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "小さなトラブル", "question_sub": "", "answer": "よくある困りごと", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忘れ物", "question_sub": "", "answer": "鍵や財布", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "遅刻", "question_sub": "", "answer": "時間に遅れたとき", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "助けを求める", "question_sub": "", "answer": "手伝ってください", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "謝罪と説明", "question_sub": "", "answer": "トラブルのときの言い訳練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "トラブル解決のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 24 | 計画
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 24, N'LEVEL 24 | 計画', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "明日の計画", "question_sub": "", "answer": "近い未来の予定", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "来月の予定", "question_sub": "", "answer": "少し先のイベント", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来の夢", "question_sub": "", "answer": "やってみたいこと", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "準備", "question_sub": "", "answer": "計画のために必要なこと", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "目標設定", "question_sub": "", "answer": "これからの予定を具体的に話す練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "計画のトークまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 25 | テクノロジー
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 25, N'LEVEL 25 | テクノロジー', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "使うデバイス", "question_sub": "", "answer": "スマホやパソコン", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きなアプリ", "question_sub": "", "answer": "よく使うSNS", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "便利なところ", "question_sub": "", "answer": "生活がどう変わったか", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "困るところ", "question_sub": "", "answer": "使いすぎの注意", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アプリの紹介", "question_sub": "", "answer": "おすすめのアプリを説明する練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "テクノロジーのまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 26 | 英語学習
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 26, N'LEVEL 26 | 英語学習', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習理由", "question_sub": "", "answer": "なぜ英語を勉強しますか", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習方法", "question_sub": "", "answer": "私の勉強法", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常での使用", "question_sub": "", "answer": "どこで英語を使いますか", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "困難", "question_sub": "", "answer": "難しいところ", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "感情", "question_sub": "", "answer": "英語を話すときの気持ち", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習ストーリー", "question_sub": "", "answer": "私の英語学習のお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 27 | 仕事と生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 27, N'LEVEL 27 | 仕事と生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい日と暇な日", "question_sub": "", "answer": "毎日のスケジュール", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "バランス", "question_sub": "", "answer": "仕事とプライベートのバランス", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストレス", "question_sub": "", "answer": "疲れたとき", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "解決方法", "question_sub": "", "answer": "リラックスのやり方", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アドバイス", "question_sub": "", "answer": "良い生活バランスについて", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "生活トーク", "question_sub": "", "answer": "私のライフスタイルのお話", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 28 | 簡単な意見
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 28, N'LEVEL 28 | 簡単な意見', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きと嫌い", "question_sub": "", "answer": "自分の好み", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "A vs B", "question_sub": "", "answer": "どちらが好きですか", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食べ物", "question_sub": "", "answer": "食事についての意見", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "活動", "question_sub": "", "answer": "行動についての意見", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "選択", "question_sub": "", "answer": "理由を言って選ぶ練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "まとめ", "question_sub": "", "answer": "意見表明のまとめ", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 29 | 人生の変化
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 29, N'LEVEL 29 | 人生の変化', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去と現在", "question_sub": "", "answer": "昔と今の違い", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "小さな変化", "question_sub": "", "answer": "最近変わったこと", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い変化", "question_sub": "", "answer": "嬉しかった変化", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "未来", "question_sub": "", "answer": "これから変わること", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "比較の表現", "question_sub": "", "answer": "昔と今を比べる練習", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "変化についてのストーリー", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 30 | 私の人生
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 30, N'LEVEL 30 | 私の人生', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去", "question_sub": "", "answer": "私の子供時代", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在", "question_sub": "", "answer": "今の私", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常生活", "question_sub": "", "answer": "毎日のライフスタイル", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人名関係", "question_sub": "", "answer": "大切な人々", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来", "question_sub": "", "answer": "これからの人生", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "フルストーリー", "question_sub": "", "answer": "私の人生のストーリー", "answer_sub": ""}', 'wrapup', @LessonId);

-- Course: JA_STAGE_2_LEVEL_31-60_STANDARDIZED
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'Japanese';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('JAP', N'', 1, 6, N'JA_STAGE_2_LEVEL_31-60_STANDARDIZED', 'Japanese', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: 
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: 
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "", "question_sub": "", "answer": "JA_STAGE_2_LEVEL_31-60", "answer_sub": ""}', '', @LessonId);

  -- Chapter: LEVEL 31 | 私の1週間
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 31 | 私の1週間', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "平日のルーティン", "question_sub": "", "answer": "平日のルーティンについて話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "平日のルーティン", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "週末との比較", "question_sub": "", "answer": "週末との比較について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "週末との比較", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい日 vs 暇な日", "question_sub": "", "answer": "忙しい日 vs 暇な日について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい日 vs 暇な日", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "勉強／仕事と休息のバランス", "question_sub": "", "answer": "勉強／仕事と休息のバランスについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "勉強／仕事と休息のバランス", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "最近の変化", "question_sub": "", "answer": "最近の変化について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "最近の変化", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1週間のストーリー", "question_sub": "", "answer": "1週間のストーリーについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1週間のストーリー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 32 | 時間管理
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 32 | 時間管理', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朝の時間", "question_sub": "", "answer": "朝の時間について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "朝の時間", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい時間帯", "question_sub": "", "answer": "忙しい時間帯について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい時間帯", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "遅刻・早到着の経験", "question_sub": "", "answer": "遅刻・早到着の経験について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "遅刻・早到着の経験", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日の計画", "question_sub": "", "answer": "1日の計画について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日の計画", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間に関する問題", "question_sub": "", "answer": "時間に関する問題について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間に関する問題", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "改善したい習慣", "question_sub": "", "answer": "改善したい習慣について話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "改善したい習慣", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 33 | 食事・習慣・ライフスタイル
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 33 | 食事・習慣・ライフスタイル', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常の食事", "question_sub": "", "answer": "日常の食事について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常の食事", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食習慣", "question_sub": "", "answer": "食習慣について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食習慣", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自炊 vs 外食", "question_sub": "", "answer": "自炊 vs 外食について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自炊 vs 外食", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "健康 vs 不健康", "question_sub": "", "answer": "健康 vs 不健康について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "健康 vs 不健康", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食生活の変化", "question_sub": "", "answer": "食生活の変化について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "食生活の変化", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ライフスタイルの振り返り", "question_sub": "", "answer": "ライフスタイルの振り返りについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ライフスタイルの振り返り", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 34 | よく行く場所
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 34 | よく行く場所', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "勉強・仕事の場所", "question_sub": "", "answer": "勉強・仕事の場所について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "勉強・仕事の場所", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "カフェ・レストラン", "question_sub": "", "answer": "カフェ・レストランについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "カフェ・レストラン", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "買い物場所", "question_sub": "", "answer": "買い物場所について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "買い物場所", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リラックス場所", "question_sub": "", "answer": "リラックス場所について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リラックス場所", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな理由", "question_sub": "", "answer": "好きな理由について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好きな理由", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常の移動", "question_sub": "", "answer": "日常の移動について話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常の移動", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 35 | 日常の人間関係
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 35 | 日常の人間関係', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場・学校の人", "question_sub": "", "answer": "職場・学校の人について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場・学校の人", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友人・クラスメート", "question_sub": "", "answer": "友人・クラスメートについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友人・クラスメート", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家族との連絡", "question_sub": "", "answer": "家族との連絡について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "家族との連絡", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "近所の人", "question_sub": "", "answer": "近所の人について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "近所の人", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "コミュニケーションスタイル", "question_sub": "", "answer": "コミュニケーションスタイルについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "コミュニケーションスタイル", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人間関係まとめ", "question_sub": "", "answer": "人間関係まとめについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人間関係まとめ", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 36 | 過去の経験
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 36 | 過去の経験', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い経験", "question_sub": "", "answer": "良い経験について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い経験", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "悪い経験", "question_sub": "", "answer": "悪い経験について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "悪い経験", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "初めての経験", "question_sub": "", "answer": "初めての経験について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "初めての経験", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学んだこと", "question_sub": "", "answer": "学んだことについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学んだこと", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "感情の変化", "question_sub": "", "answer": "感情の変化について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "感情の変化", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 37 | 旅行と交通
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 37 | 旅行と交通', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "通勤", "question_sub": "", "answer": "通勤について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "通勤", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "交通問題", "question_sub": "", "answer": "交通問題について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "交通問題", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好み", "question_sub": "", "answer": "好みについて話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好み", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去の旅行", "question_sub": "", "answer": "過去の旅行について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去の旅行", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "未来の計画", "question_sub": "", "answer": "未来の計画について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "未来の計画", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "旅行ストーリー", "question_sub": "", "answer": "旅行ストーリーについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "旅行ストーリー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 38 | 学習
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 38 | 学習', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習内容", "question_sub": "", "answer": "学習内容について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習内容", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習方法", "question_sub": "", "answer": "学習方法について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習方法", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "困難", "question_sub": "", "answer": "困難について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "困難", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "一人 vs グループ", "question_sub": "", "answer": "一人 vs グループについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "一人 vs グループ", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "改善", "question_sub": "", "answer": "改善について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "改善", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "振り返り", "question_sub": "", "answer": "振り返りについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "振り返り", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 39 | 仕事と責任
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 39 | 仕事と責任', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "主なタスク", "question_sub": "", "answer": "主なタスクについて話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "主なタスク", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "責任", "question_sub": "", "answer": "責任について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "責任", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "簡単な仕事", "question_sub": "", "answer": "簡単な仕事について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "簡単な仕事", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "難しい仕事", "question_sub": "", "answer": "難しい仕事について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "難しい仕事", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "チームワーク", "question_sub": "", "answer": "チームワークについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "チームワーク", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日のまとめ", "question_sub": "", "answer": "1日のまとめについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "1日のまとめ", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 40 | コミュニケーション問題
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 40 | コミュニケーション問題', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "言語問題", "question_sub": "", "answer": "言語問題について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "言語問題", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "誤解", "question_sub": "", "answer": "誤解について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "誤解", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "聞き返し", "question_sub": "", "answer": "聞き返しについて話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "聞き返し", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意味確認", "question_sub": "", "answer": "意味確認について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意味確認", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "解決方法", "question_sub": "", "answer": "解決方法について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "解決方法", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 41 | 意見と選択
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 41 | 意見と選択', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好き・嫌い＋理由", "question_sub": "", "answer": "好き・嫌い＋理由について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "好き・嫌い＋理由", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意思決定", "question_sub": "", "answer": "意思決定について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意思決定", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジー", "question_sub": "", "answer": "テクノロジーについて話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "エンタメ", "question_sub": "", "answer": "エンタメについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "エンタメ", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "買い物・サービス", "question_sub": "", "answer": "買い物・サービスについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "買い物・サービス", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 46 | 社会的やり取り
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 46 | 社会的やり取り', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会状況", "question_sub": "", "answer": "社会状況について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会状況", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "チームワーク", "question_sub": "", "answer": "チームワークについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "チームワーク", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決", "question_sub": "", "answer": "問題解決について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "健康とストレス", "question_sub": "", "answer": "健康とストレスについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "健康とストレス", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "計画と意思決定", "question_sub": "", "answer": "計画と意思決定について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "計画と意思決定", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 51 | つながったスピーチ
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 51 | つながったスピーチ', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の変化", "question_sub": "", "answer": "人生の変化について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の変化", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "目標とモチベーション", "question_sub": "", "answer": "目標とモチベーションについて話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "目標とモチベーション", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "比較", "question_sub": "", "answer": "比較について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "比較", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アドバイス", "question_sub": "", "answer": "アドバイスについて話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アドバイス", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決", "question_sub": "", "answer": "問題解決について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

  -- Chapter: LEVEL 56 | B1-到達レベル
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 56 | B1-到達レベル', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "B1-の安定したスピーキング能力", "question_sub": "", "answer": "B1-の安定したスピーキング能力について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "B1-の安定したスピーキング能力", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "90分連続スピーキング可能", "question_sub": "", "answer": "90分連続スピーキング可能について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "90分連続スピーキング可能", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "説明・比較・理由付けが可能", "question_sub": "", "answer": "説明・比較・理由付けが可能について話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "説明・比較・理由付けが可能", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

  -- Chapter: LEVEL 60 | 私の人生
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 60 | 私の人生', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去", "question_sub": "", "answer": "過去について話します。", "answer_sub": ""}', 'warmup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在", "question_sub": "", "answer": "現在について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "強み", "question_sub": "", "answer": "強みについて話します。", "answer_sub": ""}', 'follow_up', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "強み", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "課題", "question_sub": "", "answer": "課題について話します。", "answer_sub": ""}', 'practice', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "課題", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来", "question_sub": "", "answer": "将来について話します。", "answer_sub": ""}', 'discussion', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生ストーリー", "question_sub": "", "answer": "人生ストーリーについて話します。", "answer_sub": ""}', 'wrapup', @LessonId);
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生ストーリー", "question_sub": "", "answer": "自分の経験や考えを説明します。", "answer_sub": ""}', 'wrapup', @LessonId);

-- Course: JA_STAGE_3_LEVEL_61-100
  SELECT TOP 1 @ProgId = id FROM program WHERE title = 'Japanese';
INSERT INTO course (code, description, [level], order_index, title, language, program_id) VALUES ('JAP', N'', 1, 7, N'JA_STAGE_3_LEVEL_61-100', 'Japanese', @ProgId);
SET @CourseId = SCOPE_IDENTITY();

  -- Chapter: LEVEL 61 | 学習と生活の管理
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 1, N'LEVEL 61 | 学習と生活の管理', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在のスケジュール", "question_sub": "", "answer": "現在のスケジュールについての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間管理方法", "question_sub": "", "answer": "時間管理方法についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "忙しい時期 vs 余裕のある時期", "question_sub": "", "answer": "忙しい時期 vs 余裕のある時期についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "時間に関する問題", "question_sub": "", "answer": "時間に関する問題についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "バランス改善", "question_sub": "", "answer": "バランス改善についての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "週間ストーリー", "question_sub": "", "answer": "週間ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 62 | 学習経験
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 2, N'LEVEL 62 | 学習経験', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い学習経験", "question_sub": "", "answer": "良い学習経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "難しい科目", "question_sub": "", "answer": "難しい科目についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習スタイル比較", "question_sub": "", "answer": "学習スタイル比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習課題", "question_sub": "", "answer": "学習課題についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "克服方法", "question_sub": "", "answer": "克服方法についての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学習ストーリー", "question_sub": "", "answer": "学習ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 63 | 人間関係
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 3, N'LEVEL 63 | 人間関係', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "重要な友人", "question_sub": "", "answer": "重要な友人についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "友人関係の築き方", "question_sub": "", "answer": "友人関係の築き方についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "関係の種類", "question_sub": "", "answer": "関係の種類についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "衝突・誤解", "question_sub": "", "answer": "衝突・誤解についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い関係の条件", "question_sub": "", "answer": "良い関係の条件についての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 64 | コミュニケーション能力
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 4, N'LEVEL 64 | コミュニケーション能力', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自分のスタイル", "question_sub": "", "answer": "自分のスタイルについての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "フォーマル vs インフォーマル", "question_sub": "", "answer": "フォーマル vs インフォーマルについての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "誤解経験", "question_sub": "", "answer": "誤解経験についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "コミュニケーション問題", "question_sub": "", "answer": "コミュニケーション問題についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "改善方法", "question_sub": "", "answer": "改善方法についての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "振り返り", "question_sub": "", "answer": "振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 65 | ストレスと健康
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 5, N'LEVEL 65 | ストレスと健康', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストレス要因", "question_sub": "", "answer": "ストレス要因についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "心身への影響", "question_sub": "", "answer": "心身への影響についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "対処方法", "question_sub": "", "answer": "対処方法についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストレス状況", "question_sub": "", "answer": "ストレス状況についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "セルフケア", "question_sub": "", "answer": "セルフケアについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "回復ストーリー", "question_sub": "", "answer": "回復ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 66 | チームワーク
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 6, N'LEVEL 66 | チームワーク', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "グループ活動", "question_sub": "", "answer": "グループ活動についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "役割", "question_sub": "", "answer": "役割についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "衝突", "question_sub": "", "answer": "衝突についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決", "question_sub": "", "answer": "問題解決についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学び", "question_sub": "", "answer": "学びについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 67 | 意思決定
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 7, N'LEVEL 67 | 意思決定', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "重要な決断", "question_sub": "", "answer": "重要な決断についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "影響要因", "question_sub": "", "answer": "影響要因についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "良い決断 vs 悪い決断", "question_sub": "", "answer": "良い決断 vs 悪い決断についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "予想外の結果", "question_sub": "", "answer": "予想外の結果についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学び", "question_sub": "", "answer": "学びについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 68 | デジタル生活
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 8, N'LEVEL 68 | デジタル生活', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "日常習慣", "question_sub": "", "answer": "日常習慣についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "利点", "question_sub": "", "answer": "利点についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題", "question_sub": "", "answer": "問題についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "オンライン vs オフライン", "question_sub": "", "answer": "オンライン vs オフラインについての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "バランス", "question_sub": "", "answer": "バランスについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "振り返り", "question_sub": "", "answer": "振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 69 | お金と責任
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 9, N'LEVEL 69 | お金と責任', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "消費習慣", "question_sub": "", "answer": "消費習慣についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "必要 vs 欲求", "question_sub": "", "answer": "必要 vs 欲求についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "予算管理", "question_sub": "", "answer": "予算管理についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失敗", "question_sub": "", "answer": "失敗についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "学び", "question_sub": "", "answer": "学びについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "ストーリー", "question_sub": "", "answer": "ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 70 | 中間レビュー
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 10, N'LEVEL 70 | 中間レビュー', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在の生活", "question_sub": "", "answer": "現在の生活についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "コミュニケーションの進歩", "question_sub": "", "answer": "コミュニケーションの進歩についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "強み", "question_sub": "", "answer": "強みについての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "課題", "question_sub": "", "answer": "課題についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "目標", "question_sub": "", "answer": "目標についての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成長ストーリー", "question_sub": "", "answer": "成長ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 71 | 将来計画
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 11, N'LEVEL 71 | 将来計画', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な将来計画の経験", "question_sub": "", "answer": "個人的な将来計画の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来計画に関する詳細と理由", "question_sub": "", "answer": "将来計画に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの将来計画の比較", "question_sub": "", "answer": "異なる視点からの将来計画の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来計画における課題や問題点", "question_sub": "", "answer": "将来計画における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来計画に対する個人の意見と振り返り", "question_sub": "", "answer": "将来計画に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "将来計画にまつわる拡張ストーリー", "question_sub": "", "answer": "将来計画にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 72 | 価値観
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 12, N'LEVEL 72 | 価値観', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な価値観の経験", "question_sub": "", "answer": "個人的な価値観の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "価値観に関する詳細と理由", "question_sub": "", "answer": "価値観に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの価値観の比較", "question_sub": "", "answer": "異なる視点からの価値観の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "価値観における課題や問題点", "question_sub": "", "answer": "価値観における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "価値観に対する個人の意見と振り返り", "question_sub": "", "answer": "価値観に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "価値観にまつわる拡張ストーリー", "question_sub": "", "answer": "価値観にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 73 | 文化
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 13, N'LEVEL 73 | 文化', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な文化の経験", "question_sub": "", "answer": "個人的な文化の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "文化に関する詳細と理由", "question_sub": "", "answer": "文化に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの文化の比較", "question_sub": "", "answer": "異なる視点からの文化の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "文化における課題や問題点", "question_sub": "", "answer": "文化における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "文化に対する個人の意見と振り返り", "question_sub": "", "answer": "文化に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "文化にまつわる拡張ストーリー", "question_sub": "", "answer": "文化にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 74 | 問題解決
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 14, N'LEVEL 74 | 問題解決', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な問題解決の経験", "question_sub": "", "answer": "個人的な問題解決の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決に関する詳細と理由", "question_sub": "", "answer": "問題解決に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの問題解決の比較", "question_sub": "", "answer": "異なる視点からの問題解決の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決における課題や問題点", "question_sub": "", "answer": "問題解決における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決に対する個人の意見と振り返り", "question_sub": "", "answer": "問題解決に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "問題解決にまつわる拡張ストーリー", "question_sub": "", "answer": "問題解決にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 75 | リーダーシップ
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 15, N'LEVEL 75 | リーダーシップ', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的なリーダーシップの経験", "question_sub": "", "answer": "個人的なリーダーシップの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リーダーシップに関する詳細と理由", "question_sub": "", "answer": "リーダーシップに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からのリーダーシップの比較", "question_sub": "", "answer": "異なる視点からのリーダーシップの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リーダーシップにおける課題や問題点", "question_sub": "", "answer": "リーダーシップにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リーダーシップに対する個人の意見と振り返り", "question_sub": "", "answer": "リーダーシップに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "リーダーシップにまつわる拡張ストーリー", "question_sub": "", "answer": "リーダーシップにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 76 | 意見と議論
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 16, N'LEVEL 76 | 意見と議論', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な意見と議論の経験", "question_sub": "", "answer": "個人的な意見と議論の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意見と議論に関する詳細と理由", "question_sub": "", "answer": "意見と議論に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの意見と議論の比較", "question_sub": "", "answer": "異なる視点からの意見と議論の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意見と議論における課題や問題点", "question_sub": "", "answer": "意見と議論における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意見と議論に対する個人の意見と振り返り", "question_sub": "", "answer": "意見と議論に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "意見と議論にまつわる拡張ストーリー", "question_sub": "", "answer": "意見と議論にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 77 | 失敗と成長
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 17, N'LEVEL 77 | 失敗と成長', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な失敗と成長の経験", "question_sub": "", "answer": "個人的な失敗と成長の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失敗と成長に関する詳細と理由", "question_sub": "", "answer": "失敗と成長に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの失敗と成長の比較", "question_sub": "", "answer": "異なる視点からの失敗と成長の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失敗と成長における課題や問題点", "question_sub": "", "answer": "失敗と成長における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失敗と成長に対する個人の意見と振り返り", "question_sub": "", "answer": "失敗と成長に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "失敗と成長にまつわる拡張ストーリー", "question_sub": "", "answer": "失敗と成長にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 78 | 成功
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 18, N'LEVEL 78 | 成功', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な成功の経験", "question_sub": "", "answer": "個人的な成功の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成功に関する詳細と理由", "question_sub": "", "answer": "成功に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの成功の比較", "question_sub": "", "answer": "異なる視点からの成功の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成功における課題や問題点", "question_sub": "", "answer": "成功における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成功に対する個人の意見と振り返り", "question_sub": "", "answer": "成功に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成功にまつわる拡張ストーリー", "question_sub": "", "answer": "成功にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 79 | 倫理
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 19, N'LEVEL 79 | 倫理', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な倫理の経験", "question_sub": "", "answer": "個人的な倫理の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "倫理に関する詳細と理由", "question_sub": "", "answer": "倫理に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの倫理の比較", "question_sub": "", "answer": "異なる視点からの倫理の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "倫理における課題や問題点", "question_sub": "", "answer": "倫理における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "倫理に対する個人の意見と振り返り", "question_sub": "", "answer": "倫理に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "倫理にまつわる拡張ストーリー", "question_sub": "", "answer": "倫理にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 80 | 高度な自己振り返り
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 20, N'LEVEL 80 | 高度な自己振り返り', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な高度な自己振り返りの経験", "question_sub": "", "answer": "個人的な高度な自己振り返りの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "高度な自己振り返りに関する詳細と理由", "question_sub": "", "answer": "高度な自己振り返りに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの高度な自己振り返りの比較", "question_sub": "", "answer": "異なる視点からの高度な自己振り返りの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "高度な自己振り返りにおける課題や問題点", "question_sub": "", "answer": "高度な自己振り返りにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "高度な自己振り返りに対する個人の意見と振り返り", "question_sub": "", "answer": "高度な自己振り返りに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "高度な自己振り返りにまつわる拡張ストーリー", "question_sub": "", "answer": "高度な自己振り返りにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 81 | 教育システム
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 21, N'LEVEL 81 | 教育システム', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な教育システムの経験", "question_sub": "", "answer": "個人的な教育システムの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "教育システムに関する詳細と理由", "question_sub": "", "answer": "教育システムに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの教育システムの比較", "question_sub": "", "answer": "異なる視点からの教育システムの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "教育システムにおける課題や問題点", "question_sub": "", "answer": "教育システムにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "教育システムに対する個人の意見と振り返り", "question_sub": "", "answer": "教育システムに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "教育システムにまつわる拡張ストーリー", "question_sub": "", "answer": "教育システムにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 82 | 職場環境
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 22, N'LEVEL 82 | 職場環境', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な職場環境の経験", "question_sub": "", "answer": "個人的な職場環境の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場環境に関する詳細と理由", "question_sub": "", "answer": "職場環境に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの職場環境の比較", "question_sub": "", "answer": "異なる視点からの職場環境の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場環境における課題や問題点", "question_sub": "", "answer": "職場環境における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場環境に対する個人の意見と振り返り", "question_sub": "", "answer": "職場環境に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "職場環境にまつわる拡張ストーリー", "question_sub": "", "answer": "職場環境にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 83 | テクノロジーと未来
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 23, N'LEVEL 83 | テクノロジーと未来', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的なテクノロジーと未来の経験", "question_sub": "", "answer": "個人的なテクノロジーと未来の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジーと未来に関する詳細と理由", "question_sub": "", "answer": "テクノロジーと未来に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からのテクノロジーと未来の比較", "question_sub": "", "answer": "異なる視点からのテクノロジーと未来の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジーと未来における課題や問題点", "question_sub": "", "answer": "テクノロジーと未来における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジーと未来に対する個人の意見と振り返り", "question_sub": "", "answer": "テクノロジーと未来に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "テクノロジーと未来にまつわる拡張ストーリー", "question_sub": "", "answer": "テクノロジーと未来にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 84 | 社会責任
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 24, N'LEVEL 84 | 社会責任', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な社会責任の経験", "question_sub": "", "answer": "個人的な社会責任の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会責任に関する詳細と理由", "question_sub": "", "answer": "社会責任に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの社会責任の比較", "question_sub": "", "answer": "異なる視点からの社会責任の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会責任における課題や問題点", "question_sub": "", "answer": "社会責任における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会責任に対する個人の意見と振り返り", "question_sub": "", "answer": "社会責任に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会責任にまつわる拡張ストーリー", "question_sub": "", "answer": "社会責任にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 85 | 幸福とバランス
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 25, N'LEVEL 85 | 幸福とバランス', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な幸福とバランスの経験", "question_sub": "", "answer": "個人的な幸福とバランスの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福とバランスに関する詳細と理由", "question_sub": "", "answer": "幸福とバランスに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの幸福とバランスの比較", "question_sub": "", "answer": "異なる視点からの幸福とバランスの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福とバランスにおける課題や問題点", "question_sub": "", "answer": "幸福とバランスにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福とバランスに対する個人の意見と振り返り", "question_sub": "", "answer": "幸福とバランスに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "幸福とバランスにまつわる拡張ストーリー", "question_sub": "", "answer": "幸福とバランスにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 86 | アイデンティティ
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 26, N'LEVEL 86 | アイデンティティ', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的なアイデンティティの経験", "question_sub": "", "answer": "個人的なアイデンティティの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アイデンティティに関する詳細と理由", "question_sub": "", "answer": "アイデンティティに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からのアイデンティティの比較", "question_sub": "", "answer": "異なる視点からのアイデンティティの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アイデンティティにおける課題や問題点", "question_sub": "", "answer": "アイデンティティにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アイデンティティに対する個人の意見と振り返り", "question_sub": "", "answer": "アイデンティティに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "アイデンティティにまつわる拡張ストーリー", "question_sub": "", "answer": "アイデンティティにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 87 | 変化と適応
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 27, N'LEVEL 87 | 変化と適応', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な変化と適応の経験", "question_sub": "", "answer": "個人的な変化と適応の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "変化と適応に関する詳細と理由", "question_sub": "", "answer": "変化と適応に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの変化と適応の比較", "question_sub": "", "answer": "異なる視点からの変化と適応の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "変化と適応における課題や問題点", "question_sub": "", "answer": "変化と適応における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "変化と適応に対する個人の意見と振り返り", "question_sub": "", "answer": "変化と適応に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "変化と適応にまつわる拡張ストーリー", "question_sub": "", "answer": "変化と適応にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 88 | 人生の意味
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 28, N'LEVEL 88 | 人生の意味', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な人生の意味の経験", "question_sub": "", "answer": "個人的な人生の意味の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の意味に関する詳細と理由", "question_sub": "", "answer": "人生の意味に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの人生の意味の比較", "question_sub": "", "answer": "異なる視点からの人生の意味の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の意味における課題や問題点", "question_sub": "", "answer": "人生の意味における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の意味に対する個人の意見と振り返り", "question_sub": "", "answer": "人生の意味に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の意味にまつわる拡張ストーリー", "question_sub": "", "answer": "人生の意味にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 89 | 優先順位
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 29, N'LEVEL 89 | 優先順位', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な優先順位の経験", "question_sub": "", "answer": "個人的な優先順位の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "優先順位に関する詳細と理由", "question_sub": "", "answer": "優先順位に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの優先順位の比較", "question_sub": "", "answer": "異なる視点からの優先順位の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "優先順位における課題や問題点", "question_sub": "", "answer": "優先順位における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "優先順位に対する個人の意見と振り返り", "question_sub": "", "answer": "優先順位に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "優先順位にまつわる拡張ストーリー", "question_sub": "", "answer": "優先順位にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 90 | 哲学
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 30, N'LEVEL 90 | 哲学', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な哲学の経験", "question_sub": "", "answer": "個人的な哲学の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哲学に関する詳細と理由", "question_sub": "", "answer": "哲学に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの哲学の比較", "question_sub": "", "answer": "異なる視点からの哲学の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哲学における課題や問題点", "question_sub": "", "answer": "哲学における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哲学に対する個人の意見と振り返り", "question_sub": "", "answer": "哲学に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "哲学にまつわる拡張ストーリー", "question_sub": "", "answer": "哲学にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 91 | 不確実性
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 31, N'LEVEL 91 | 不確実性', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な不確実性の経験", "question_sub": "", "answer": "個人的な不確実性の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "不確実性に関する詳細と理由", "question_sub": "", "answer": "不確実性に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの不確実性の比較", "question_sub": "", "answer": "異なる視点からの不確実性の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "不確実性における課題や問題点", "question_sub": "", "answer": "不確実性における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "不確実性に対する個人の意見と振り返り", "question_sub": "", "answer": "不確実性に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "不確実性にまつわる拡張ストーリー", "question_sub": "", "answer": "不確実性にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 92 | 影響力
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 32, N'LEVEL 92 | 影響力', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な影響力の経験", "question_sub": "", "answer": "個人的な影響力の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "影響力に関する詳細と理由", "question_sub": "", "answer": "影響力に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの影響力の比較", "question_sub": "", "answer": "異なる視点からの影響力の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "影響力における課題や問題点", "question_sub": "", "answer": "影響力における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "影響力に対する個人の意見と振り返り", "question_sub": "", "answer": "影響力に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "影響力にまつわる拡張ストーリー", "question_sub": "", "answer": "影響力にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 93 | 圧力下の意思決定
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 33, N'LEVEL 93 | 圧力下の意思決定', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な圧力下の意思決定の経験", "question_sub": "", "answer": "個人的な圧力下の意思決定の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "圧力下の意思決定に関する詳細と理由", "question_sub": "", "answer": "圧力下の意思決定に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの圧力下の意思決定の比較", "question_sub": "", "answer": "異なる視点からの圧力下の意思決定の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "圧力下の意思決定における課題や問題点", "question_sub": "", "answer": "圧力下の意思決定における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "圧力下の意思決定に対する個人の意見と振り返り", "question_sub": "", "answer": "圧力下の意思決定に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "圧力下の意思決定にまつわる拡張ストーリー", "question_sub": "", "answer": "圧力下の意思決定にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 94 | 成長と成熟
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 34, N'LEVEL 94 | 成長と成熟', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な成長と成熟の経験", "question_sub": "", "answer": "個人的な成長と成熟の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成長と成熟に関する詳細と理由", "question_sub": "", "answer": "成長と成熟に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの成長と成熟の比較", "question_sub": "", "answer": "異なる視点からの成長と成熟の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成長と成熟における課題や問題点", "question_sub": "", "answer": "成長と成熟における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成長と成熟に対する個人の意見と振り返り", "question_sub": "", "answer": "成長と成熟に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "成長と成熟にまつわる拡張ストーリー", "question_sub": "", "answer": "成長と成熟にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 95 | 長期ビジョン
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 35, N'LEVEL 95 | 長期ビジョン', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な長期ビジョンの経験", "question_sub": "", "answer": "個人的な長期ビジョンの経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "長期ビジョンに関する詳細と理由", "question_sub": "", "answer": "長期ビジョンに関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの長期ビジョンの比較", "question_sub": "", "answer": "異なる視点からの長期ビジョンの比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "長期ビジョンにおける課題や問題点", "question_sub": "", "answer": "長期ビジョンにおける課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "長期ビジョンに対する個人の意見と振り返り", "question_sub": "", "answer": "長期ビジョンに対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "長期ビジョンにまつわる拡張ストーリー", "question_sub": "", "answer": "長期ビジョンにまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 96 | 社会貢献
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 36, N'LEVEL 96 | 社会貢献', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な社会貢献の経験", "question_sub": "", "answer": "個人的な社会貢献の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会貢献に関する詳細と理由", "question_sub": "", "answer": "社会貢献に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの社会貢献の比較", "question_sub": "", "answer": "異なる視点からの社会貢献の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会貢献における課題や問題点", "question_sub": "", "answer": "社会貢献における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会貢献に対する個人の意見と振り返り", "question_sub": "", "answer": "社会貢献に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "社会貢献にまつわる拡張ストーリー", "question_sub": "", "answer": "社会貢献にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 97 | 人生変革
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 37, N'LEVEL 97 | 人生変革', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な人生変革の経験", "question_sub": "", "answer": "個人的な人生変革の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生変革に関する詳細と理由", "question_sub": "", "answer": "人生変革に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの人生変革の比較", "question_sub": "", "answer": "異なる視点からの人生変革の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生変革における課題や問題点", "question_sub": "", "answer": "人生変革における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生変革に対する個人の意見と振り返り", "question_sub": "", "answer": "人生変革に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生変革にまつわる拡張ストーリー", "question_sub": "", "answer": "人生変革にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 98 | 多文化共生
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 38, N'LEVEL 98 | 多文化共生', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な多文化共生の経験", "question_sub": "", "answer": "個人的な多文化共生の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "多文化共生に関する詳細と理由", "question_sub": "", "answer": "多文化共生に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの多文化共生の比較", "question_sub": "", "answer": "異なる視点からの多文化共生の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "多文化共生における課題や問題点", "question_sub": "", "answer": "多文化共生における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "多文化共生に対する個人の意見と振り返り", "question_sub": "", "answer": "多文化共生に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "多文化共生にまつわる拡張ストーリー", "question_sub": "", "answer": "多文化共生にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 99 | 自己実現
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 39, N'LEVEL 99 | 自己実現', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "個人的な自己実現の経験", "question_sub": "", "answer": "個人的な自己実現の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自己実現に関する詳細と理由", "question_sub": "", "answer": "自己実現に関する詳細と理由についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "異なる視点からの自己実現の比較", "question_sub": "", "answer": "異なる視点からの自己実現の比較についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自己実現における課題や問題点", "question_sub": "", "answer": "自己実現における課題や問題点についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自己実現に対する個人の意見と振り返り", "question_sub": "", "answer": "自己実現に対する個人の意見と振り返りについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "自己実現にまつわる拡張ストーリー", "question_sub": "", "answer": "自己実現にまつわる拡張ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

  -- Chapter: LEVEL 100 | 最終ステージ（マスターフルエンシー）
  INSERT INTO chapter (description, order_index, title, course_id) VALUES (N'', 40, N'LEVEL 100 | 最終ステージ（マスターフルエンシー）', @CourseId);
  SET @ChapterId = SCOPE_IDENTITY();

    -- Lesson: SUBLEVEL 1
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 1, N'SUBLEVEL 1', 'STANDARD', @ChapterId, 1);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "過去の経験", "question_sub": "", "answer": "過去の経験についての発話練習とディスカッション。", "answer_sub": ""}', 'warmup', @LessonId);

    -- Lesson: SUBLEVEL 2
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 2, N'SUBLEVEL 2', 'STANDARD', @ChapterId, 2);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "直面した課題", "question_sub": "", "answer": "直面した課題についての発話練習とディスカッション。", "answer_sub": ""}', 'ice_breaker', @LessonId);

    -- Lesson: SUBLEVEL 3
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 3, N'SUBLEVEL 3', 'STANDARD', @ChapterId, 3);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "人生の変化", "question_sub": "", "answer": "人生の変化についての発話練習とディスカッション。", "answer_sub": ""}', 'discussion', @LessonId);

    -- Lesson: SUBLEVEL 4
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 4, N'SUBLEVEL 4', 'STANDARD', @ChapterId, 4);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "現在の能力", "question_sub": "", "answer": "現在の能力についての発話練習とディスカッション。", "answer_sub": ""}', 'follow_up', @LessonId);

    -- Lesson: SUBLEVEL 5
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 5, N'SUBLEVEL 5', 'STANDARD', @ChapterId, 5);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "未来のビジョン", "question_sub": "", "answer": "未来のビジョンについての発話練習とディスカッション。", "answer_sub": ""}', 'practice', @LessonId);

    -- Lesson: SUBLEVEL 6
    INSERT INTO lesson (content_data, description, order_index, title, type, chapter_id, level_number) VALUES (N'', N'', 6, N'SUBLEVEL 6', 'STANDARD', @ChapterId, 6);
    SET @LessonId = SCOPE_IDENTITY();
      INSERT INTO ai_prompt_template (is_active, prompt_instruction, prompt_type, lesson_id) VALUES (1, N'{"question": "完全な人生ストーリー", "question_sub": "", "answer": "完全な人生ストーリーについての発話練習とディスカッション。", "answer_sub": ""}', 'wrapup', @LessonId);

COMMIT TRANSACTION;
