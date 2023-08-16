package com.example.backend.domain.sale.mapper;

import com.example.backend.domain.sale.entity.SaleSummary;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectionRatioRowMapper implements RowMapper<SaleSummary> {
    @Override
    public SaleSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new SaleSummary(
                rs.getLong("id"),
                rs.getInt("select_count")
        );
    }
}
