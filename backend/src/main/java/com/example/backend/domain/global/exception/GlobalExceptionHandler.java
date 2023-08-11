package com.example.backend.domain.global.exception;

import com.example.backend.domain.global.dto.ErrorResponse;
import com.example.backend.domain.global.model.enums.ErrorCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(RestApiException.class)
    public ResponseEntity<Object> handleClassNotFoundException(RestApiException exception) {
        ErrorCode errorCode = exception.getErrorCode();
        return handleExceptionInternal(errorCode);
    }

    private ResponseEntity<Object> handleExceptionInternal(ErrorCode errorCode) {
        return ResponseEntity.status(errorCode.getHttpStatus())
                .body(makeErrorResponse(errorCode));
    }

    private ErrorResponse makeErrorResponse(ErrorCode errorCode) {
        return ErrorResponse.builder()
                .code(errorCode.getCode())
                .status(errorCode.getHttpStatus())
                .message(errorCode.getMessage())
                .build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Object> handleWrongAccessException(IllegalArgumentException exception) {
        ErrorCode errorCode = ErrorCode.ILLEGAL_ARGUMENT;
        return handleExceptionInternal(errorCode);
    }
}
