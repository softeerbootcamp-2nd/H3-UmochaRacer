package com.example.backend.domain.sale.repository;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.example.backend.domain.global.utils.StringUtils.transUriToColumnId;

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

    public List<SalesSummary> findSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest) {
/*
        String rowFile = readSQLFile("sql/selectCountWithSimilarUsers.sql");
        String query = String.format(rowFile, transUriToColumnId(target));


        NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(jdbcTemplate);

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("targetId", transUriToColumnId(target))
                .addValue("age", estimateRequest.getAge())
                .addValue("gender", estimateRequest.getGender())
                .addValue("tag1", estimateRequest.getTag1())
                .addValue("tag2", estimateRequest.getTag2())
                .addValue("tag3", estimateRequest.getTag3());

        return namedTemplate.query(query, params, new SelectionRatioRowMapper());
*/
        String targetId = transUriToColumnId(target);
        long tag1 = estimateRequest.getTag1();
        long tag2 = estimateRequest.getTag2();
        long tag3 = estimateRequest.getTag3();
        int age = estimateRequest.getAge();
        String gender = estimateRequest.getGender();

        String query = getQueryDependsOn(targetId)
                + getWhereQuery(targetId, tag1, tag2, tag3, age, gender);
        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<SalesSummary> findSelectionRatioWithSameAgeAndGender(String target, EstimateRequest estimateRequest) {
        String targetId = transUriToColumnId(target);
        int age = estimateRequest.getAge();

        String query = getWithQuery(targetId) +
                "select " + targetId + " as id,\n" +
                "             count(" + targetId + ") as select_count \n" +
                "      from joined\n" +
                "      WHERE\n" +
                "              (" + age + "<=age and age<=" + (age + 9) + " and gender = 'MALE')\n" +
                "      group by " + targetId + "\n" +
                "with rollup";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    private String getQueryDependsOn(String targetId) {
        if (targetId.equals("wheel_id")) {
            return getWithQuery(targetId);
        }
        return getWithQueryWhenModelJoined(targetId);
    }

    private String getWithQueryWhenModelJoined(String targetId) {
        return "with joined as (select m." + targetId + ", age, gender, tag1, tag2, tag3\n" +
                "                from SALES s\n" +
                "                         join MODEL m on s.model_id = m.id\n" +
                "                where m.trim_id = 1\n" +
                "                )\n";
    }

    private String getWithQuery(String targetId) {
        return "with joined as (select " + targetId + ", age, gender, tag1, tag2, tag3\n" +
                "                from SALES s" +
                "               )\n";
    }

    private String getWhereQuery(String targetId, long tag1, long tag2, long tag3, int age, String gender) {
        return "select " + targetId + "       as id,\n" +
                "       count(" + targetId + ") as select_count\n" +
                "from joined\n" +
                "WHERE (\n" +
                "            (" + tag1 + ", " + tag2 + ", " + tag3 + ") in ((tag1, tag2, tag3),\n" +
                "                                      (tag1, tag3, tag2),\n" +
                "                                      (tag2, tag1, tag3),\n" +
                "                                      (tag2, tag3, tag1),\n" +
                "                                      (tag3, tag1, tag2),\n" +
                "                                      (tag3, tag2, tag1)\n" +
                "            )\n" +
                "        and (\n" +
                "                    (" + age + " <= age and age<= " + (age + 9) + " and gender != '" + gender + "')\n" +
                "                    or ((" + (age - 1) + " <= age or age >= " + (age + 10) + ") and gender = '" + gender + "')\n" +
                "                    or (" + age + " <= age and age <= " + (age + 9) + " and gender = '" + gender + "')\n" +
                "                )\n" +
                "    )\n" +
                "   or (\n" +
                "         " + age + " <= age  and age <= " + (age + 9) + "\n" +
                "        and gender = '" + gender + "'\n" +
                "        and (\n" +
                "                            (" + tag1 + ", " + tag2 + ") in ((tag1, tag2), (tag1, tag3),\n" +
                "                                               (tag2, tag1), (tag2, tag3),\n" +
                "                                               (tag3, tag1), (tag3, tag2))\n" +
                "                        or\n" +
                "                            (" + tag2 + ", " + tag3 + ") in ((tag1, tag2), (tag1, tag3),\n" +
                "                                               (tag2, tag1), (tag2, tag3),\n" +
                "                                               (tag3, tag1), (tag3, tag2))\n" +
                "                        or\n" +
                "                            (" + tag1 + ", " + tag3 + ") in ((tag1, tag2), (tag1, tag3),\n" +
                "                                               (tag2, tag1), (tag2, tag3),\n" +
                "                                               (tag3, tag1), (tag3, tag2))\n" +
                "                    )\n" +
                "        and (" + tag1 + ", " + tag2 + ", " + tag3 + ") not in (\n" +
                "                                          (tag1, tag2, tag3),\n" +
                "                                          (tag1, tag3, tag2),\n" +
                "                                          (tag2, tag1, tag3),\n" +
                "                                          (tag2, tag3, tag1),\n" +
                "                                          (tag3, tag1, tag2),\n" +
                "                                          (tag3, tag2, tag1)\n" +
                "        )\n" +
                "    )\n" +
                "group by " + targetId + "\n" +
                "with rollup";
    }
}
