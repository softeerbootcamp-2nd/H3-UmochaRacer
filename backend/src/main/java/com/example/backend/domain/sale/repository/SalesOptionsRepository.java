package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.SalesOptions;
import com.example.backend.domain.sale.entity.SaleSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesOptionsRepository extends CrudRepository<SalesOptions, Long> {
    @Query(
            value = "select so.additional_option_id as id, count(*) as select_count\n" +
                    "from SALES_OPTIONS so\n" +
                    "where id in (select ao.id from ADDITIONAL_OPTION ao where ao.category= :category)\n" +
                    "group by id\n" +
                    "with rollup",
            rowMapperClass = SelectionRatioRowMapper.class
    )
    List<SaleSummary> findSalesRatio(String category);
}
