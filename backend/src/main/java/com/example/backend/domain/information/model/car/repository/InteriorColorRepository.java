package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.InteriorColor;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InteriorColorRepository extends CrudRepository<InteriorColor, Long> {
    @Query("SELECT * FROM INTERIOR_COLOR ic WHERE ic.exterior_color_id = :exteriorColorId OR ic.exterior_color_id IS NULL")
    List<InteriorColor> findAllByExteriorColorId(long exteriorColorId);

    @Query("SELECT comment FROM INTERIOR_COLOR WHERE id = :id")
    Optional<String> findInteriorColorCommentById(long id);
}
