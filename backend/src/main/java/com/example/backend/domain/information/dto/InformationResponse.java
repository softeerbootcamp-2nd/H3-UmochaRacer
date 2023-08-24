package com.example.backend.domain.information.dto;

import com.example.backend.domain.global.dto.ResponseDto;
import lombok.Getter;

import java.util.List;

public class InformationResponse {
    private List<? extends CommonResponse> data;

    public InformationResponse(List<? extends CommonResponse> data) {
        this.data = data;
    }
}
