package com.example.backend.domain.guide.service;

import com.example.backend.domain.sale.entity.enums.Gender;

import java.util.List;

public interface OptionRecommendationHandler {
    // 태그 3순위까지 순차적으로 조회한다.
    List<Long> findByTag(String category, List<Long> tagId);

    // 판매량이 가장 높은 옵션을 조회한다.
    List<Long> findTopSalesCount(String category, Gender gender, int age);
}
