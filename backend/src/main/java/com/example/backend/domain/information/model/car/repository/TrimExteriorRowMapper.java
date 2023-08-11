package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.Trim;
import com.example.backend.domain.information.model.car.entity.TrimExterior;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TrimExteriorRowMapper implements RowMapper<TrimExterior> {
    @Override
    public TrimExterior mapRow(ResultSet rs, int rowNum) throws SQLException {
        Trim trim = Trim.builder()
                .name(rs.getString("trim_name"))
                .build();

        ExteriorColor exteriorColor = ExteriorColor.builder()
                .name(rs.getString("ex_name"))
                .colorCode(rs.getString("color_code"))
                .build();

        return new TrimExterior(
                rs.getLong("id"),
                rs.getLong("trim_id"),
                rs.getLong("exterior_color_id"),
                trim,
                exteriorColor
        );
    }
}
