package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import com.example.backend.domain.information.model.option.repository.PowertrainRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class PowertrainStrategy implements InformationStrategy {
    private final PowertrainRepository powertrainRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<Powertrain> all = (List<Powertrain>) powertrainRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.POWERTRAIN;
    }
}
