package com.example.backend.domain.global.dto;


import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class ErrorResponse {
    private final String message;
    private final HttpStatus status;
    private final int code;

    @Builder
    public ErrorResponse(String message, HttpStatus status, int code) {
        this.message = message;
        this.status = status;
        this.code = code;
    }
}
