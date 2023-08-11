package com.example.backend.domain.information.mapper;

import com.example.backend.domain.information.dto.ColorInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.dto.SimpleColorResponse;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class IntroSourceMapper {
    public SimpleColorResponse map(ExteriorColor exteriorColor) {
        return new SimpleColorResponse(exteriorColor.getName(), exteriorColor.getColorCode());
    }
    public SimpleColorResponse map(InteriorColor interiorColor) {
        return new SimpleColorResponse(interiorColor.getName(), interiorColor.getIconSrc());
    }

    public List<IntroResponse> mapToResponse(Map<String, List<SimpleColorResponse>> data) {
        return data.entrySet().stream()
                .map(entry -> new IntroResponse(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }
}
