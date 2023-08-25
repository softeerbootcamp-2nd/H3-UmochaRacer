package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.repository.SalesTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VehicleTypeSaleRatioServiceImpl implements RatioService {
    private final SalesTemplateRepository salesRepository;

    @Override
    public List<RatioSummary> findSaleRatio(String columnId) {
        return salesRepository.findSaleRatio(columnId);
    }
}
