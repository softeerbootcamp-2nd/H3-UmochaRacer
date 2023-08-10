package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.TrimInterior;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrimInteriorRepository extends CrudRepository<TrimInterior, Long> {
    @Query(
            value = "SELECT ti.id, ti.trim_id, ti.interior_color_id,\n" +
            "       t.name AS trim_name, ic.name AS ic_name, ic.icon_src\n" +
            "FROM Trim_Interior ti\n" +
            "LEFT OUTER JOIN Trim t ON t.id = ti.trim_id \n" +
            "LEFT OUTER JOIN Interior_Color ic ON ic.id = ti.interior_color_id",
            rowMapperClass = TrimInteriorRowMapper.class
    )
    List<TrimInterior> findAll();
}
