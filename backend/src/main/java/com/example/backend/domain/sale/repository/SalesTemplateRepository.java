package com.example.backend.domain.sale.repository;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.entity.enums.Gender;
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
    private final String ADDITIONAL_OPTION_ID = "additional_option_id";

    public List<RatioSummary> findVehicleSpecificationSalesRatio(String columnId) {
        String query = "SELECT m." + columnId + " AS id, COUNT(*) AS select_count FROM MODEL m \n" +
                "INNER JOIN SALES s ON s.model_id = m.id \n" +
                "WHERE m.trim_id = 1\n" +
                "GROUP BY m." + columnId + " WITH ROLLUP ORDER BY select_count DESC ";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<RatioSummary> findSaleRatio(String columnId) {
        String query = "SELECT s." + columnId + " AS id, COUNT(*) AS select_count FROM MODEL m \n" +
                "INNER JOIN SALES s ON s.model_id = m.id \n" +
                "WHERE m.trim_id = 1\n" +
                "GROUP BY s." + columnId + " WITH ROLLUP ORDER BY select_count DESC";

        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<RatioSummary> findSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest) {
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
        String query = getQueryDependsOn(targetId)
                + getWhereQuery(targetId, estimateRequest);
        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    public List<RatioSummary> findSelectionRatioWithSameAgeAndGender(String target, EstimateRequest estimateRequest) {
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

    public List<RatioSummary> findSelectionRatioOfAdditionalOption(EstimateRequest estimateRequest) {
        String query = getWithQueryWithAdditionalOption(ADDITIONAL_OPTION_ID)
                + getWhereQuery(ADDITIONAL_OPTION_ID, estimateRequest);
        return jdbcTemplate.query(query, new SelectionRatioRowMapper());
    }

    private String getWhereQuery(String targetId, EstimateRequest estimateRequest) {
        return getWhereQuery(
                targetId, 
                estimateRequest.getTag1(),
                estimateRequest.getTag2(),
                estimateRequest.getTag3(),
                estimateRequest.getAge(), 
                estimateRequest.getGender()
        );
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

    private String getWithQueryWithAdditionalOption(String targetId) {
        return "with joined as (select " + targetId + ", age, gender, tag1, tag2, tag3\n" +
                "          from SALES s \n" +
                "join SALES_OPTIONS opt on s.id = opt.sales_id" +
                ")\n";
    }

    private String getWithQuery(String targetId) {
        return "with joined as (select " + targetId + ", age, gender, tag1, tag2, tag3\n" +
                "                from SALES s" +
                "               )\n";
    }

    private String getWhereQuery(String targetId, long tag1, long tag2, long tag3, int age, Gender gender) {
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
                "                    (" + age + " <= age and age<= " + (age + 9) + " and gender != '" + gender.name() + "')\n" +
                "                    or ((" + (age - 1) + " <= age or age >= " + (age + 10) + ") and gender = '" + gender.name() + "')\n" +
                "                    or (" + age + " <= age and age <= " + (age + 9) + " and gender = '" + gender.name() + "')\n" +
                "                )\n" +
                "    )\n" +
                "   or (\n" +
                "         " + age + " <= age  and age <= " + (age + 9) + "\n" +
                "        and gender = '" + gender.name() + "'\n" +
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
