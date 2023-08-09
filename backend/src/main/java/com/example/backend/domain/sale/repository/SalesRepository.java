package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.Sales;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SalesRepository extends CrudRepository<Sales, Long> {
}
