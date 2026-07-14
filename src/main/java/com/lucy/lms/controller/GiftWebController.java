package com.lucy.lms.controller;

import com.lucy.lms.entity.Gift;
import com.lucy.lms.repository.GiftRepository;
import com.lucy.lms.repository.GiftTransactionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Controller
@SuppressWarnings("null")
public class GiftWebController {

    private static final long MAX_STICKER_SIZE = 3 * 1024 * 1024L;
    private static final int MAX_STICKER_DIMENSION = 4096;
    private static final Map<String, String> ALLOWED_IMAGE_TYPES = Map.of(
            "image/png", "png", "image/jpeg", "jpg", "image/gif", "gif");

    private final GiftRepository giftRepository;
    private final GiftTransactionRepository giftTransactionRepository;

    public GiftWebController(GiftRepository giftRepository,
                             GiftTransactionRepository giftTransactionRepository) {
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
    }

    @GetMapping("/gifts")
    public String gifts(Model model) {
        model.addAttribute("gifts", giftRepository.findAll());
        model.addAttribute("giftTransactions", giftTransactionRepository.findAll());
        return "gifts";
    }

    @GetMapping("/gifts/create")
    public String createGiftPage(Model model) {
        model.addAttribute("gift", new Gift());
        return "gift-form";
    }

    @PostMapping("/gifts/save")
    public String saveGift(@RequestParam(required = false) Long id,
                           @RequestParam String name,
                           @RequestParam(required = false) String icon,
                           @RequestParam(required = false) MultipartFile imageFile,
                           @RequestParam Integer creditCost,
                           @RequestParam(required = false) String active) {
        Gift gift;
        if (id != null) {
            gift = giftRepository.findById(id).orElse(new Gift());
        } else {
            gift = new Gift();
        }
        gift.setName(name);
        gift.setIcon(icon);
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String type = imageFile.getContentType() == null
                        ? "" : imageFile.getContentType().toLowerCase(Locale.ROOT);
                if (imageFile.getSize() <= 0 || imageFile.getSize() > MAX_STICKER_SIZE
                        || !ALLOWED_IMAGE_TYPES.containsKey(type)) {
                    return "redirect:/gifts?error=invalid_image";
                }
                BufferedImage decoded = ImageIO.read(imageFile.getInputStream());
                if (decoded == null || decoded.getWidth() < 1 || decoded.getHeight() < 1
                        || decoded.getWidth() > MAX_STICKER_DIMENSION || decoded.getHeight() > MAX_STICKER_DIMENSION) {
                    return "redirect:/gifts?error=invalid_image";
                }
                Path dir = Paths.get("uploads/gifts").toAbsolutePath().normalize();
                Files.createDirectories(dir);
                String filename = UUID.randomUUID() + ".png";
                Path destination = dir.resolve(filename).normalize();
                if (!destination.startsWith(dir) || !ImageIO.write(decoded, "png", destination.toFile())) {
                    return "redirect:/gifts?error=invalid_image";
                }
                deleteOldUploadedSticker(gift.getImageUrl(), dir);
                gift.setImageUrl("/uploads/gifts/" + filename);
            } catch (IOException ex) {
                return "redirect:/gifts?error=upload_failed";
            }
        }
        if (gift.getImageUrl() == null || gift.getImageUrl().isBlank()) {
            return "redirect:/gifts?error=image_required";
        }
        gift.setCreditCost(creditCost);
        gift.setActive(active != null);
        giftRepository.save(gift);
        return "redirect:/gifts";
    }

    @GetMapping("/gifts/edit/{id}")
    public String editGiftPage(@PathVariable Long id, Model model) {
        Gift gift = giftRepository.findById(id).orElse(null);
        if (gift == null) return "redirect:/gifts";
        model.addAttribute("gift", gift);
        return "gift-form";
    }

    @GetMapping("/gifts/delete/{id}")
    public String deleteGift(@PathVariable Long id) {
        giftRepository.deleteById(id);
        return "redirect:/gifts";
    }

    private void deleteOldUploadedSticker(String imageUrl, Path uploadDirectory) {
        if (imageUrl == null || !imageUrl.startsWith("/uploads/gifts/")) return;
        try {
            String filename = Paths.get(imageUrl.substring(imageUrl.lastIndexOf('/') + 1)).getFileName().toString();
            Path oldFile = uploadDirectory.resolve(filename).normalize();
            if (oldFile.startsWith(uploadDirectory)) Files.deleteIfExists(oldFile);
        } catch (IOException ignored) {
            // The new sticker is valid even if an old upload cannot be removed.
        }
    }
}
