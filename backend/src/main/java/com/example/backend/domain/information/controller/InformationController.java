package com.example.backend.domain.information.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ErrorCode;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.InformationStrategyFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/info")
@RequiredArgsConstructor
public class InformationController {
    private final InformationStrategyFactory strategyFactory;

    @Order(2)
    @GetMapping("/{targetInfo}")
    public ResponseEntity<ResponseDto<List<CommonResponse>>> returnCarInformation(
            @PathVariable("targetInfo") String targetInfo
    ) {
        InformationStrategy informationStrategy = strategyFactory.findInformationStrategy(targetInfo);
        List<CommonResponse> result = informationStrategy.findAll();

        ResponseDto<List<CommonResponse>> body = ResponseDto.of(result, ErrorCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }

    @Order(1)
    @GetMapping("/interior_color")
    public ResponseEntity<ResponseDto<List<CommonResponse>>> returnInteriorColor(
            @RequestParam("exteriorColorId") long exteriorColorId
    ) {
        List<CommonResponse> result = strategyFactory.findInteriorColorByExteriorColor(exteriorColorId);

        ResponseDto<List<CommonResponse>> body = ResponseDto.of(result, ErrorCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}