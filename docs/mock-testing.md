# Mock Testing Profile

Use this profile to run LUCY locally with H2 in-memory data for all roles.

## Start

```powershell
.\scripts\start-mock.ps1
```

Default URL:

```text
http://localhost:8081/login
```

If port `8081` is busy, the script automatically tries the next port.

## Accounts

All mock accounts use password:

```text
123456
```

| Role | Email |
| --- | --- |
| ADMIN | admin@lucy.mock |
| LEARNER | learner@lucy.mock |
| MODERATOR | moderator@lucy.mock |
| PRO_MENTOR | mentor@lucy.mock |
| SUPER_CREATOR | creator@lucy.mock |

## Seeded Data

- Programs, courses, chapters, and lessons for course browsing and DOCX import target selection.
- Live and scheduled rooms for learner, moderator, mentor, and creator testing.
- Room participants, pending join request, pinned material, gifts, and gift transactions.
- AI prompt templates and saved quiz questions.
- Billing plans, credit transactions, podcasts, and premium content.

The profile uses `spring.jpa.hibernate.ddl-auto=create-drop`, so data resets whenever the mock app restarts.
