package com.example.backend.domain.information.controller;

import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.service.InformationStrategyFactory;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/comment")
@RequiredArgsConstructor
public class CommentController {
    private final InformationStrategyFactory strategyFactory;

    @GetMapping("/{targetInfo}")
    public ResponseEntity<ResponseDto<CommentResponse>> returnComment(
            @PathVariable("targetInfo") String targetInfo, @RequestParam("id") long targetId
    ) {
        InformationStrategy informationStrategy = strategyFactory.findInformationStrategy(targetInfo);
        CommentResponse commentResponse = informationStrategy.findCommentById(targetId);

        ResponseDto<CommentResponse> body = ResponseDto.of(commentResponse, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }

    @GetMapping("/interior_color")
    public ResponseEntity<ResponseDto<CommentResponse>> returnInteriorColorComment(
            @RequestParam("id") long targetId
    ) {
        CommentResponse result = strategyFactory.findInteriorColorCommentById(targetId);

        ResponseDto<CommentResponse> body = ResponseDto.of(result, ResultCode.SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(body);
    }
}
