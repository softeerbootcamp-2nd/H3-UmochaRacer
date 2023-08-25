package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.entity.RatioSummary;

import java.util.List;

public interface RatioService {
    List<RatioSummary> findSaleRatio(String columnId);
}
