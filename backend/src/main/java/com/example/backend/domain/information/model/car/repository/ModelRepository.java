package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.Model;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModelRepository extends CrudRepository<Model, Long> {
}
