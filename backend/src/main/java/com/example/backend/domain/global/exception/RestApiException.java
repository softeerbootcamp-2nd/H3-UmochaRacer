package com.example.backend.domain.global.exception;


import com.example.backend.domain.global.model.enums.ResultCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class RestApiException extends RuntimeException{
    private final ResultCode resultCode;
}
