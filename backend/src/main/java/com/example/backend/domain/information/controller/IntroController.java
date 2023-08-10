package com.example.backend.domain.information.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ErrorCode;
import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.service.ColorService;
import com.example.backend.domain.information.service.OptionInformationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/intro")
@RequiredArgsConstructor
public class IntroController {
    private final OptionInformationService optionInformationService;
    private final ColorService colorService;

    @GetMapping("/exterior-color")
    public ResponseEntity<ResponseDto<List<IntroResponse>>> getExteriorByTrim() {
        List<IntroResponse> result = colorService.returnExColorByEachTrim();
        return mapToOKResponse(result);
    }

    private <T> ResponseEntity<ResponseDto<T>> mapToOKResponse(T result) {
        ResponseDto<T> body = ResponseDto.of(result, ErrorCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
