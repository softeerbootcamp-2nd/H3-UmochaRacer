package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SalesSummary;

import java.util.List;

public interface RatioService {
    List<SalesSummary> findSaleRatio(String columnId);
}
