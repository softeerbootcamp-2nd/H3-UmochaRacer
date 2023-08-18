package com.example.backend.domain.guide.repository;

import com.example.backend.domain.sale.entity.enums.Gender;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class TagOptionRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<Long> findOptionIdByTagId(String category, Long tagId) {
        String query = String.format("SELECT %s_id FROM TAG_%s WHERE tag_id = %d", category, category.toUpperCase(), tagId);
        return jdbcTemplate.query(query, getRowMapperOfField(category));
    }

    private RowMapper<Long> getRowMapperOfField(String field) {
        return new RowMapper<Long>() {
            @Override
            public Long mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getLong(field + "_id");
            }
        };
    }

    public List<Long> findOptionIdByGenderAge(String category, Gender gender, int age) {
        String category_id = category + "_id";
        String query = "SELECT m." + category_id + ", COUNT(*) as select_count FROM SALES s\n" +
                "JOIN MODEL m on s.model_id = m.id WHERE m.trim_id = 1 AND\n" +
                "s.gender = \'" + gender.name() + "\' AND "+ age + "<= s.age <" + (age+10) +
                " GROUP BY m." + category_id + " ORDER BY select_count DESC LIMIT 1";

        return jdbcTemplate.query(query, getRowMapperOfField(category));
    }

    public List<Long> findColorIdByGenderAge(String category, Gender gender, int age) {
        String category_id = category + "_id";
        String query = "SELECT s." + category_id + ", COUNT(*) as select_count FROM SALES s\n" +
                "JOIN MODEL m on s.model_id = m.id WHERE m.trim_id = 1 AND\n" +
                "s.gender = \'" + gender.name() + "\' AND "+ age + "<= s.age <" + (age+10) +
                " GROUP BY s." + category_id + " ORDER BY select_count DESC LIMIT 1";

        return jdbcTemplate.query(query, getRowMapperOfField(category));
    }
}
