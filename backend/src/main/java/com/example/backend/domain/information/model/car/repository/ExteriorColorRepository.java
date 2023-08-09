package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExteriorColorRepository extends CrudRepository<ExteriorColor, Long> {
}