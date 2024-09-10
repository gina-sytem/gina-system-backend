package org.ginasystem.ginasystembackend.controller.dto.response;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.ginasystem.ginasystembackend.controller.dto.AuditDTO;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CertificateResponseDTO {

    @NotBlank
    private String id;

    @NotBlank
    private String model;

    @NotNull
    private LocalDateTime expirationDate;

    @NotNull
    private LocalDateTime issueDate;

    @Valid
    @NotNull
    private AuditDTO audit;
}
