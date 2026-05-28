package com.lucy.lms.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
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
                        .description("API documentation for LUCY Content & LMS module"));
    }
}