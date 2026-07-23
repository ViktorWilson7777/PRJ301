package com.lucy.lms.config;

import com.lucy.lms.entity.Gift;
import com.lucy.lms.repository.GiftRepository;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Component
public class GiftPriceMigration implements ApplicationRunner {

    private static final Map<String, PriceChange> LEGACY_PRICES = Map.of(
            "star", new PriceChange(10, 2000),
            "coffee", new PriceChange(25, 5000),
            "firework", new PriceChange(50, 10000),
            "rose", new PriceChange(15, 3000),
            "diamond", new PriceChange(100, 20000));

    private final GiftRepository giftRepository;

    public GiftPriceMigration(GiftRepository giftRepository) {
        this.giftRepository = giftRepository;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        List<Gift> changed = new ArrayList<>();
        for (Gift gift : giftRepository.findAll()) {
            String name = gift.getName() == null
                    ? "" : gift.getName().trim().toLowerCase(Locale.ROOT);
            PriceChange priceChange = LEGACY_PRICES.get(name);
            if (priceChange != null && gift.getCreditCost() != null
                    && gift.getCreditCost() == priceChange.legacyPrice()) {
                gift.setCreditCost(priceChange.demoPrice());
                changed.add(gift);
            }
        }
        if (!changed.isEmpty()) {
            giftRepository.saveAll(changed);
        }
    }

    private record PriceChange(int legacyPrice, int demoPrice) {
    }
}
