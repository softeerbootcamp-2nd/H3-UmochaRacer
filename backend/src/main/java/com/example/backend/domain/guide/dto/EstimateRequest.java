package com.example.backend.domain.guide.dto;

import com.example.backend.domain.sale.entity.enums.Gender;
import lombok.Getter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Getter
public class EstimateRequest {
    private int age;
    private Gender gender;
    private long tag1;
    private long tag2;
    private long tag3;

    public List<Long> getTagList() {
        return Arrays.asList(tag1, tag2, tag3);
    }
}
