package com.example.backend.domain.cardb.controller;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.service.CardbService;
import com.example.backend.domain.global.dto.ResponseDto;
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
            @RequestParam("keyword") String keyword
    ) {
        ResponseDto<CardbResponseDto> data;
        try {
            CardbResponseDto result = cardbService.getDescriptionByKeyword(keyword);
            data = ResponseDto.of(result);
        } catch (ClassNotFoundException e) {
            return ResponseEntity.status(HttpStatus.OK).body(ResponseDto.of(new CardbResponseDto(), "해당하는 단어가 없습니다."));
        }
        return ResponseEntity.status(HttpStatus.OK).body(data);
    }
}
