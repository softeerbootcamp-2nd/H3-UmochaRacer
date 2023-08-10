package com.example.backend.domain.global.exception;

import com.example.backend.domain.global.model.enums.ErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class NoCommentException extends RuntimeException {
    private final ErrorCode errorCode;
}
