package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class SalesTemplateRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<SalesSummary> findVehicleSpecificationSalesRatio(String columnId) {
        String query = "SELECT\n" +
                "    m." + columnId + " AS id,\n" +
                "    COUNT(*) AS select_count\n" +
                "FROM SALES s\n" +
                "   JOIN MODEL m ON s.model_id = m.id\n" +
                "   JOIN POWERTRAIN pt ON m.powertrain_id = pt.id\n" +
                "   JOIN DRIVING_SYSTEM ds ON m.driving_system_id = ds.id\n" +
                "   JOIN BODYTYPE bt ON m.bodytype_id = bt.id\n" +
                "WHERE m.trim_id = 1\n" +
                "GROUP BY m." + columnId + "\n" +
                "WITH ROLLUP";
        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<SalesSummary> findSaleRatio(String columnId) {
        String query = "SELECT s." + columnId + " AS id, COUNT(*) AS select_count " +
                "FROM SALES s " +
                "GROUP BY s." + columnId + " WITH ROLLUP";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }
}
