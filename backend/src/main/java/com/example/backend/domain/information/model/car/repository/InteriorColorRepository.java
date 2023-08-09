package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.InteriorColor;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InteriorColorRepository extends CrudRepository<InteriorColor, Long> {
    @Query("SELECT ic FROM InteriorColor ic WHERE ic.exteriorColorId := id")
    List<InteriorColor> findAllByExteriorColorId(@Param("id")long exteriorColorId);
}
