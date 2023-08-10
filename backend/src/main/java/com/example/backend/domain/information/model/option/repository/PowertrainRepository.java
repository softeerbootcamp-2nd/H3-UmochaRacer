package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.Powertrain;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PowertrainRepository extends CrudRepository<Powertrain, Long> {
    @Query("SELECT comment FROM Powertrain WHERE id = :id")
    String findPowertrainCommentById(long id);
}
