package com.example.backend.domain.sale.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class TagRatioRequest {
    private String category;
    private Long optionId;
    private Long tag1;
    private Long tag2;
    private Long tag3;

    public List<Long> getTagList() {
        return List.of(tag1, tag2, tag3);
    }
}
