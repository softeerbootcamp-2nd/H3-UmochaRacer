package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SaleSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class SalesTemplateRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<SaleSummary> findSaleRatio(String columnId) {
        String query = "SELECT s." + columnId + " AS id, COUNT(*) AS select_count " +
                "FROM SALES s " +
                "GROUP BY s." + columnId + " WITH ROLLUP";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }
}
