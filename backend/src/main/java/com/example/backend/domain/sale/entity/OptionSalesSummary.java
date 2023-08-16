package com.example.backend.domain.sale.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OptionSalesSummary extends SalesSummary {
    private int totalCount;

    public OptionSalesSummary(long id, int selectCount, int totalCount) {
        super(id, selectCount);
        this.totalCount = totalCount;
    }
}
