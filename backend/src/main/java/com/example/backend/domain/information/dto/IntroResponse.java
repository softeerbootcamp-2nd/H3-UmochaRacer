package com.example.backend.domain.information.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class IntroResponse {
    private String trim;
    private List<CommonResponse> sources;

    public IntroResponse(String trim, List<CommonResponse> sources) {
        this.trim = trim;
        this.sources = sources;
    }
}
