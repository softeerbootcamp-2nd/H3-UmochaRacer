package com.example.backend.domain.sale.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.dto.RatioSummaryResponse;

import java.util.List;

public interface SelectionRatioWithSimilarUsersService {
    List<RatioSummaryResponse> calculateSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest);

    List<RatioSummaryResponse> calculateSelectionRatioWitSameAgeAndGender(String target, EstimateRequest estimateRequest);

    List<RatioSummaryResponse> calculateSelectionRatioWithAdditionalOption(EstimateRequest estimateRequest);
}
