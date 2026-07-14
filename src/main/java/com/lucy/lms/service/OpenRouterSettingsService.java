package com.lucy.lms.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicReference;

/**
 * Holds the OpenRouter configuration used by the running application.
 *
 * <p>The initial values still come from Spring configuration/environment
 * variables. Admin changes are deliberately kept in memory so an API secret
 * is never written into the source tree or rendered back to a browser.</p>
 */
@Service
public class OpenRouterSettingsService {

    private static final String DEFAULT_MODEL = "openrouter/auto";

    private final AtomicReference<Settings> settings;

    public OpenRouterSettingsService(
            @Value("${openrouter.api.key:${gemini.api.key:}}") String configuredApiKey,
            @Value("${openrouter.model:openrouter/auto}") String configuredModel
    ) {
        settings = new AtomicReference<>(new Settings(
                normalizeKey(configuredApiKey),
                normalizeModel(configuredModel)
        ));
    }

    public Settings current() {
        return settings.get();
    }

    public boolean isConfigured() {
        return !current().apiKey().isBlank();
    }

    public String maskedApiKey() {
        String key = current().apiKey();
        if (key.isBlank()) {
            return "Not configured";
        }

        int visibleCharacters = Math.min(4, key.length());
        return "\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022" + key.substring(key.length() - visibleCharacters);
    }

    /**
     * Updates the settings atomically. An empty new key keeps the current key,
     * unless {@code clearApiKey} was explicitly selected by the administrator.
     */
    public void update(String newApiKey, String newModel, boolean clearApiKey) {
        String model = normalizeModel(newModel);
        String suppliedKey = normalizeKey(newApiKey);

        if (!suppliedKey.isBlank() && suppliedKey.length() < 16) {
            throw new IllegalArgumentException("The OpenRouter API key appears to be incomplete.");
        }

        settings.updateAndGet(previous -> {
            String key = clearApiKey
                    ? ""
                    : (suppliedKey.isBlank() ? previous.apiKey() : suppliedKey);
            return new Settings(key, model);
        });
    }

    private static String normalizeKey(String value) {
        return value == null ? "" : value.trim();
    }

    private static String normalizeModel(String value) {
        if (value == null || value.trim().isEmpty()) {
            return DEFAULT_MODEL;
        }
        return value.trim();
    }

    public record Settings(String apiKey, String model) {
    }
}
