package org.ginasystem.ginasystembackend.controller.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NewCertificateRequestDTO {

    @NotBlank
    private String model;

    @NotNull
    private LocalDateTime expirationDate;

    @NotNull
    private LocalDateTime issueDate;
}
