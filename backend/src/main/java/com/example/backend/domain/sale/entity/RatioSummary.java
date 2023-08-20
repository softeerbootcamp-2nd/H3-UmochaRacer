package com.example.backend.domain.sale.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class RatioSummary {
    private Long id;
    private int selectionCount;

    public RatioSummary(Long id, int selectionCount) {
        this.id = id;
        this.selectionCount = selectionCount;
    }
}
