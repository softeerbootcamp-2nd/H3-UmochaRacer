package com.example.backend.domain.guide.dto;

import lombok.Getter;

@Getter
public class TagInformationResponse {
    private long id;
    private String name;

    public TagInformationResponse(long id, String name) {
        this.id = id;
        this.name = name;
    }
}
