package com.example.backend.domain.information.dto;

import lombok.Getter;

@Getter
public class SimpleColorResponse {
    private String name;
    private String imageSrc;

    public SimpleColorResponse(String name, String imageSrc) {
        this.name = name;
        this.imageSrc = imageSrc;
    }
}
