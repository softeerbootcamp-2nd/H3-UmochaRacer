package com.example.backend.domain.global.dto;

import lombok.Getter;

@Getter
public class ResponseDto<T> {
    public static <S> ResponseDto<S> of(S s) {
        return new ResponseDto<>(s, "");
    }

    public static <S> ResponseDto<S> of(S s, String message) {
        return new ResponseDto<>(s, message);
    }

    private final T data;
    private final String message;

    private ResponseDto(T data, String message) {
        this.data = data;
        this.message = message;
    }
}
