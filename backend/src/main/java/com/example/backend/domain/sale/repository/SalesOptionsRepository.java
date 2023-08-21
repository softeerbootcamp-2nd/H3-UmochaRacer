package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesOptions;
import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesOptionsRepository extends CrudRepository<SalesOptions, Long> {
    @Query(
            value = "SELECT so.additional_option_id      AS id,\n" +
                    "       COUNT(*)                     AS select_count\n" +
                    "FROM SALES_OPTIONS so\n" +
                    "WHERE so.additional_option_id IN (SELECT id\n" +
                    "                                  FROM ADDITIONAL_OPTION\n" +
                    "                                  WHERE category = :category)\n" +
                    "AND so.sales_id IN \n" +
                    "    (SELECT id FROM SALES WHERE model_id IN\n" +
                    "            (SELECT id FROM MODEL WHERE trim_id = 1))\n" +
                    "GROUP BY so.additional_option_id",
            rowMapperClass = SelectionRatioRowMapper.class
    )
    List<RatioSummary> findSalesRatio(String category);
}
