package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.Detail;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetailRepository extends CrudRepository<Detail, Long> {
}
