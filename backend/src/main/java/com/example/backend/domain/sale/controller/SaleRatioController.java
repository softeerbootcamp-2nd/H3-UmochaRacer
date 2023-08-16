package com.example.backend.domain.sale.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.service.SelfModeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/sale")
public class SaleRatioController {
    private final SelfModeService selfModeService;

    @GetMapping("{target}")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnSelectionRatioInSelfMode(
            @PathVariable String target
    ) {
        List<SalesSummaryResponse> result = selfModeService.getSelectionRatio(target);
        return mapToOKResponse(result);
    }

    @GetMapping("additional-option")
    public ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> returnOptionSelectionRatioInSelfMode(
        @RequestParam("category") String category
    ) {
        List<SalesSummaryResponse> result = selfModeService.getOptionSelectionRatio(category);
        return mapToOKResponse(result);
    }

    private ResponseEntity<ResponseDto<List<SalesSummaryResponse>>> mapToOKResponse(List<SalesSummaryResponse> result) {
        ResponseDto<List<SalesSummaryResponse>> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
