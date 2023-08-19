package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.Powertrain;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface
PowertrainRepository extends CrudRepository<Powertrain, Long> {
    @Query("SELECT comment FROM POWERTRAIN WHERE id = :id")
    Optional<String> findPowertrainCommentById(long id);

    @Query("SELECT detail_id FROM POWERTRAIN WHERE id = :id")
    Optional<Long> findDetailIdById(long id);
}
