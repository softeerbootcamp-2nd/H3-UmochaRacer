package com.example.backend.domain.intro.dto;

import lombok.Getter;

@Getter
public class EstimateResponse {
    private final String category;
    private final String key;
    private final String value;
    private final int price;

    public EstimateResponse(String category, String key, String value, int price) {
        this.category = category;
        this.key = key;
        this.value = value;
        this.price = price;
    }
}
