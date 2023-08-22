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
            value = "SELECT ao.id, ao.select_count FROM (SELECT so.additional_option_id      AS id,\n" +
                    "       COUNT(*)                     AS select_count\n" +
                    "FROM SALES s\n" +
                    "INNER JOIN MODEL m ON s.model_id = m.id \n" +
                    "INNER JOIN SALES_OPTIONS so ON s.id = so.sales_id\n" +
                    "WHERE m.trim_id = 1\n" +
                    "GROUP BY so.additional_option_id) ao, ADDITIONAL_OPTION\n" +
                    "WHERE ao.id = ADDITIONAL_OPTION.id AND ADDITIONAL_OPTION.category = :category\n",
            rowMapperClass = SelectionRatioRowMapper.class
    )
    List<RatioSummary> findSalesRatio(String category);
}
