package com.example.backend.domain.sale.dto;

import lombok.Getter;

@Getter
public class SalesSummaryResponse {
    private final long id;
    private final int selectionRatio;

    public SalesSummaryResponse(long id, int selectionRatio) {
        this.id = id;
        this.selectionRatio = selectionRatio;
    }
}
