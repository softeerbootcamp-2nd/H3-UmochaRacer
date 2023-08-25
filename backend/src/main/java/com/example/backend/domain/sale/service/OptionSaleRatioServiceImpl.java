package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.repository.SalesOptionsRepository;
import com.example.backend.domain.sale.repository.SalesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionSaleRatioServiceImpl implements RatioService {
    private final SalesOptionsRepository salesOptionsRepository;
    private final SalesRepository salesRepository;

    @Override
    @Cacheable(cacheNames = "optionSelectionRatio", key="#category")
    public List<RatioSummary> findSaleRatio(String category) {
        List<RatioSummary> result = salesOptionsRepository.findSalesRatio(category.toUpperCase());
        Integer totalSales = salesRepository.getTotalSales();
        result.add(new RatioSummary(Long.MAX_VALUE, totalSales));
        return result;
    }
}
