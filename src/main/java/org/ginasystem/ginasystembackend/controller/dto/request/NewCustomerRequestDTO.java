package org.ginasystem.ginasystembackend.controller.dto.request;

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

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NewCustomerRequestDTO {

    @Valid
    @NotNull
    private NewCustomerRequestDTO.CustomerRequestWrapper customer;

    @Getter
    @Setter
    @Builder
    @ToString
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CustomerRequestWrapper {
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
        private List<NewCertificateRequestDTO> certificates;
    }
}