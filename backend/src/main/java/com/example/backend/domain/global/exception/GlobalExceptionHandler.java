package com.example.backend.domain.global.exception;

import com.example.backend.domain.global.dto.ExceptionResponse;
import com.example.backend.domain.global.model.enums.ResultCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(RestApiException.class)
    public ResponseEntity<Object> handleClassNotFoundException(RestApiException exception) {
        ResultCode resultCode = exception.getResultCode();
        return handleExceptionInternal(resultCode);
    }

    private ResponseEntity<Object> handleExceptionInternal(ResultCode resultCode) {
        return ResponseEntity.status(resultCode.getHttpStatus())
                .body(makeErrorResponse(resultCode));
    }

    private ExceptionResponse makeErrorResponse(ResultCode resultCode) {
        return ExceptionResponse.builder()
                .code(resultCode.getCode())
                .message(resultCode.getMessage())
                .build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Object> handleWrongAccessException(IllegalArgumentException exception) {
        ResultCode resultCode = ResultCode.ILLEGAL_ARGUMENT;
        return handleExceptionInternal(resultCode);
    }
}
