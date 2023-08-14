package com.example.backend.domain.information.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.service.AdditionalOptionService;
import com.example.backend.domain.information.service.InformationStrategyFactory;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
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
    private final AdditionalOptionService additionalOptionService;

    @Order(2)
    @GetMapping("/{targetInfo}")
    public ResponseEntity<ResponseDto<List<CommonResponse>>> returnCarInformation(
            @PathVariable("targetInfo") String targetInfo
    ) {
        InformationStrategy informationStrategy = strategyFactory.findInformationStrategy(targetInfo);
        List<CommonResponse> result = informationStrategy.findAll();
        return mapToOKResponse(result);
    }

    @Order(1)
    @GetMapping("/interior-color")
    public ResponseEntity<ResponseDto<List<CommonResponse>>> returnInteriorColor(
            @RequestParam("exteriorColorId") long exteriorColorId
    ) {
        List<CommonResponse> result = strategyFactory.findInteriorColorByExteriorColor(exteriorColorId);
        return mapToOKResponse(result);
    }

    @Order(1)
    @GetMapping("/additional-option")
    public ResponseEntity<ResponseDto<List<CommonResponse>>> returnAdditionalOptionByCategory(
            @RequestParam("category") String category
    ) {
        List<CommonResponse> result = additionalOptionService.getByCategory(category);
        return mapToOKResponse(result);
    }

    private ResponseEntity<ResponseDto<List<CommonResponse>>> mapToOKResponse(List<CommonResponse> result) {
        ResponseDto<List<CommonResponse>> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}