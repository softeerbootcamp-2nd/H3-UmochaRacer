package com.example.backend.domain.global.dto;

import com.example.backend.domain.global.model.enums.ErrorCode;
import lombok.Getter;

@Getter
public class ResponseDto<T> {
    public static <S> ResponseDto<S> of(S s, ErrorCode status) {
        return new ResponseDto<>(s, status.getMessage(), status.getCode());
    }

    private final T data;
    private final String message;
    private final int code;

    private ResponseDto(T data, String message, int code) {
        this.data = data;
        this.message = message;
        this.code = code;
    }
}
