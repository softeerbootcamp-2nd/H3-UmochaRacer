package com.example.backend.domain.sale.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SaleSummary {
    private Long id;
    private int selectionCount;

    public SaleSummary(Long id, int selectionCount) {
        this.id = id;
        this.selectionCount = selectionCount;
    }
}
