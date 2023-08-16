package com.example.backend.domain.intro.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.intro.dto.EstimateResponse;
import com.example.backend.domain.intro.dto.IntroResponse;
import com.example.backend.domain.intro.service.ColorService;
import com.example.backend.domain.intro.service.InitialService;
import com.example.backend.domain.intro.service.OptionInformationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/v1/intro")
@RequiredArgsConstructor
public class IntroController {
    private final OptionInformationService optionInformationService;
    private final ColorService colorService;
    private final InitialService initialService;

    @GetMapping("/exterior-color")
    public ResponseEntity<ResponseDto<List<IntroResponse>>> getExteriorByTrim() {
        List<IntroResponse> result = colorService.returnExColorByEachTrim();
        return mapToOKResponse(result);
    }

    @GetMapping("interior-color")
    public ResponseEntity<ResponseDto<List<?>>> getInteriorByTrim() {
        List<IntroResponse> result = colorService.returnInColorByEachTrim();
        return mapToOKResponse(result);
    }

    @GetMapping("additional-option")
    public ResponseEntity<ResponseDto<IntroResponse>> getOptionsByEachTrim(
            @RequestParam(value = "trimId", required = false, defaultValue = "-1") long trimId,
            @RequestParam(value = "category", required = false, defaultValue = "") String category,
            @RequestParam(value = "page", required = false, defaultValue = "-1") int page,
            @RequestParam(value = "size", required = false, defaultValue = "5") int size
    ) {
        IntroResponse result = optionInformationService.findBy(trimId, category, page, size);
        return mapToOKResponse(result);
    }

    @GetMapping("estimate")
    public ResponseEntity<ResponseDto<List<EstimateResponse>>> initialEstimate() {
        List<EstimateResponse> estimateResponses = initialService.initializeEstimate();
        return mapToOKResponse(estimateResponses);
    }

    private <T> ResponseEntity<ResponseDto<T>> mapToOKResponse(T result) {
        ResponseDto<T> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
