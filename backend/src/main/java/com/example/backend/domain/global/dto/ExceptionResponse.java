package com.example.backend.domain.global.dto;


import lombok.Builder;
import lombok.Getter;

@Getter
public class ExceptionResponse {
    private final String message;
    private final int code;

    @Builder
    public ExceptionResponse(String message, int code) {
        this.message = message;
        this.code = code;
    }
}
