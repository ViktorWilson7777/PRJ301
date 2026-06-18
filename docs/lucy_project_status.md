# 📊 Tổng hợp Công việc Đã làm & Chưa làm — Dự án LUCY LMS (PRJ301)

> Phạm vi: Java/Spring Boot backend + JSP frontend (`c:\Users\ADMIN\Documents\GitHub\PRJ301`)
> Cập nhật: 2026-06-15

---

## ✅ CÔNG VIỆC ĐÃ HOÀN THÀNH

### 🏗️ 1. Nền tảng Hệ thống (Foundation)

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| Project setup Spring Boot 3.5.x | ✅ Xong | Maven WAR, Tomcat embedded, SQL Server |
| Cấu trúc Entity / Repository / Controller | ✅ Xong | 19 entity, 19 repository, 28 controller |
| Xác thực người dùng (Login/Register) | ✅ Xong | `AuthWebController`, session-based auth |
| Phân quyền Role-Based Access Control | ✅ Xong | LEARNER / CREATOR / ADMIN, `AuthInterceptor` |
| Dashboard phân vai trò | ✅ Xong | Learner, Pro Mentor, Super Creator dashboards |
| Swagger / OpenAPI docs | ✅ Xong | `/swagger-ui.html` via SpringDoc |

---

### 📚 2. Quản lý Nội dung học tập (LMS Content)

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| CRUD Programs | ✅ Xong | `ProgramWebController` + JSP |
| CRUD Courses | ✅ Xong | `CourseWebController` + JSP |
| CRUD Course Runs | ✅ Xong | `CourseRunWebController` + JSP |
| CRUD Chapters | ✅ Xong | `ChapterWebController` + JSP |
| CRUD Lessons | ✅ Xong | `LessonWebController` + JSP |
| Import DOCX → Lessons (Apache POI) | ✅ Xong | `DocxImportController`, `ImportFileWebController` |
| Preview DOCX nội dung | ✅ Xong | `DocxPreviewController` |
| API Level/Chapter/Lesson cho Mobile | ✅ Xong | `LearningContentApiController` |

---

### 🎙️ 3. Hệ thống Phòng học Live (Room System)

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| CRUD Rooms (Create/Edit/Delete) | ✅ Xong | `RoomWebController` + `room-form.jsp` |
| Danh sách phòng học | ✅ Xong | `rooms.jsp`, filter by status |
| Trang chi tiết phòng (Room Detail) | ✅ Xong | Phân tách thành `room-detail-host.jsp` & `room-detail-learner.jsp` |
| Quản lý thành viên (Add/Remove/Kick) | ✅ Xong | Host có thể kick người dùng, tự động đẩy ra khỏi phòng |
| Toggle Microphone (Bật/Tắt mic) | ✅ Xong | Nút điều khiển âm thanh trên cả Host và Learner |
| Toggle Raise Hand (Giơ tay) | ✅ Xong | `/toggle-hand/{id}` endpoint |
| Stage Transition (Next Topic) | ✅ Xong | Chuyển lesson sau 10 phút |
| Ghim tài liệu học tập (Pin Material) | ✅ Xong | `PinnedMaterial` entity + UI |
| Ghi âm phòng (Recording) | ✅ Xong | Toggle recording → tạo PodcastEpisode |
| End Room & Auto-Delete | ✅ Xong | Host kết thúc live sẽ xóa phòng khỏi DB, tự động out tất cả |
| **🆕 Join Request Workflow** | ✅ Xong | Khắc phục hoàn toàn lỗi Whitelabel Page khi Host Accept/Deny |
| **🆕 Polling thông báo & Trạng thái** | ✅ Xong | Polling trạng thái vai trò và phê duyệt để cập nhật giao diện Learner |
| **🆕 SPEAKER Dynamic Audio Reconnect** | ✅ Xong | Tự động nâng cấp kết nối Agora thành publisher khi được promote lên SPEAKER |
| **🆕 Real-time Mic Status on Avatars** | ✅ Xong | Dùng WebSocket `MIC_TOGGLE` đồng bộ icon và màu sắc mic trên stage |
| Agora Audio SDK integration | ✅ Xong | Tích hợp Agora thật chống hú rít (AEC, ANS, AGC) |

---

### 💰 4. Ví ảo & Hệ thống Quà tặng (Wallet & Gifts)

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| Credit Balance (Số dư ví ảo) | ✅ Xong | Trường `creditBalance` trên `AppUser` |
| Nạp tiền (Top-up credits) | ✅ Xong | `BillingWebController`, form nạp tiền |
| **🆕 Trang Billing Top-up** | ✅ Xong | Giao diện nạp thẻ/gói credit (Demo, Starter, Pro, Super) đẹp mắt |
| **🆕 Luồng mua Premium Content** | ✅ Xong | Trừ credits, tạo transaction `PREMIUM_PURCHASE` & mở khóa truy cập vĩnh viễn |
| **🆕 Thống kê Doanh thu & Chart.js** | ✅ Xong | `/billing/stats` hiển thị tổng credits đã bán, Top Buyers & Biểu đồ doanh thu theo tháng |
| Quản lý Billing Plans | ✅ Xong | CRUD plans, `billing-plans.jsp` |
| Lịch sử giao dịch | ✅ Xong | `CreditTransaction`, `billing-transactions.jsp` |
| CRUD Gift (Quà tặng) | ✅ Xong | `GiftWebController`, gift-form.jsp |
| Tặng quà trong phòng (Send Gift) | ✅ Xong | `GiftTransaction`, trừ/cộng credit |
| Lịch sử quà trong phòng (Gift History) | ✅ Xong | Hiển thị trong room-detail |

---

### 🤖 5. AI Support (Tạo câu hỏi thảo luận)

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| Prompt Templates CRUD | ✅ Xong | `AiPromptTemplateWebController` |
| Tạo câu hỏi AI (OpenRouter/Gemma) | ✅ Xong | `AiSupportApiController`, real API key |
| Lưu lịch sử câu hỏi AI | ✅ Xong | `AiGeneratedQuestion` entity |
| Hiển thị Generated Questions | ✅ Xong | `ai-generated-questions.jsp` |

---

### 🎙️ 6. Podcast System

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| CRUD Podcast Episodes | ✅ Xong | `PodcastWebController` |
| **🆕 Spotify-like Player** | ✅ Xong | Giao diện nghe nhạc chuẩn Spotify cho Learner, đĩa than xoay, volume, progress bar & playlist |
| Auto-create Podcast khi stop recording | ✅ Xong | Tự tạo episode từ phòng |
| Danh sách Podcast | ✅ Xong | `podcasts.jsp` |

---

### 👤 7. Quản lý Người dùng

| Hạng mục | Trạng thái | Chi tiết |
|---|---|---|
| CRUD Users | ✅ Xong | `UserWebController` |
| Profile cá nhân | ✅ Xong | `profile.jsp`, edit info |
| Nâng cấp tài khoản (Credit-based upgrade) | ✅ Xong | Trừ credit → đổi role |
| Anonymous Mode | ✅ Xong | Dùng avatarPersona thay displayName |
| Premium Content | ✅ Xong | `PremiumContentWebController` |

---

## ❌ CÔNG VIỆC CHƯA HOÀN THÀNH / CẦN HOÀN THIỆN

### 🔴 Ưu tiên Cao (Thiếu cho Demo)

| Hạng mục | Mức độ | Vấn đề / Việc cần làm |
|---|---|---|
| **Agora Audio thật (Real-time)** | 🔴 Cao | Cần Node.js Token Server thật để sinh Agora token động thay vì mock token |
| **Session-based Auth cho API** | 🔴 Cao | API endpoints không kiểm tra session/login; ai cũng gọi được |

---

### 🟠 Ưu tiên Trung bình (Hoàn thiện tính năng)

| Hạng mục | Mức độ | Vấn đề / Việc cần làm |
|---|---|---|
| **Stage Timer tự động (10 phút)** | 🟠 Trung | Logic timer chưa có scheduler thật; chỉ hiển thị thời gian static |
| **Trang danh sách phòng cho Learner** | 🟠 Trung | Learner cần trang `/rooms` riêng để browse và join phòng |
| **Upload ảnh / Avatar** | 🟠 Trung | Chỉ có text profile, chưa có upload file ảnh đại diện |
| **Phân quyền CRUD theo role** | 🟠 Trung | AuthInterceptor chặn URL nhưng các form CRUD chưa ẩn hoàn toàn với Learner |

---

### 🟡 Ưu tiên Thấp (Nice-to-have)

| Hạng mục | Mức độ | Vấn đề / Việc cần làm |
|---|---|---|
| **Hiệu ứng quà tặng animation** | 🟡 Thấp | Chỉ ghi lịch sử; không có animation floating gift |
| **Tìm kiếm / Filter phòng** | 🟡 Thấp | Trang rooms chưa có search/filter theo language, level |
| **Stress Test (500-1000 users)** | 🟡 Thấp | Chưa thực hiện kiểm thử hiệu năng |
| **Responsive Mobile Web** | 🟡 Thấp | Dashboard chưa tối ưu layout mobile |
| **Email Notification** | 🟡 Thấp | Không có gửi mail đăng ký, mời vào phòng |
| **Seed Data đầy đủ 100 lessons** | 🟡 Thấp | DB chỉ có vài mẫu; chưa import đủ 100 levels từ DOCX |

---

## 📋 TIẾN ĐỘ NHIỆM VỤ THEO PHÂN CÔNG (phan_cong_cong_viec.md)

### 👤 1. Trần Thanh Nguyên — Module: Quản lý Khóa Học & Nội Dung
- [ ] Thêm chức năng Tìm kiếm & Lọc Course theo tên, ngôn ngữ, level trên trang `/courses`
- [ ] Tạo trang chi tiết Course cho Learner hiển thị danh sách Chapter + Lesson bên trong
- [ ] Thêm phân trang (Pagination) cho danh sách Course (mỗi trang 9 card)
- [ ] Sửa giao diện CRUD Lesson cho Admin: thêm trường `type` hiển thị icon phù hợp
- *Tiến độ hoàn thành*: **0%** (Chưa bắt đầu)

### 👤 2. Văn Thái Trung — Module: Hồ sơ Người Dùng & Course Run
- [ ] Hoàn thiện trang Profile cho Learner: hiển thị đầy đủ lịch sử hoạt động
- [ ] Thêm chức năng Đổi mật khẩu trên trang Profile
- [ ] Hoàn thiện Course Run (Đợt học): Admin tạo đợt học → Learner đăng ký tham gia → Admin duyệt
- [ ] Thêm chức năng Upload Avatar cho User trên trang Profile
- *Tiến độ hoàn thành*: **0%** (Chưa bắt đầu)

### 👤 3. Trần Công Tiến — Module: Podcast & Premium Content
- [x] Tạo trang nghe Podcast cho Learner với giao diện giống Spotify (`podcast-player.jsp`)
- [x] Hoàn thiện luồng mua Premium Content: Learner xem preview → Bấm mua → Trừ credit → Mở khóa nội dung
- [x] Thêm trang Billing Top-up cho Learner: chọn gói nạp → Xác nhận → Cộng credit
- [x] Thêm bảng thống kê doanh thu cho Admin (tích hợp biểu đồ Chart.js)
- *Tiến độ hoàn thành*: **100%** (Đã hoàn thành toàn bộ)

### 👤 4. Mai Hoàng Đăng — Module: AI Support & Import Dữ liệu
- [ ] Thêm nút AI Suggest vào trang Room Detail cho Host (tự động gợi ý chủ đề thảo luận dựa trên Lesson hiện tại)
- [ ] Hoàn thiện trang AI Generated Questions: Learner làm bài quiz trắc nghiệm do AI tự sinh và xem kết quả
- [ ] Cải thiện Import DOCX: Thêm preview trước khi import, hiển thị số Chapter/Lesson sẽ được tạo
- [ ] Thêm chức năng Export danh sách User ra Excel cho Admin
- *Tiến độ hoàn thành*: **0%** (Chưa bắt đầu)

---

## 📈 Đánh giá Tiến độ so với Lộ trình 10 Tuần

```
Tuần 1-2: Nền tảng & Data          [====================] 100% Xong
Tuần 3-5: MVP Real-time Audio       [=================== ]  95% Xong (Agora audio fully integrated, mic toggle & avatar sync)
Tuần 6-7: LMS & Pro Tools           [==================  ]  90% Xong
Tuần 8-9: Monetization & Podcast    [====================] 100% Xong
Tuần 10:  Tối ưu & Launch           [==========          ]  50% Xong
```

> **Điểm mạnh**: Tách biệt hoàn toàn giao diện Host và Learner, loại bỏ lỗi 500/404 Whitelabel Page, tự động giải phóng tài nguyên database khi đóng phòng, cơ chế thăng cấp SPEAKER tự động kết nối mic của Agora cực kỳ mượt mà, đồng bộ icon mic thời gian thực trên Avatar của toàn bộ thành viên qua WebSocket.
>
> **Điểm yếu trọng yếu**: Chưa có server sinh Agora token động trên production.

---

## 🚀 Đề xuất 3 Việc tiếp theo quan trọng nhất

1. **Deploy Agora Token Server thật** — Tạo server Node.js sinh token động cho môi trường production.
2. **Session-based Auth cho API** — Bổ sung cơ chế bảo mật (AuthInterceptor hoặc Filter) cho toàn bộ API endpoints.
3. **Stage Timer tự động (10 phút)** — Xây dựng Scheduler thật để tự động hóa tiến trình chuyển stage trong phòng học.
