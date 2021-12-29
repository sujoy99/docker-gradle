package com.example.docker_gradle.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;


@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket apiDocket() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .securityContexts(Arrays.asList(securityContext()))
                .securitySchemes(Arrays.asList(apiKey())).select()
                .apis(RequestHandlerSelectors.basePackage("com.example.docker_gradle.resource"))
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }

    private ApiKey apiKey() {
        return new ApiKey(
                "JWT",
                "Authorization",
                "header"
        );
    }

    private SecurityContext securityContext() {
        return SecurityContext.builder()
                .securityReferences(defaultAuth())
                .build();
    }

    private List<SecurityReference> defaultAuth() {
        AuthorizationScope scope = new AuthorizationScope(
                "global",
                "accessEverything"
        );
        AuthorizationScope[] scopes = new AuthorizationScope[1];
        scopes[0] = scope;
        return Arrays.asList(new SecurityReference("JWT", scopes));
    }


    private ApiInfo apiInfo() {
        return new ApiInfo(

                "E-Survey Service API",
                "API for web and mobile client",
                "1.0",
                "www.eatlbd.net",
                new Contact(
                        "Support",
                        "eatlbd.net/api/support",
                        "info@eatlbd.net"
                ),
                "Apache License Version 2.0",
                "https://www.apache.org/licenses/LICENSE-2.0",
                Collections.emptyList()
        );
    }
}

