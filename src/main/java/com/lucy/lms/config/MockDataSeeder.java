package com.lucy.lms.config;

import com.lucy.lms.entity.AiGeneratedQuestion;
import com.lucy.lms.entity.AiPromptTemplate;
import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.BillingPlan;
import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.CreditTransaction;
import com.lucy.lms.entity.Gift;
import com.lucy.lms.entity.GiftTransaction;
import com.lucy.lms.entity.JoinRequest;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.entity.PinnedMaterial;
import com.lucy.lms.entity.PodcastEpisode;
import com.lucy.lms.entity.PremiumContent;
import com.lucy.lms.entity.Program;
import com.lucy.lms.entity.Room;
import com.lucy.lms.entity.RoomParticipant;
import com.lucy.lms.repository.AiGeneratedQuestionRepository;
import com.lucy.lms.repository.AiPromptTemplateRepository;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.BillingPlanRepository;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.CreditTransactionRepository;
import com.lucy.lms.repository.GiftRepository;
import com.lucy.lms.repository.GiftTransactionRepository;
import com.lucy.lms.repository.JoinRequestRepository;
import com.lucy.lms.repository.LessonRepository;
import com.lucy.lms.repository.PinnedMaterialRepository;
import com.lucy.lms.repository.PodcastEpisodeRepository;
import com.lucy.lms.repository.PremiumContentRepository;
import com.lucy.lms.repository.ProgramRepository;
import com.lucy.lms.repository.RoomParticipantRepository;
import com.lucy.lms.repository.RoomRepository;
import jakarta.transaction.Transactional;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@Profile("mock")
@ConditionalOnProperty(name = "lucy.mock-data.enabled", havingValue = "true")
public class MockDataSeeder implements CommandLineRunner {

    private static final String DEMO_PASSWORD = "123456";

    private final AppUserRepository userRepository;
    private final ProgramRepository programRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;
    private final RoomRepository roomRepository;
    private final RoomParticipantRepository participantRepository;
    private final JoinRequestRepository joinRequestRepository;
    private final PinnedMaterialRepository pinnedMaterialRepository;
    private final BillingPlanRepository billingPlanRepository;
    private final GiftRepository giftRepository;
    private final GiftTransactionRepository giftTransactionRepository;
    private final CreditTransactionRepository creditTransactionRepository;
    private final AiPromptTemplateRepository promptTemplateRepository;
    private final AiGeneratedQuestionRepository aiQuestionRepository;
    private final PodcastEpisodeRepository podcastRepository;
    private final PremiumContentRepository premiumContentRepository;

    public MockDataSeeder(AppUserRepository userRepository,
                          ProgramRepository programRepository,
                          CourseRepository courseRepository,
                          ChapterRepository chapterRepository,
                          LessonRepository lessonRepository,
                          RoomRepository roomRepository,
                          RoomParticipantRepository participantRepository,
                          JoinRequestRepository joinRequestRepository,
                          PinnedMaterialRepository pinnedMaterialRepository,
                          BillingPlanRepository billingPlanRepository,
                          GiftRepository giftRepository,
                          GiftTransactionRepository giftTransactionRepository,
                          CreditTransactionRepository creditTransactionRepository,
                          AiPromptTemplateRepository promptTemplateRepository,
                          AiGeneratedQuestionRepository aiQuestionRepository,
                          PodcastEpisodeRepository podcastRepository,
                          PremiumContentRepository premiumContentRepository) {
        this.userRepository = userRepository;
        this.programRepository = programRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
        this.roomRepository = roomRepository;
        this.participantRepository = participantRepository;
        this.joinRequestRepository = joinRequestRepository;
        this.pinnedMaterialRepository = pinnedMaterialRepository;
        this.billingPlanRepository = billingPlanRepository;
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
        this.creditTransactionRepository = creditTransactionRepository;
        this.promptTemplateRepository = promptTemplateRepository;
        this.aiQuestionRepository = aiQuestionRepository;
        this.podcastRepository = podcastRepository;
        this.premiumContentRepository = premiumContentRepository;
    }

    @Override
    @Transactional
    public void run(String... args) {
        if (userRepository.findByEmail("admin@lucy.mock").isPresent()) {
            printAccounts();
            return;
        }

        AppUser admin = user("Admin Mock", "admin@lucy.mock", "AdminMock", "ADMIN", 2000.0, 100);
        AppUser learner = user("Learner Mock", "learner@lucy.mock", "LearnerMock", "LEARNER", 250.0, 12);
        AppUser moderator = user("Moderator Mock", "moderator@lucy.mock", "ModMock", "MODERATOR", 450.0, 55);
        AppUser mentor = user("Pro Mentor Mock", "mentor@lucy.mock", "MentorMock", "PRO_MENTOR", 900.0, 80);
        AppUser creator = user("Super Creator Mock", "creator@lucy.mock", "CreatorMock", "SUPER_CREATOR", 1500.0, 120);

        billingPlan("Free", 0.0, 5, 2, 10, false);
        billingPlan("Pro Mentor", 9.99, 50, 20, 30, false);
        billingPlan("Super Creator", 19.99, 200, 100, 100, true);

        Gift star = gift("Star", "STAR", 10);
        Gift coffee = gift("Coffee", "COFFEE", 25);
        gift("Diamond", "DIAMOND", 100);

        Program english = program("EN", "English", "Mock English language program");
        Program japanese = program("JA", "Japanese", "Mock Japanese language program");

        Course beginner = course(english, "EN-MOCK-1", "English Mock Stage 1", "Beginner conversation test course", "Beginner", "English", 1);
        Course advanced = course(english, "EN-MOCK-2", "English Mock Stage 2", "Discussion and debate test course", "Intermediate", "English", 2);
        course(japanese, "JA-MOCK-1", "Japanese Mock Stage 1", "Basic Japanese test course", "Beginner", "Japanese", 1);

        Chapter greetings = chapter(beginner, "Level 1 - Greetings", "Greeting and self-introduction practice", 1);
        Chapter routine = chapter(beginner, "Level 2 - Daily Routine", "Daily activities and habit practice", 2);
        Chapter debate = chapter(advanced, "Level 10 - Opinions", "Opinion and debate practice", 1);

        Lesson hello = lesson(greetings, "discussion", "Hello and Goodbye", "Practice hello, goodbye, and short introductions.", 1, 1,
                "{\"rawText\":\"Hello. Nice to meet you. See you later.\"}");
        Lesson intro = lesson(greetings, "practice", "Introduce Yourself", "Say your name, hometown, and one hobby.", 2, 1,
                "{\"rawText\":\"My name is Alex. I am from Hanoi. I like music.\"}");
        Lesson routineLesson = lesson(routine, "discussion", "Morning Routine", "Talk about wake-up time, breakfast, and study habits.", 1, 2,
                "{\"rawText\":\"I wake up at seven. I have breakfast. I go to school.\"}");
        Lesson debateLesson = lesson(debate, "discussion", "Remote Work Debate", "Discuss the pros and cons of remote work.", 1, 10,
                "{\"rawText\":\"Remote work saves time but can reduce teamwork.\"}");

        prompt(hello, "discussion", "Suggest friendly beginner discussion questions.");
        prompt(routineLesson, "warmup", "Ask easy warm-up questions about daily habits.");
        quiz(hello, "What is a good greeting?", "Hello!", "Banana", "Blue", "Yesterday", "A",
                "Hello is a common greeting.");
        quiz(routineLesson, "Which sentence describes a morning routine?", "I wake up at seven.", "I bought a ticket.", "It is expensive.", "Turn left.", "A",
                "Waking up is part of a morning routine.");

        Room liveRoom = room("Mock Live Room - Beginner English", "EN", 1, "PUBLIC", "LIVE", mentor, beginner, greetings, hello, 20,
                "Host room for AI Suggest, gifts, participants, and live role testing.");
        Room creatorRoom = room("Mock Premium Creator Class", "EN", 10, "PREMIUM", "SCHEDULED", creator, advanced, debate, debateLesson, 12,
                "Scheduled premium class for creator/admin testing.");
        Room learnerRoom = room("Mock Learner Practice Room", "EN", 2, "PUBLIC", "LIVE", creator, beginner, routine, routineLesson, 15,
                "Second live room with learner and moderator participants.");

        participant(liveRoom, learner, "LISTENER", false, false);
        participant(liveRoom, moderator, "MODERATOR", true, false);
        participant(liveRoom, creator, "SPEAKER", true, false);
        participant(learnerRoom, learner, "SPEAKER", true, true);
        participant(learnerRoom, moderator, "MODERATOR", true, false);

        joinRequest(creatorRoom, learner, "SPEAKER");
        pinned(liveRoom, hello, "Opening Prompt", "Introduce yourself with one sentence, then ask a friend one question.");

        giftTransaction(star, learner, mentor, liveRoom, 10);
        giftTransaction(coffee, moderator, creator, learnerRoom, 25);

        credit(learner, 100.0, "TOP_UP", "Mock top-up for learner testing");
        credit(learner, -10.0, "GIFT_SENT", "Mock gift sent in live room");
        credit(mentor, 10.0, "GIFT_RECEIVED", "Mock gift received from learner");

        premiumContent("Mock Premium Speaking Pack", "Creator-only premium lesson pack for purchase flow testing.", creator, beginner, greetings, 120);
        podcast("Mock Public Podcast", "Published public podcast episode for learner playback testing.", mentor, liveRoom, false, 0, learner);
        podcast("Mock Premium Podcast", "Premium podcast episode for unlock testing.", creator, learnerRoom, true, 80, learner);

        System.out.println("LUCY mock data seeded.");
        printAccounts();
    }

    private AppUser user(String fullName, String email, String displayName, String role, Double credits, Integer reputation) {
        AppUser user = new AppUser();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setDisplayName(displayName);
        user.setAvatarPersona(displayName);
        user.setRole(role);
        user.setPassword(DEMO_PASSWORD);
        user.setAnonymousMode(false);
        user.setCreditBalance(credits);
        user.setReputationScore(reputation);
        user.setActive(true);
        user.setCreatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }

    private BillingPlan billingPlan(String name, Double price, Integer aiLimit, Integer importLimit, Integer maxParticipants, Boolean recording) {
        BillingPlan plan = new BillingPlan();
        plan.setName(name);
        plan.setPrice(price);
        plan.setMonthlyAiLimit(aiLimit);
        plan.setMonthlyImportLimit(importLimit);
        plan.setMaxRoomParticipants(maxParticipants);
        plan.setAllowPodcastRecording(recording);
        plan.setActive(true);
        return billingPlanRepository.save(plan);
    }

    private Gift gift(String name, String icon, Integer cost) {
        Gift gift = new Gift();
        gift.setName(name);
        gift.setIcon(icon);
        gift.setCreditCost(cost);
        gift.setActive(true);
        return giftRepository.save(gift);
    }

    private Program program(String code, String title, String description) {
        Program program = new Program();
        program.setCode(code);
        program.setTitle(title);
        program.setDescription(description);
        program.setIsPublished(true);
        return programRepository.save(program);
    }

    private Course course(Program program, String code, String title, String description, String level, String language, Integer orderIndex) {
        Course course = new Course();
        course.setProgram(program);
        course.setCode(code);
        course.setTitle(title);
        course.setDescription(description);
        course.setLevel(level);
        course.setLanguage(language);
        course.setOrderIndex(orderIndex);
        return courseRepository.save(course);
    }

    private Chapter chapter(Course course, String title, String description, Integer orderIndex) {
        Chapter chapter = new Chapter();
        chapter.setCourse(course);
        chapter.setTitle(title);
        chapter.setDescription(description);
        chapter.setOrderIndex(orderIndex);
        return chapterRepository.save(chapter);
    }

    private Lesson lesson(Chapter chapter, String type, String title, String description, Integer orderIndex, Integer levelNumber, String contentData) {
        Lesson lesson = new Lesson();
        lesson.setChapter(chapter);
        lesson.setType(type);
        lesson.setTitle(title);
        lesson.setDescription(description);
        lesson.setOrderIndex(orderIndex);
        lesson.setLevelNumber(levelNumber);
        lesson.setContentData(contentData);
        return lessonRepository.save(lesson);
    }

    private AiPromptTemplate prompt(Lesson lesson, String type, String instruction) {
        AiPromptTemplate prompt = new AiPromptTemplate();
        prompt.setLesson(lesson);
        prompt.setPromptType(type);
        prompt.setPromptInstruction(instruction);
        prompt.setIsActive(true);
        return promptTemplateRepository.save(prompt);
    }

    private AiGeneratedQuestion quiz(Lesson lesson, String question, String a, String b, String c, String d, String answer, String explanation) {
        AiGeneratedQuestion quiz = new AiGeneratedQuestion();
        quiz.setLesson(lesson);
        quiz.setPromptType("quiz");
        quiz.setGeneratedQuestion(question);
        quiz.setOptionA(a);
        quiz.setOptionB(b);
        quiz.setOptionC(c);
        quiz.setOptionD(d);
        quiz.setCorrectOption(answer);
        quiz.setExplanation(explanation);
        quiz.setUsedByModerator(false);
        quiz.setGeneratedAt(LocalDateTime.now());
        return aiQuestionRepository.save(quiz);
    }

    private Room room(String title, String language, Integer level, String roomType, String status, AppUser host,
                      Course course, Chapter chapter, Lesson currentLesson, Integer maxParticipants, String description) {
        Room room = new Room();
        room.setTitle(title);
        room.setLanguageCode(language);
        room.setLevelNumber(level);
        room.setRoomType(roomType);
        room.setStatus(status);
        room.setHostUser(host);
        room.setCourse(course);
        room.setChapter(chapter);
        room.setCurrentLesson(currentLesson);
        room.setMaxParticipants(maxParticipants);
        room.setDescription(description);
        room.setStageStartedAt(LocalDateTime.now().minusMinutes(4));
        if ("LIVE".equals(status)) {
            room.setStartedAt(LocalDateTime.now().minusMinutes(10));
        }
        return roomRepository.save(room);
    }

    private RoomParticipant participant(Room room, AppUser user, String role, Boolean micOn, Boolean handRaised) {
        RoomParticipant participant = new RoomParticipant();
        participant.setRoom(room);
        participant.setUser(user);
        participant.setDisplayName(user.getDisplayName());
        participant.setRoleInRoom(role);
        participant.setMicOn(micOn);
        participant.setHandRaised(handRaised);
        participant.setJoinedAt(LocalDateTime.now().minusMinutes(5));
        return participantRepository.save(participant);
    }

    private JoinRequest joinRequest(Room room, AppUser user, String requestedRole) {
        JoinRequest request = new JoinRequest();
        request.setRoom(room);
        request.setUser(user);
        request.setDisplayName(user.getDisplayName());
        request.setRoleRequested(requestedRole);
        request.setStatus("PENDING");
        request.setRequestedAt(LocalDateTime.now().minusMinutes(2));
        return joinRequestRepository.save(request);
    }

    private PinnedMaterial pinned(Room room, Lesson lesson, String title, String content) {
        PinnedMaterial pinned = new PinnedMaterial();
        pinned.setRoom(room);
        pinned.setLesson(lesson);
        pinned.setTitle(title);
        pinned.setContent(content);
        pinned.setActive(true);
        pinned.setPinnedAt(LocalDateTime.now().minusMinutes(3));
        return pinnedMaterialRepository.save(pinned);
    }

    private GiftTransaction giftTransaction(Gift gift, AppUser sender, AppUser receiver, Room room, Integer amount) {
        GiftTransaction transaction = new GiftTransaction();
        transaction.setGift(gift);
        transaction.setSender(sender);
        transaction.setReceiver(receiver);
        transaction.setRoom(room);
        transaction.setCreditAmount(amount);
        transaction.setCreatedAt(LocalDateTime.now().minusMinutes(1));
        return giftTransactionRepository.save(transaction);
    }

    private CreditTransaction credit(AppUser user, Double amount, String type, String description) {
        CreditTransaction transaction = new CreditTransaction();
        transaction.setUser(user);
        transaction.setAmount(amount);
        transaction.setType(type);
        transaction.setDescription(description);
        transaction.setCreatedAt(LocalDateTime.now().minusMinutes(1));
        return creditTransactionRepository.save(transaction);
    }

    private PremiumContent premiumContent(String title, String description, AppUser creator, Course course, Chapter chapter, Integer price) {
        PremiumContent content = new PremiumContent();
        content.setTitle(title);
        content.setDescription(description);
        content.setCreator(creator);
        content.setCourse(course);
        content.setChapter(chapter);
        content.setPriceCredits(price);
        content.setActive(true);
        content.setCreatedAt(LocalDateTime.now().minusDays(1));
        return premiumContentRepository.save(content);
    }

    private PodcastEpisode podcast(String title, String description, AppUser creator, Room room, Boolean premium, Integer price, AppUser unlockedUser) {
        PodcastEpisode podcast = new PodcastEpisode();
        podcast.setTitle(title);
        podcast.setDescription(description);
        podcast.setCreator(creator);
        podcast.setRoom(room);
        podcast.setAudioUrl("/mock-audio/" + title.toLowerCase().replace(" ", "-") + ".mp3");
        podcast.setDurationSeconds(360);
        podcast.setStatus("PUBLISHED");
        podcast.setIsPremium(premium);
        podcast.setPrice(price);
        podcast.setCreatedAt(LocalDateTime.now().minusHours(3));
        if (Boolean.TRUE.equals(premium)) {
            podcast.getUnlockedByUsers().add(unlockedUser);
        }
        return podcastRepository.save(podcast);
    }

    private void printAccounts() {
        System.out.println("Mock accounts: admin@lucy.mock, learner@lucy.mock, moderator@lucy.mock, mentor@lucy.mock, creator@lucy.mock");
        System.out.println("Mock password for all accounts: " + DEMO_PASSWORD);
    }
}
