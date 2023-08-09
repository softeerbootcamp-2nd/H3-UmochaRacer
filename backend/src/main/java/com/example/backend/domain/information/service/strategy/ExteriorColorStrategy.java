package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.repository.ExteriorColorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class ExteriorColorStrategy implements InformationStrategy {
    private final ExteriorColorRepository exteriorColorRepository;

    @Override
    public List<CommonResponse> findAll() {
        List<ExteriorColor> all = (List<ExteriorColor>) exteriorColorRepository.findAll();
        return all.stream().map(InformationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.EXTERIOR_COLOR;
    }
}
