package org.ginasystem.ginasystembackend.mapper;

import org.ginasystem.ginasystembackend.controller.dto.request.NewCustomerRequestDTO;
import org.ginasystem.ginasystembackend.controller.dto.response.CustomerResponseDTO;
import org.ginasystem.ginasystembackend.domain.Customer;
import org.ginasystem.ginasystembackend.utils.Constants;
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(
    componentModel = Constants.MAPSTRUCT_COMPONENT_MODEL,
    uses = UuidMapper.class,
    injectionStrategy = InjectionStrategy.CONSTRUCTOR
)
public interface CustomerMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Customer toEntity(NewCustomerRequestDTO.CustomerRequestWrapper dto);

    @Mapping(target = "audit.createdAt", source = "createdAt")
    @Mapping(target = "audit.updatedAt", source = "updatedAt")
    // todo: mapear o certificados no futuro
    @Mapping(target = "certificates", ignore = true)
    CustomerResponseDTO.CustomerResponseWrapper fromEntity(Customer entity);
}
