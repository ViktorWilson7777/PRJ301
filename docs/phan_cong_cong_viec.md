
## 👤 Trần Thanh Nguyên — Module: **Quản lý Khóa Học & Nội Dung**

> **Phạm vi:** Course, Chapter, Lesson (CRUD + Giao diện Learner)

### Nhiệm vụ cụ thể

| # | Công việc | File liên quan |
|---|---|---|
| 1 | **Thêm chức năng Tìm kiếm & Lọc Course** theo tên, ngôn ngữ, level trên trang `/courses` | [courses.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/courses.jsp), [CourseWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/CourseWebController.java) |
| 2 | **Tạo trang chi tiết Course cho Learner** hiển thị danh sách Chapter + Lesson bên trong. Learner click vào Course card → xem được nội dung bài học | Tạo mới: `course-detail.jsp`, sửa `CourseWebController.java` |
| 3 | **Thêm phân trang (Pagination)** cho danh sách Course (mỗi trang 9 card) | [CourseWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/CourseWebController.java), [CourseRepository.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/repository/CourseRepository.java) |
| 4 | **Sửa giao diện CRUD Lesson** cho Admin: thêm trường `type` hiển thị icon phù hợp (VIDEO, QUIZ, READING...) | [lessons.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/lessons.jsp), [lesson-form.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/lesson-form.jsp) |

### Hướng dẫn
- Sử dụng `PagingAndSortingRepository` của Spring Data JPA cho phân trang
- Giao diện Learner xem Course phải dùng card layout giống trang `rooms.jsp` (không dùng bảng)
- Filter dùng `@RequestParam` + query JPQL trong Repository

### Tiêu chí hoàn thành
- [ ] Learner có thể tìm kiếm Course theo tên
- [ ] Learner click vào Course → xem được chi tiết Chapter/Lesson
- [ ] Danh sách Course có phân trang
- [ ] Admin thấy icon type khi xem danh sách Lesson

---

## 👤 Văn Thái Trung — Module: **Hồ sơ Người Dùng & Course Run**

> **Phạm vi:** Profile, Course Run (Đợt học), Lịch sử hoạt động

### Nhiệm vụ cụ thể

| # | Công việc | File liên quan |
|---|---|---|
| 1 | **Hoàn thiện trang Profile** cho Learner: hiển thị lịch sử nạp credit, các phòng đã tham gia, quà đã nhận/tặng | [profile.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/profile.jsp), [AuthWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/AuthWebController.java) |
| 2 | **Thêm chức năng Đổi mật khẩu** trên trang Profile | Sửa `profile.jsp`, thêm endpoint POST trong `AuthWebController.java` |
| 3 | **Hoàn thiện Course Run** (Đợt học): Admin tạo đợt học → Learner đăng ký tham gia → Admin duyệt | [course-runs.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/course-runs.jsp), [CourseRunWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/CourseRunWebController.java), [CourseRun.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/entity/CourseRun.java) |
| 4 | **Thêm chức năng Upload Avatar** cho User trên trang Profile (lưu file vào thư mục `uploads/`) | Sửa `profile.jsp`, `AuthWebController.java`, thêm trường `avatarUrl` vào [AppUser.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/entity/AppUser.java) |

### Hướng dẫn
- Lịch sử hoạt động query từ các bảng: `credit_transaction`, `gift_transaction`, `room_participant`
- Upload avatar dùng `MultipartFile` + lưu vào `uploads/avatars/`
- Đổi mật khẩu cần kiểm tra mật khẩu cũ trước khi cho đổi

### Tiêu chí hoàn thành
- [ ] Trang Profile hiển thị đầy đủ lịch sử hoạt động
- [ ] User có thể đổi mật khẩu
- [ ] Hệ thống Course Run hoạt động: tạo → đăng ký → duyệt
- [ ] User upload được avatar và hiển thị trên giao diện

---

## 👤 Trần Công Tiến — Module: **Podcast & Premium Content**

> **Phạm vi:** Quản lý Podcast, Nội dung Premium, Thanh toán Credit

### Nhiệm vụ cụ thể

| # | Công việc | File liên quan |
|---|---|---|
| 1 | **Tạo trang nghe Podcast cho Learner** với giao diện giống Spotify: danh sách episode, nút Play/Pause, thanh progress | Tạo mới: `podcast-player.jsp`, sửa [PodcastWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/PodcastWebController.java) |
| 2 | **Hoàn thiện luồng mua Premium Content**: Learner xem preview → Bấm mua → Trừ credit → Mở khóa nội dung | [premium-content.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/premium-content.jsp), [PremiumContentWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/PremiumContentWebController.java) |
| 3 | **Thêm trang Billing Top-up cho Learner**: Learner chọn gói nạp → Xác nhận → Cộng credit vào tài khoản | [billing-topup.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/billing-topup.jsp), [BillingWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/BillingWebController.java) |
| 4 | **Thêm bảng thống kê doanh thu** cho Admin: tổng credit đã bán, top người mua, biểu đồ theo tháng | Tạo mới: `billing-stats.jsp`, sửa `BillingWebController.java` |

### Hướng dẫn
- Podcast player dùng thẻ `<audio>` của HTML5 + custom CSS cho giao diện đẹp
- Luồng mua Premium: kiểm tra `creditBalance >= price` → trừ credit → tạo record `CreditTransaction` → redirect về trang content đã unlock
- Biểu đồ doanh thu dùng [Chart.js](https://www.chartjs.org/) CDN

### Tiêu chí hoàn thành
- [x] Learner nghe được Podcast với giao diện đẹp
- [x] Luồng mua Premium Content hoạt động end-to-end
- [x] Learner nạp được credit
- [x] Admin xem được thống kê doanh thu

---

## 👤 Mai Hoàng Đăng — Module: **AI Support & Import Dữ liệu**

> **Phạm vi:** Tính năng AI hỗ trợ học tập, Import/Export dữ liệu

### Nhiệm vụ cụ thể

| # | Công việc | File liên quan |
|---|---|---|
| 1 | **Thêm nút AI Suggest vào trang Room Detail** cho Host: Bấm nút → AI tự động gợi ý chủ đề thảo luận dựa trên Lesson hiện tại | [room-detail.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/room-detail.jsp), [AiSupportApiController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/AiSupportApiController.java) |
| 2 | **Hoàn thiện trang AI Generated Questions**: Learner chọn Lesson → AI tự sinh câu hỏi trắc nghiệm → Learner làm bài và xem kết quả | [ai-generated-questions.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/ai-generated-questions.jsp), [AiGeneratedQuestionWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/AiGeneratedQuestionWebController.java) |
| 3 | **Cải thiện Import DOCX**: Thêm preview trước khi import, hiển thị số Chapter/Lesson sẽ được tạo | [docx-preview.jsp](file:///d:/PRJ/PRJ301Project/src/main/webapp/WEB-INF/views/docx-preview.jsp), [DocxPreviewController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/DocxPreviewController.java) |
| 4 | **Thêm chức năng Export danh sách User ra Excel** cho Admin | Tạo mới: endpoint `/users/export` trong [UserWebController.java](file:///d:/PRJ/PRJ301Project/src/main/java/com/lucy/lms/controller/UserWebController.java), dùng Apache POI (đã có sẵn trong `pom.xml`) |

### Hướng dẫn
- AI gọi qua OpenRouter API đã có sẵn trong `AiSupportApiController.java`, chỉ cần thêm endpoint mới
- Export Excel dùng thư viện `Apache POI` (dependency `poi-ooxml` đã có trong `pom.xml`)
- Câu hỏi AI cần parse JSON response từ API → lưu vào bảng `ai_generated_question`

### Tiêu chí hoàn thành
- [ ] Host bấm AI Suggest → Hiện gợi ý chủ đề thảo luận trên màn hình
- [ ] Learner làm được bài quiz do AI tạo
- [ ] Import DOCX có bước Preview trước khi xác nhận
- [ ] Admin export được file Excel danh sách User

---

