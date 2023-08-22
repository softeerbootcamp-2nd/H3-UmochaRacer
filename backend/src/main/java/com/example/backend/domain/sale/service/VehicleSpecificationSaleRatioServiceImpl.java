package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.repository.SalesTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VehicleSpecificationSaleRatioServiceImpl implements RatioService {
    private final SalesTemplateRepository salesTemplateRepository;

    @Override
    public List<SalesSummary> findSaleRatio(String columnId) {
        return salesTemplateRepository.findVehicleSpecificationSalesRatio(columnId);
    }
}
