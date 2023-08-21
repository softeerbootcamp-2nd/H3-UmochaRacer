package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class SalesTemplateRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<RatioSummary> findVehicleSpecificationSalesRatio(String columnId) {
        String query = "SELECT m." + columnId + " AS id, COUNT(*) AS select_count FROM MODEL m \n" +
                "INNER JOIN SALES s ON s.model_id = m.id \n" +
                "WHERE m.trim_id = 1\n" +
                "GROUP BY m." + columnId + " WITH ROLLUP ";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<RatioSummary> findSaleRatio(String columnId) {
        String query = "SELECT s." + columnId + " AS id, COUNT(*) AS select_count FROM MODEL m \n" +
                "INNER JOIN SALES s ON s.model_id = m.id \n" +
                "WHERE m.trim_id = 1\n" +
                "GROUP BY s." + columnId + " WITH ROLLUP ";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }
}
