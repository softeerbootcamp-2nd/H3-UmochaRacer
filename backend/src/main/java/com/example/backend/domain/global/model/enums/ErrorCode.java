package com.example.backend.domain.global.model.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    SUCCESS(1000, HttpStatus.OK, "성공"),

    NO_KEYWORD_EXIST(2001, HttpStatus.BAD_REQUEST, "키워드에 해당하는 정보가 없습니다.");

    private final int code;
    private final HttpStatus httpStatus;
    private final String message;
}
