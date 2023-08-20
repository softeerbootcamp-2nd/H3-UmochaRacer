package com.example.backend.domain.guide.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.guide.dto.FinalEstimateResponse;
import com.example.backend.domain.guide.dto.TagListResponse;
import com.example.backend.domain.guide.service.CarRecommendationServiceImpl;
import com.example.backend.domain.guide.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/guide")
public class TagController {
    private final TagService tagService;
    private final CarRecommendationServiceImpl carRecommendationServiceImpl;

    @GetMapping("/tag")
    public ResponseEntity<ResponseDto<List<TagListResponse>>> returnAllTagWithCategory() {
        List<TagListResponse> results = tagService.returnAllTag();
        ResponseDto<List<TagListResponse>> body = ResponseDto.of(results, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }

    @PostMapping("")
    public ResponseEntity<ResponseDto<FinalEstimateResponse>> returnGuideOption(
            @RequestBody EstimateRequest request
    ) {
        FinalEstimateResponse result = carRecommendationServiceImpl.estimate(request);
        ResponseDto<FinalEstimateResponse> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
