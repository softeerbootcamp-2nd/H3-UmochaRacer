package com.example.backend.domain.sale.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OptionRatioSummary extends RatioSummary {
    private int totalCount;

    public OptionRatioSummary(long id, int selectCount, int totalCount) {
        super(id, selectCount);
        this.totalCount = totalCount;
    }
}
