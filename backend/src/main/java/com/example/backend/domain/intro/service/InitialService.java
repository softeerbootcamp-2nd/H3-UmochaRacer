package com.example.backend.domain.intro.service;

import com.example.backend.domain.intro.dto.EstimateResponse;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InitialService {
    public List<EstimateResponse> initializeEstimate() {
        List<EstimateResponse> estimateResponses = new ArrayList<>();
        estimateResponses.add(new EstimateResponse("파워트레인", "가솔린3.8", "car", 0));
        estimateResponses.add(new EstimateResponse("구동 방식", "2WD", "car", 0));
        estimateResponses.add(new EstimateResponse("바디 타입", "7인승", "car", 0));
        estimateResponses.add(new EstimateResponse("외장 색상", "어비스 블랙 펄", "color", 0));
        estimateResponses.add(new EstimateResponse("내장 색상", "퀼팅 천연(블랙)", "color", 0));
        return estimateResponses;
    }

}
