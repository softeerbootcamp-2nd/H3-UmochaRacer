package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import com.example.backend.domain.information.model.option.repository.AdditionalOptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class WheelStrategy implements InformationStrategy{
    private final AdditionalOptionRepository additionalOptionRepository;

    @Override
    public List<CommonResponse> findAll() {
        List<AdditionalOption> all = additionalOptionRepository.findAllByType(AdditionalOption.Type.WHEEL.toString());
        return all.stream().map(InformationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.WHEEL;
    }
}
