package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.TrimExterior;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrimExteriorRepository extends CrudRepository<TrimExterior, Long> {
    @Query(value = "SELECT te.id, te.trim_id, te.exterior_color_id,\n" +
            "       t.name AS trim_name, ex.name AS ex_name, ex.color_code\n" +
            "FROM Trim_Exterior te \n" +
            "LEFT OUTER JOIN Trim t ON t.id = te.trim_id \n" +
            "LEFT OUTER JOIN Exterior_color ex ON ex.id = te.exterior_color_id",
            rowMapperClass = TrimExteriorRowMapper.class)
    List<TrimExterior> findAll();
}
