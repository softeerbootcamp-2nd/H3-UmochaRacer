package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DrivingSystemRepository extends CrudRepository<DrivingSystem, Long> {
    @Query("SELECT comment FROM DRIVING_SYSTEM WHERE id = :id")
    Optional<String> findDrivingSystemCommentById(long id);

    @Query("SELECT detail_id FROM DRIVING_SYSTEM WHERE id = :id")
    Optional<Long> findDetailIdById(long id);
}
