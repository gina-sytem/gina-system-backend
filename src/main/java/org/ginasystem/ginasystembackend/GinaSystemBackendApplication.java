package org.ginasystem.ginasystembackend;

import io.swagger.v3.oas.annotations.ExternalDocumentation;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import java.time.ZoneId;
import java.time.format.TextStyle;
import java.util.Locale;

@OpenAPIDefinition(
	info = @Info(
		title = "Gina System - Backend API",
		description = "Backend do Gina System",
		contact = @Contact(
			url = "toDo Colocar site de suporte",
			name = "Gina System support"
		)
	),
	externalDocs = @ExternalDocumentation(
		url = "https://github.com/gina-system/gina-system-backend/wiki",
		description = "Wiki do projeto"
	)
)
@SpringBootApplication
@RequiredArgsConstructor
@EnableJpaRepositories(basePackages = "org.ginasystem.ginasystembackend.repository")
public class GinaSystemBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(GinaSystemBackendApplication.class, args);
		final var timeZone = ZoneId.systemDefault().getDisplayName(TextStyle.NARROW, Locale.ENGLISH);

		System.out.println("TimeZone: " + timeZone);
	}
}
