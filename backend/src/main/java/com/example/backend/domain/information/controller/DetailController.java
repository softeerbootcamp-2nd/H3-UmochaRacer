package com.example.backend.domain.information.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.DetailResponse;
import com.example.backend.domain.information.service.AdditionalOptionService;
import com.example.backend.domain.information.service.DetailService;
import com.example.backend.domain.information.service.InformationStrategyFactory;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/detail")
@RequiredArgsConstructor
public class DetailController {
    private final InformationStrategyFactory strategyFactory;
    private final DetailService detailService;
    private final AdditionalOptionService additionalOptionService;

    @GetMapping("/{targetInfo}/{id}")
    public ResponseEntity<ResponseDto<DetailResponse>> returnDetail(
            @PathVariable("targetInfo") String targetInfo, @PathVariable("id") long targetId
    ) {
        InformationStrategy informationStrategy = strategyFactory.findInformationStrategy(targetInfo);
        Long detailId = informationStrategy.findDetailId(targetId);
        DetailResponse detailResponse = detailService.getDetailById(detailId);

        ResponseDto<DetailResponse> body = ResponseDto.of(detailResponse, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }

    @Order(1)
    @GetMapping("/additional-option/{id}")
    public ResponseEntity<ResponseDto<DetailResponse>> returnAdditionalOptionDetail (
            @PathVariable("id") long targetId
    ){
        Long detailId = additionalOptionService.findDetailId(targetId);
        DetailResponse result = detailService.getDetailById(detailId);

        ResponseDto<DetailResponse> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }

}
