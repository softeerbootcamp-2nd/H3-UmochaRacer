package com.example.backend.domain.information.model.car.repository;

import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.car.entity.Trim;
import com.example.backend.domain.information.model.car.entity.TrimInterior;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TrimInteriorRowMapper implements RowMapper<TrimInterior> {
    @Override
    public TrimInterior mapRow(ResultSet rs, int rowNum) throws SQLException {
        Trim trim = Trim.builder()
                .name(rs.getString("trim_name"))
                .build();

        InteriorColor interiorColor = InteriorColor.builder()
                .name(rs.getString("ic_name"))
                .iconSrc(rs.getString("icon_src"))
                .build();

        return new TrimInterior(
                rs.getLong("id"),
                rs.getLong("trim_id"),
                rs.getLong("interior_color_id"),
                trim,
                interiorColor
        );
    }
}
