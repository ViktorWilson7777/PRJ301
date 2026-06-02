package com.lucy.lms.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI lucyOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("LUCY LMS API")
                        .version("1.0")
                        .description("PRJ301 demo REST API for LUCY — Language Unity & Collaborative Youth. " +
                                "Covers LMS content, Room management, AI support, Billing, and User APIs. " +
                                "All billing and AI features are mock/sandbox implementations.")
                        .contact(new Contact().name("PRJ301 Team")));
    }
}