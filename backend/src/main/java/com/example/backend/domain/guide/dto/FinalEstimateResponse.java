package com.example.backend.domain.guide.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class FinalEstimateResponse {
    private long powertrainId;
    private long bodytypeId;
    private long drivingSystemId;
    private long exteriorColorId;
    private long interiorColorId;
    private long wheelId;
    private List<Long> additionalOptionId;
}
