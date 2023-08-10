package com.example.backend.domain.global.model.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    SUCCESS(1000, HttpStatus.OK, "성공"),

    NO_KEYWORD_EXIST(2001, HttpStatus.BAD_REQUEST, "키워드에 해당하는 정보가 없습니다."),
    NO_COMMENT_EXIST_FOR_ID(3001, HttpStatus.BAD_REQUEST, "option type과 id에 해당하는 커멘트가 없습니다.");

    private final int code;
    private final HttpStatus httpStatus;
    private final String message;
}
