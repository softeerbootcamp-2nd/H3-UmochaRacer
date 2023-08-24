package com.example.backend.domain.guide.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class TagListResponse {
    private String category;
    private List<TagInformationResponse> tags;

    public TagListResponse(String category, List<TagInformationResponse> tags) {
        this.category = category;
        this.tags = tags;
    }
}
