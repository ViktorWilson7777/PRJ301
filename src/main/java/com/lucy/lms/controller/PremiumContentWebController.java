package com.lucy.lms.controller;

import com.lucy.lms.entity.PremiumContent;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class PremiumContentWebController {

    private final PremiumContentRepository premiumRepository;
    private final AppUserRepository userRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final CreditTransactionRepository transactionRepository;

    public PremiumContentWebController(PremiumContentRepository premiumRepository,
                                       AppUserRepository userRepository,
                                       CourseRepository courseRepository,
                                       ChapterRepository chapterRepository,
                                       CreditTransactionRepository transactionRepository) {
        this.premiumRepository = premiumRepository;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.transactionRepository = transactionRepository;
    }

    @GetMapping("/premium-content")
    public String premiumContent(Model model, jakarta.servlet.http.HttpSession session) {
        com.lucy.lms.entity.AppUser currentUser = (com.lucy.lms.entity.AppUser) session.getAttribute("currentUser");
        boolean isAdmin = currentUser != null && ("ADMIN".equals(currentUser.getRole()) || "SUPER_CREATOR".equals(currentUser.getRole()));

        if (isAdmin) {
            model.addAttribute("contents", premiumRepository.findAll());
            return "premium-content";
        } else {
            java.util.List<PremiumContent> activeContents = premiumRepository.findAll().stream()
                    .filter(c -> c.getActive() != null && c.getActive())
                    .toList();
            model.addAttribute("contents", activeContents);

            java.util.Set<Long> unlockedIds = new java.util.HashSet<>();
            if (currentUser != null) {
                for (PremiumContent c : activeContents) {
                    boolean hasTx = transactionRepository.existsByUserIdAndTypeAndDescriptionContaining(
                            currentUser.getId(), "PREMIUM_PURCHASE", "[PREMIUM_CONTENT:" + c.getId() + "]"
                    );
                    if (hasTx) {
                        unlockedIds.add(c.getId());
                    }
                }
            }
            model.addAttribute("unlockedIds", unlockedIds);
            return "premium-content-learner";
        }
    }

    @PostMapping("/premium-content/buy/{id}")
    public String buyPremiumContent(@PathVariable Long id, jakarta.servlet.http.HttpSession session) {
        com.lucy.lms.entity.AppUser currentUser = (com.lucy.lms.entity.AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        PremiumContent content = premiumRepository.findById(id).orElse(null);
        if (content == null) return "redirect:/premium-content?error=not_found";

        boolean alreadyPurchased = transactionRepository.existsByUserIdAndTypeAndDescriptionContaining(
                currentUser.getId(), "PREMIUM_PURCHASE", "[PREMIUM_CONTENT:" + content.getId() + "]"
        );
        if (alreadyPurchased) {
            return "redirect:/premium-content?error=already_purchased";
        }

        com.lucy.lms.entity.AppUser user = userRepository.findById(currentUser.getId()).orElse(currentUser);
        double balance = user.getCreditBalance() != null ? user.getCreditBalance() : 0.0;
        int price = content.getPriceCredits() != null ? content.getPriceCredits() : 0;

        if (balance < price) {
            return "redirect:/premium-content?error=insufficient_credits";
        }

        user.setCreditBalance(balance - price);
        userRepository.save(user);

        com.lucy.lms.entity.CreditTransaction tx = new com.lucy.lms.entity.CreditTransaction();
        tx.setUser(user);
        tx.setAmount((double) -price);
        tx.setType("PREMIUM_PURCHASE");
        tx.setDescription("Purchased premium content: " + content.getTitle() + " [PREMIUM_CONTENT:" + content.getId() + "]");
        transactionRepository.save(tx);

        session.setAttribute("currentUser", user);

        return "redirect:/premium-content?success=purchased&title=" + java.net.URLEncoder.encode(content.getTitle(), java.nio.charset.StandardCharsets.UTF_8);
    }

    @GetMapping("/premium-content/view/{id}")
    public String viewContent(@PathVariable Long id, Model model, jakarta.servlet.http.HttpSession session) {
        com.lucy.lms.entity.AppUser currentUser = (com.lucy.lms.entity.AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        PremiumContent content = premiumRepository.findById(id).orElse(null);
        if (content == null) return "redirect:/premium-content?error=not_found";

        boolean isAdmin = "ADMIN".equals(currentUser.getRole()) || "SUPER_CREATOR".equals(currentUser.getRole());
        boolean isOwner = content.getCreator() != null && content.getCreator().getId().equals(currentUser.getId());
        boolean isUnlocked = isAdmin || isOwner || transactionRepository.existsByUserIdAndTypeAndDescriptionContaining(
                currentUser.getId(), "PREMIUM_PURCHASE", "[PREMIUM_CONTENT:" + content.getId() + "]"
        );

        if (!isUnlocked) {
            return "redirect:/premium-content?error=locked";
        }

        model.addAttribute("content", content);
        return "premium-content-view";
    }

    @GetMapping("/premium-content/create")
    public String createPage(Model model) {
        model.addAttribute("content", new PremiumContent());
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "premium-content-form";
    }

    @PostMapping("/premium-content/save")
    public String save(@RequestParam(required = false) Long id,
                       @RequestParam String title,
                       @RequestParam(required = false) String description,
                       @RequestParam(required = false) Long creatorId,
                       @RequestParam(required = false) Integer priceCredits,
                       @RequestParam(required = false) Long courseId,
                       @RequestParam(required = false) Long chapterId,
                       @RequestParam(required = false) String active) {
        PremiumContent content;
        if (id != null) {
            content = premiumRepository.findById(id).orElse(new PremiumContent());
        } else {
            content = new PremiumContent();
        }
        content.setTitle(title);
        content.setDescription(description);
        content.setPriceCredits(priceCredits != null ? priceCredits : 0);
        content.setActive(active != null);

        if (creatorId != null) content.setCreator(userRepository.findById(creatorId).orElse(null));
        if (courseId != null) content.setCourse(courseRepository.findById(courseId).orElse(null));
        if (chapterId != null) content.setChapter(chapterRepository.findById(chapterId).orElse(null));

        premiumRepository.save(content);
        return "redirect:/premium-content";
    }

    @GetMapping("/premium-content/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        PremiumContent content = premiumRepository.findById(id).orElse(null);
        if (content == null) return "redirect:/premium-content";
        model.addAttribute("content", content);
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "premium-content-form";
    }

    @GetMapping("/premium-content/delete/{id}")
    public String delete(@PathVariable Long id) {
        premiumRepository.deleteById(id);
        return "redirect:/premium-content";
    }
}
