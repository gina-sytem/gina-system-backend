package org.ginasystem.ginasystembackend.service;

import lombok.RequiredArgsConstructor;
import org.ginasystem.ginasystembackend.domain.Customer;
import org.ginasystem.ginasystembackend.repository.CustomerRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class CustomerService {

    private final CustomerRepository customerRepository;

    public Customer save(final Customer customer) {
        // todo: dexar automatico
        customer.setCreatedAt(LocalDateTime.now());
        customer.setUpdatedAt(LocalDateTime.now());
        return customerRepository.save(customer);
    }
}
