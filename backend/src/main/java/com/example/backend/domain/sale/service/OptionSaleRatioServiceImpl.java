package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SaleSummary;
import com.example.backend.domain.sale.repository.SalesOptionsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionSaleRatioServiceImpl implements RatioService {
    private final SalesOptionsRepository salesOptionsRepository;

    @Override
    public List<SaleSummary> findSaleRatio(String category) {
        return salesOptionsRepository.findSalesRatio(category.toUpperCase());
    }
}
