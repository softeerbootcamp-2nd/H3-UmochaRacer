package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.Trim;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrimRepository extends CrudRepository<Trim, Long> {
}
