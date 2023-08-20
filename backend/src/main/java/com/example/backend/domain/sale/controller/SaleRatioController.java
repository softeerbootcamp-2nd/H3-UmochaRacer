package com.example.backend.domain.sale.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.sale.dto.RatioSummaryResponse;
import com.example.backend.domain.sale.dto.TagRatioRequest;
import com.example.backend.domain.sale.service.SelfModeServiceFactory;
import com.example.backend.domain.sale.service.TagSelectionRatioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/sale")
public class SaleRatioController {
    private final SelfModeServiceFactory selfModeServiceFactory;
    private final TagSelectionRatioService tagSelectionRatioService;

    @GetMapping("{target:exterior-color|interior-color|wheel}/select")
    public ResponseEntity<ResponseDto<List<RatioSummaryResponse>>> returnSelectionRatioInSelfMode(
            @PathVariable String target
    ) {
        List<RatioSummaryResponse> result = selfModeServiceFactory.getSelectionRatio(target);
        return mapToOKResponse(result);
    }

    @GetMapping(value = "{target:powertrain|bodytype|driving-system}/select")
    public ResponseEntity<ResponseDto<List<RatioSummaryResponse>>> returnVehicleSpecificationSelectionRatioInSelfMode(
            @PathVariable String target
    ) {
        List<RatioSummaryResponse> result = selfModeServiceFactory.getVehicleSpecificationSaleRatio(target);
        return mapToOKResponse(result);
    }

    @GetMapping("additional-option/select")
    public ResponseEntity<ResponseDto<List<RatioSummaryResponse>>> returnOptionSelectionRatioInSelfMode(
            @RequestParam("category") String category
    ) {
        List<RatioSummaryResponse> result = selfModeServiceFactory.getOptionSelectionRatio(category);
        return mapToOKResponse(result);
    }

    @PostMapping("/tag")
    public ResponseEntity<ResponseDto<List<RatioSummaryResponse>>> returnTagSelectionRatio(
            @RequestBody TagRatioRequest request
    ) {
        List<RatioSummaryResponse> result = tagSelectionRatioService.getSelectionRatio(request);
        return mapToOKResponse(result);
    }

    private ResponseEntity<ResponseDto<List<RatioSummaryResponse>>> mapToOKResponse(List<RatioSummaryResponse> result) {
        ResponseDto<List<RatioSummaryResponse>> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
