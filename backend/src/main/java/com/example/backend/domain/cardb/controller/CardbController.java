package com.example.backend.domain.cardb.controller;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.service.CardbService;
import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/cardb")
@RequiredArgsConstructor
public class CardbController {
    private final CardbService cardbService;

    @GetMapping
    public ResponseEntity<ResponseDto<CardbResponseDto>> returnCardb(
            @RequestParam(value = "keyword") String keyword
    ) throws RestApiException {
        CardbResponseDto result = cardbService.getDescriptionByKeyword(keyword);
        ResponseDto<CardbResponseDto> data = ResponseDto.of(result, ErrorCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(data);
    }
}
