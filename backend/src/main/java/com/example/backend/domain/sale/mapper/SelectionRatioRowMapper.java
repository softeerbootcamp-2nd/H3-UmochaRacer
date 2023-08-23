package com.example.backend.domain.sale.mapper;

import com.example.backend.domain.sale.entity.RatioSummary;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectionRatioRowMapper implements RowMapper<RatioSummary> {
    @Override
    public RatioSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new RatioSummary(
                rs.getLong("id"),
                rs.getInt("select_count")
        );
    }
}
