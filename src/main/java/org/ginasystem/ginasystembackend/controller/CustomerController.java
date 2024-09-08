package org.ginasystem.ginasystembackend.controller;

import io.swagger.v3.oas.annotations.ExternalDocumentation;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.ginasystem.ginasystembackend.controller.dto.request.NewCustomerRequestDTO;
import org.ginasystem.ginasystembackend.controller.dto.DataWrapperDTO;
import org.ginasystem.ginasystembackend.controller.dto.response.CustomerResponseDTO;

@Tag(
    name = "Customer Controller",
    description = "API for customer management",
    externalDocs = @ExternalDocumentation(
        description = "Wiki",
        url = "https://github.com/gina-system/gina-system-backend/wiki/Custumers-API"
    )
)
public interface CustomerController {

    @Operation(summary = "Create Customer")
    @ApiResponse(
        responseCode = "200",
        description = "Customer successfully saved",
        useReturnTypeSchema = true)
    DataWrapperDTO<CustomerResponseDTO> create(@NotNull @Valid DataWrapperDTO<NewCustomerRequestDTO> dto);
}
