package org.ginasystem.ginasystembackend.controller.dto;

import lombok.Builder;

@Builder
public record AuditDTO(
    String createdAt,
    String updatedAt
) {

}
