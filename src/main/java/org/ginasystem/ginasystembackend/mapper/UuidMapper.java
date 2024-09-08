package org.ginasystem.ginasystembackend.mapper;

import org.ginasystem.ginasystembackend.utils.Constants;
import org.mapstruct.Mapper;

import java.util.UUID;

@Mapper(componentModel = Constants.MAPSTRUCT_COMPONENT_MODEL)
public interface UuidMapper {

    default String toString(final UUID id) {
        if (id == null) {
            return null;
        }

        return id.toString();
    }

    default UUID fromString(final String id) {
        if (id == null || id.isBlank()) {
            return null;
        }

        return UUID.fromString(id);
    }
}
