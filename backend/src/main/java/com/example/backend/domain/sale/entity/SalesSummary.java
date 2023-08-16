package com.example.backend.domain.sale.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SalesSummary {
    private Long id;
    private int selectionCount;

    public SalesSummary(Long id, int selectionCount) {
        this.id = id;
        this.selectionCount = selectionCount;
    }
}
