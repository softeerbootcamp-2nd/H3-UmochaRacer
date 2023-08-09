package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.repository.DrivingSystemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DrivingSystemStrategy implements InformationStrategy {
    private final DrivingSystemRepository repository;
    @Override
    public List<CommonResponse> findAll() {
        List<DrivingSystem> all = (List<DrivingSystem>) repository.findAll();
        return all.stream().map(InformationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.DRIVING_SYSTEM;
    }
}
