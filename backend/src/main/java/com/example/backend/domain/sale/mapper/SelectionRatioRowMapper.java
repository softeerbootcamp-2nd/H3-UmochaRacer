package com.example.backend.domain.sale.mapper;

import com.example.backend.domain.sale.entity.SalesSummary;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectionRatioRowMapper implements RowMapper<SalesSummary> {
    @Override
    public SalesSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new SalesSummary(
                rs.getLong("id"),
                rs.getInt("select_count")
        );
    }
}
