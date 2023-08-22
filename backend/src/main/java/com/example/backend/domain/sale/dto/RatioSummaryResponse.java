package com.example.backend.domain.sale.dto;

import lombok.Getter;

@Getter
public class RatioSummaryResponse {
    private final long id;
    private final int selectionRatio;

    public RatioSummaryResponse(long id, int selectionRatio) {
        this.id = id;
        this.selectionRatio = selectionRatio;
    }
}
