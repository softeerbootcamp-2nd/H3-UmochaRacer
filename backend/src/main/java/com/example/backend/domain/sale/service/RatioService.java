package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.SaleSummary;

import java.util.List;

public interface RatioService {
    List<SaleSummary> findSaleRatio(String columnId);
}
