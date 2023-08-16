package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExteriorColorRepository extends CrudRepository<ExteriorColor, Long> {
    @Query("SELECT comment FROM EXTERIOR_COLOR WHERE id = :id")
    String findExteriorColorCommentById(long id);

    @Query("SELECT * FROM EXTERIOR_COLOR LIMIT 6")
    List<ExteriorColor> findAllLimit();
}