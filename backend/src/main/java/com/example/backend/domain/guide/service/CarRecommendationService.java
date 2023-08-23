package com.example.backend.domain.guide.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.guide.dto.FinalEstimateResponse;

public interface CarRecommendationService {

    FinalEstimateResponse estimate(EstimateRequest estimate);
}
