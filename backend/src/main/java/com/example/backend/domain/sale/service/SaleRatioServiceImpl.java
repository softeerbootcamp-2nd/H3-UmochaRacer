package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SaleSummary;
import com.example.backend.domain.sale.repository.SalesTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SaleRatioServiceImpl implements RatioService {
    private final SalesTemplateRepository salesRepository;

    @Override
    public List<SaleSummary> findSaleRatio(String columnId) {
        return salesRepository.findSaleRatio(columnId);
    }
}
