# DOCX Import Format

The LUCY DOCX import system uses Apache POI to parse `.docx` files into structured learning content (chapters and lessons).

## Format Rules

### Level Markers (→ Chapters)

A line starting with `LEVEL` creates a new **Chapter**:

```
LEVEL <number> | <Chapter Title>
```

Example:
```
LEVEL 1 | Greetings
LEVEL 2 | Daily Life
LEVEL 3 | Travel Conversations
```

### SubLevel Markers (→ Lessons)

A line starting with `SUBLEVEL` creates a new **Lesson** under the current chapter:

```
SUBLEVEL <level.sublevel> | <type> | <Lesson Title>
```

Where `<type>` is one of:
- `warmup` — Opening activity
- `ice_breaker` — Ice breaker question
- `discussion` — Main discussion topic
- `follow_up` — Follow-up question
- `practice` — Practice activity
- `wrapup` — Session closing

Example:
```
SUBLEVEL 1.1 | warmup | Warm Up
SUBLEVEL 1.2 | discussion | Introduce Yourself
SUBLEVEL 1.3 | follow_up | Ask About Hobbies
```

### Content Lines

Any line that is NOT a LEVEL or SUBLEVEL marker is treated as content for the current lesson. Content is appended to the lesson's `description` field.

## Complete Example

```
LEVEL 1 | Greetings
SUBLEVEL 1.1 | warmup | Warm Up
Hello! How are you today?
What's a greeting you use in your language?
SUBLEVEL 1.2 | ice_breaker | First Impressions
What was the first English word you learned?
SUBLEVEL 1.3 | discussion | Self Introduction
Tell the group about yourself in 3 sentences.

LEVEL 2 | Daily Life
SUBLEVEL 2.1 | warmup | Morning Check-in
How did you sleep last night?
SUBLEVEL 2.2 | discussion | Daily Routine
Describe your typical day from morning to evening.
SUBLEVEL 2.3 | wrapup | Favorite Part of the Day
What's your favorite time of day?
```

## Unicode Support

The importer supports English, Chinese (中文), and Japanese (日本語) content. All text fields use SQL Server `NVARCHAR`.

Example:
```
LEVEL 1 | 挨拶 (Greetings)
SUBLEVEL 1.1 | warmup | ウォームアップ
こんにちは！今日の気分はどうですか？
```

## How to Import

1. Go to **Import Files → New Import**
2. Select a **Course** to import into
3. Upload the `.docx` file
4. The system will parse and create chapters + lessons automatically

## Preview

Use **DOCX Preview** to inspect a file's structure before importing.
