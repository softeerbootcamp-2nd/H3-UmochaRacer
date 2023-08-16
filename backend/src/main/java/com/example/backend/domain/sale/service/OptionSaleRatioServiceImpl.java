package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.repository.SalesOptionsRepository;
import com.example.backend.domain.sale.repository.SalesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionSaleRatioServiceImpl implements RatioService {
    private final SalesOptionsRepository salesOptionsRepository;
    private final SalesRepository salesRepository;

    @Override
    public List<SalesSummary> findSaleRatio(String category) {
        List<SalesSummary> result = salesOptionsRepository.findSalesRatio(category.toUpperCase());
        Integer totalSales = salesRepository.getTotalSales();
        result.add(new SalesSummary(Long.MAX_VALUE, totalSales));
        return result;
    }
}
