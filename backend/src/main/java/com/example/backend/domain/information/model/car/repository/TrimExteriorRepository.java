package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.TrimExterior;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrimExteriorRepository extends CrudRepository<TrimExterior, Long> {
}
