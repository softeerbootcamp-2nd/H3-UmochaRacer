package com.example.backend.domain.sale.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.service.SelectionRatioWithSimilarUsersService;
import com.example.backend.domain.sale.service.SelfModeServiceFactory;
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
    private final SelectionRatioWithSimilarUsersService selectionRatioWithSimilarUsersService;

    @GetMapping("{target:exterior-color|interior-color|wheel}/select")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnSelectionRatioInSelfMode(
            @PathVariable String target
    ) {
        List<SalesSummaryResponse> result = selfModeServiceFactory.getSelectionRatio(target);
        return mapToOKResponse(result);
    }

    @GetMapping(value = "{target:powertrain|bodytype|driving-system}/select")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnVehicleSpecificationSelectionRatioInSelfMode(
            @PathVariable String target
    ) {
        List<SalesSummaryResponse> result = selfModeServiceFactory.getVehicleSpecificationSaleRatio(target);
        return mapToOKResponse(result);
    }

    @GetMapping("additional-option/select")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnOptionSelectionRatioInSelfMode(
            @RequestParam("category") String category
    ) {
        List<SalesSummaryResponse> result = selfModeServiceFactory.getOptionSelectionRatio(category);
        return mapToOKResponse(result);
    }

    @PostMapping("/{target:powertrain|bodytype|driving-system|wheel}/tag")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnOrderedCarComponentSalesRatio(
            @PathVariable("target") String target,
            @RequestBody EstimateRequest estimateRequest
    ) {
        List<SalesSummaryResponse> result = selectionRatioWithSimilarUsersService.calculateSelectionRatioWithSimilarUsers(target, estimateRequest);
        return mapToOKResponse(result);
    }

    @PostMapping("/{target:exterior-color|interior-color}/tag")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnOrderedColorSalesRatio(
            @PathVariable("target") String target,
            @RequestBody EstimateRequest estimateRequest
    ) {
        List<SalesSummaryResponse> result = selectionRatioWithSimilarUsersService.calculateSelectionRatioWitSameAgeAndGender(target, estimateRequest);
        return mapToOKResponse(result);
    }

    private <T> ResponseEntity<ResponseDto<T>> mapToOKResponse(T t) {
        ResponseDto<T> body = ResponseDto.of(t, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
