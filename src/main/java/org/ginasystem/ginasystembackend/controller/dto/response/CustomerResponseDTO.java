package org.ginasystem.ginasystembackend.controller.dto.response;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.ginasystem.ginasystembackend.controller.dto.AuditDTO;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CustomerResponseDTO {

    @Valid
    @NotNull
    private CustomerResponseDTO.CustomerResponseWrapper customer;

    @Getter
    @Setter
    @Builder
    @ToString
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CustomerResponseWrapper {

        @NotBlank
        private String id;

        @NotBlank
        private String name;

        @NotBlank
        private String document;

        @NotNull
        private LocalDateTime birthDate;

        @NotBlank
        private String phoneNumber;

        @NotBlank
        @Email
        private String email;

        @NotBlank
        private String referenceNumber;

        @Valid
        @NotNull
        @NotEmpty
        private List<CertificateResponseDTO> certificates;

        @Valid
        @NotNull
        private AuditDTO audit;
    }
}
