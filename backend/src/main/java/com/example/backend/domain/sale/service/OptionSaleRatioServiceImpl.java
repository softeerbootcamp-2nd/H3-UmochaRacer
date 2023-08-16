package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.repository.SalesOptionsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionSaleRatioServiceImpl implements RatioService {
    private final SalesOptionsRepository salesOptionsRepository;

    @Override
    public List<SalesSummary> findSaleRatio(String category) {
        return salesOptionsRepository.findSalesRatio(category.toUpperCase());
    }
}
