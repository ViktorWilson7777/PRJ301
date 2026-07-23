# LUCY — Language Unity & Collaborative Youth

> **PRJ301 University Project** — A demo-ready platform prototype for anonymous language learning social rooms, mentor teaching, podcast creation, AI moderator support, and mock wallet/gift/payment systems.

![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.x-green)
![SQL Server](https://img.shields.io/badge/SQL_Server-2019+-blue)
![License](https://img.shields.io/badge/License-Academic-lightgrey)

---

## Features

| Module | Description |
|--------|------------|
| **LMS Content** | Programs → Courses → Chapters → Lessons with DOCX import |
| **User Management** | Roles: Admin, Learner, Moderator, Pro Mentor, Super Creator |
| **Live Rooms** | Mock language practice rooms with participants, mic/hand state |
| **AI Moderator** | Generate discussion questions via Gemini API (with mock fallback) |
| **Billing & Wallet** | Mock subscription plans (Free/Pro/Super) and credit top-up |
| **Gifts** | Virtual gifts (Star ⭐, Coffee ☕, Diamond 💎) sent in rooms |
| **Podcasts** | Super Creator podcast episodes from ended rooms |
| **Premium Content** | Paid learning content by Super Creators |
| **DOCX Import** | Apache POI-based import of structured learning content |
| **Swagger API** | Full REST API documentation at `/swagger-ui/index.html` |

---

## Tech Stack

- **Java 17** + **Spring Boot 3.x**
- **Spring Data JPA** (Hibernate, auto DDL)
- **SQL Server** (NVARCHAR for Unicode/CJK support)
- **JSP / JSTL** views with Bootstrap 5
- **Apache POI** for DOCX parsing
- **springdoc-openapi** for Swagger UI
- **Lombok** for boilerplate reduction

---

## Quick Start

### Prerequisites

1. **Java 17+** installed
2. **SQL Server** running locally (or Docker)
3. Maven is optional because the repository includes Maven Wrapper

### Setup

```powershell
# 1. Run sql/create-database.sql in SQL Server Management Studio,
#    or run it with sqlcmd using your SQL Server credentials.

# 2. Configure application.properties
#    Update the connection string, username, password if needed
#    File: src/main/resources/application.properties

# 3. Run the application
.\mvnw.cmd spring-boot:run
```

### First Boot

1. JPA will **auto-create all tables** on first run.
2. The application automatically creates and synchronizes the default login accounts.
3. To reset all data and load the sample dataset, run `sql/seed-data.sql` after startup.
   Warning: this script deletes every existing row before inserting sample data.
4. Open **http://localhost:8081/login**
5. Open **http://localhost:8081/swagger-ui/index.html** for API docs

### Default Login Accounts

| Role | Email | Password |
|------|-------|----------|
| Admin | `admin@lucy.demo` | `123456` |
| Learner | `learner@lucy.demo` | `123456` |
| Pro Mentor | `miko@lucy.demo` | `123456` |
| Content Creator | `max@lucy.demo` | `123456` |

Default accounts are enabled by `LUCY_DEFAULT_ACCOUNTS_ENABLED` and use
`LUCY_DEFAULT_ACCOUNT_PASSWORD` when a new database is initialized. Existing
passwords are preserved, while old plaintext passwords are migrated to BCrypt.

---

## Project Structure

```
src/main/java/com/lucy/lms/
├── config/         # OpenAPI config
├── controller/     # Web controllers (JSP) + REST API controllers
├── dto/            # Data Transfer Objects
├── entity/         # JPA entities (15 entities)
├── repository/     # Spring Data JPA repositories
├── service/        # Business logic (DocxImport, LearningContent)
│
src/main/webapp/WEB-INF/
├── tags/layout.tag # Shared Bootstrap 5 admin layout
├── views/          # 25+ JSP views
│
sql/
├── create-database.sql
├── seed-data.sql
└── reset-import-data.sql
```

---

## API Endpoints

### LMS Content
| Method | Path | Description |
|--------|------|------------|
| GET | `/api/programs` | List all programs |
| GET | `/api/courses` | List courses, `?programId=` filter |
| GET | `/api/chapters` | List chapters, `?courseId=` filter |
| GET | `/api/lessons` | List lessons, `?chapterId=` filter |
| GET | `/api/learning-content?courseId=` | Nested content tree |
| GET | `/api/courses/{id}/levels` | Chapters for a course |
| GET | `/api/levels/{id}/lessons` | Lessons for a chapter |

### AI Support
| Method | Path | Description |
|--------|------|------------|
| POST | `/api/ai/suggest-questions?lessonId=&promptType=` | Generate questions |
| GET | `/api/ai/generated-questions?lessonId=` | List generated questions |

### Room
| Method | Path | Description |
|--------|------|------------|
| GET | `/api/rooms?status=` | List rooms |
| GET | `/api/rooms/{id}` | Room detail with participants |

### User
| Method | Path | Description |
|--------|------|------------|
| GET | `/api/users?role=` | List users |
| GET | `/api/users/{id}` | User detail |

### Billing
| Method | Path | Description |
|--------|------|------------|
| GET | `/api/billing/plans` | List plans |
| GET | `/api/billing/transactions?userId=` | Transactions |

---

## DOCX Import Format

The DOCX importer expects a specific format with `LEVEL` and `SUBLEVEL` markers:

```
LEVEL 1 | Greetings
SUBLEVEL 1.1 | warmup | Warm Up
Hello! How are you?
SUBLEVEL 1.2 | discussion | Small Talk
What did you do last weekend?

LEVEL 2 | Daily Life
SUBLEVEL 2.1 | ice_breaker | Morning Routine
Tell me about your morning routine.
```

See `docs/docx-import-format.md` for detailed documentation.

---

## 📅 Implementation Roadmap

We have structured a **10-Week Multi-Stack Implementation Roadmap** detailing the evolution of this project from a mock prototype into a fully integrated platform (Java, .NET, Node.js, Mobile App).

See [docs/roadmap.md](file:///c:/Users/ADMIN/Desktop/PRJ301-1/docs/roadmap.md) for the detailed week-by-week timeline and stack-specific task breakdown.

---

## Mock / Sandbox Notice

This is a **university demo prototype**. The following features are **simulated**:

- ⚠️ **No real payments** — billing is mock/sandbox
- ⚠️ **No real audio** — rooms are form-based, no Agora/WebRTC
- ⚠️ **No real authentication** — no login system
- ⚠️ **AI defaults to mock** — uses Gemini API if key is set, otherwise returns canned questions

---

## License

Academic project for **PRJ301** at FPT University. Not for commercial use.
