package com.example.backend.domain.intro.dto;

import lombok.Getter;

@Getter
public class SimpleIntroResponse {
    private String name;
    private String imageSrc;

    public SimpleIntroResponse(String name, String imageSrc) {
        this.name = name;
        this.imageSrc = imageSrc;
    }
}
