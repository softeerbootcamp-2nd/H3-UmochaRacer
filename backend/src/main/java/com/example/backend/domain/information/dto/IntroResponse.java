package com.example.backend.domain.information.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class IntroResponse {
    private String trim;
    private List<SimpleColorResponse> sources;

    public IntroResponse(String trim, List<SimpleColorResponse> sources) {
        this.trim = trim;
        this.sources = sources;
    }
}
