package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class TagRatioTemplateRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<Long> findRelatedTagListWithOption(Long tagId, String category, Long optionId) {
        String query = String.format("SELECT tag_id FROM TAG_%s WHERE %s_id = %d AND tag_id = %d",
                                            category.toUpperCase(), category, optionId, tagId);
        return jdbcTemplate.query(query, new RowMapper<Long>() {
            @Override
            public Long mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getLong("tag_id");
            }
        });
    }

    public List<SalesSummary> findBaseOptionCount(Long tagId, String category, Long optionId) {
        String category_id = category + "_id";
        String query = "SELECT * FROM (SELECT m." + category_id + " AS id, COUNT(*) AS select_count FROM SALES s \n" +
                "JOIN MODEL m ON s.model_id = m.id \n" +
                " WHERE (s.tag1 = " + tagId + " OR s.tag2 = " + tagId + " OR s.tag3 = " + tagId + " )\n" +
                "GROUP BY m." + category_id + " WITH ROLLUP) AS count_table \n" +
                "WHERE id = " + optionId + " OR id IS NULL";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<SalesSummary> findColorWheelOptionCount(Long tagId, String category, Long optionId) {
        String category_id = category + "_id";
        String query = "SELECT * FROM (SELECT " + category_id + " AS id, COUNT(*) AS select_count FROM SALES \n" +
                "WHERE (tag1 = " + tagId + " OR tag2 = " + tagId + " OR tag3 = " + tagId + " )\n" +
                "GROUP BY " + category_id + " WITH ROLLUP) AS count_table \n" +
                "WHERE id = " + optionId + " OR id IS NULL";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<SalesSummary> findAdditionalOptionCount(Long tagId, String category, Long optionId) {
        String category_id = category + "_id";
        String query = "SELECT * FROM (SELECT so." + category_id + " AS id, COUNT(*) AS select_count FROM SALES s \n" +
                        "JOIN SALES_OPTIONS so ON s.id = so.sales_id \n" +
                        " WHERE (s.tag1 = " + tagId + " OR s.tag2 = " + tagId + " OR s.tag3 = " + tagId + " )\n" +
                        "GROUP BY so." + category_id + " WITH ROLLUP) AS count_table \n" +
                        "WHERE id = " + optionId + " OR id IS NULL";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }
}
