package com.example.backend.domain.guide.dto;

import com.example.backend.domain.sale.entity.enums.Gender;
import lombok.Getter;

@Getter
public class EstimateRequest {
    private int age;
    private Gender gender;
    private long tag1;
    private long tag2;
    private long tag3;
}
