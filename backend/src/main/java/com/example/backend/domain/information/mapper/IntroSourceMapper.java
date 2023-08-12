package com.example.backend.domain.information.mapper;

import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.dto.SimpleIntroResponse;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class IntroSourceMapper {
    public SimpleIntroResponse map(ExteriorColor exteriorColor) {
        return new SimpleIntroResponse(exteriorColor.getName(), exteriorColor.getColorCode());
    }

    public SimpleIntroResponse map(InteriorColor interiorColor) {
        return new SimpleIntroResponse(interiorColor.getName(), interiorColor.getIconSrc());
    }

    public SimpleIntroResponse map(AdditionalOption additionalOption) {
        return new SimpleIntroResponse(additionalOption.getName(), additionalOption.getImageSrc());
    }

    public List<IntroResponse> mapToResponse(Map<String, List<SimpleIntroResponse>> data) {
        return data.entrySet().stream()
                .map(entry -> new IntroResponse(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }
}
