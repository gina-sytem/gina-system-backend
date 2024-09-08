package org.ginasystem.ginasystembackend.controller.impl;

import lombok.RequiredArgsConstructor;
import org.ginasystem.ginasystembackend.controller.CustomerController;
import org.ginasystem.ginasystembackend.controller.dto.DataWrapperDTO;
import org.ginasystem.ginasystembackend.controller.dto.request.NewCustomerRequestDTO;
import org.ginasystem.ginasystembackend.controller.dto.response.CustomerResponseDTO;
import org.ginasystem.ginasystembackend.domain.Customer;
import org.ginasystem.ginasystembackend.mapper.CustomerMapper;
import org.ginasystem.ginasystembackend.service.CustomerService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/api/v1/customers")
@RequiredArgsConstructor
public class CustomerControllerImpl implements CustomerController {

    private final CustomerMapper customerMapper;
    private final CustomerService customerService;

    @Override
    @PostMapping
    public DataWrapperDTO<CustomerResponseDTO> create(
        @RequestBody final DataWrapperDTO<NewCustomerRequestDTO> dto) {

        final Customer customer = customerMapper.toEntity(dto.getData().getCustomer());
        final Customer customerSaved = customerService.save(customer);
        final CustomerResponseDTO.CustomerResponseWrapper customerDTO = customerMapper.fromEntity(customerSaved);

        return new DataWrapperDTO<>(new CustomerResponseDTO(customerDTO));
    }

}
