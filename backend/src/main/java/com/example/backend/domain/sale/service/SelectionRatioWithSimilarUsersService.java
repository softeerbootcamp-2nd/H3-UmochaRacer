package com.example.backend.domain.sale.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;

import java.util.List;

public interface SelectionRatioWithSimilarUsersService {
    List<SalesSummaryResponse> calculateSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest);

    List<SalesSummaryResponse> calculateSelectionRatioWitSameAgeAndGender(String target, EstimateRequest estimateRequest);

    List<SalesSummaryResponse> calculateSelectionRatioWithAdditionalOption(EstimateRequest estimateRequest);
}
