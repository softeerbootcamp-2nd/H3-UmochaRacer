package com.example.backend.domain.guide.dto;

import lombok.Builder;
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

    @Builder
    public FinalEstimateResponse(long powertrainId, long bodytypeId, long drivingSystemId, long exteriorColorId, long interiorColorId, long wheelId, List<Long> additionalOptionId) {
        this.powertrainId = powertrainId;
        this.bodytypeId = bodytypeId;
        this.drivingSystemId = drivingSystemId;
        this.exteriorColorId = exteriorColorId;
        this.interiorColorId = interiorColorId;
        this.wheelId = wheelId;
        this.additionalOptionId = additionalOptionId;
    }
}
