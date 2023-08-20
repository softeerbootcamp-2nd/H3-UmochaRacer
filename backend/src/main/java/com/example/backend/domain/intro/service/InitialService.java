package com.example.backend.domain.intro.service;

import com.example.backend.domain.intro.dto.EstimateResponse;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InitialService {
    public List<EstimateResponse> initializeEstimate() {
        List<EstimateResponse> estimateResponses = new ArrayList<>();
        // 카테고리: car, key; 파워트레인, value: 가솔린3.8
        estimateResponses.add(new EstimateResponse("car", "파워트레인", "가솔린3.8", 0));
        estimateResponses.add(new EstimateResponse("car", "구동 방식", "2WD", 0));
        estimateResponses.add(new EstimateResponse("car", "바디 타입", "7인승", 0));
        estimateResponses.add(new EstimateResponse("color", "외장 색상", "어비스 블랙 펄", 0));
        estimateResponses.add(new EstimateResponse("color", "내장 색상", "퀼팅 천연(블랙)", 0));
        return estimateResponses;
    }

}
