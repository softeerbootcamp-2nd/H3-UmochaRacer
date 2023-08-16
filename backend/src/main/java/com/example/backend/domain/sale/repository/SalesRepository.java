package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.Sales;
import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.mapper.SelectionRatioRowMapper;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesRepository extends CrudRepository<Sales, Long> {

    @Query(value = "SELECT :columnId as id , count(*) as select_count\n" +
            "FROM SALES s\n" +
            "group by id\n" +
            "with rollup",
        rowMapperClass = SelectionRatioRowMapper.class)
    List<SalesSummary> findSalesRatio(String columnId);

    @Query(value = "SELECT count(*) FROM SALES")
    Integer getTotalSales();
}
