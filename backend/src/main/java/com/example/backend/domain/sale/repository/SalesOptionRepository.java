package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesOptions;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SalesOptionRepository extends CrudRepository<SalesOptions, Long> {
}
