package com.example.backend.domain.information.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class IntroResponse {
    private String trim;
    private List<SimpleIntroResponse> sources;

    public IntroResponse(String trim, List<SimpleIntroResponse> sources) {
        this.trim = trim;
        this.sources = sources;
    }
}
