package org.ginasystem.ginasystembackend.repository;

import org.ginasystem.ginasystembackend.domain.Customer;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface CustomerRepository extends CrudRepository<Customer, UUID> {

}
