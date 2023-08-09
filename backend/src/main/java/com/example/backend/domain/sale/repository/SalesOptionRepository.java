package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesOption;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SalesOptionRepository extends CrudRepository<SalesOption, Long> {
}
