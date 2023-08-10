package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.repository.BodytypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class BodytypeStrategy implements InformationStrategy {
    private final BodytypeRepository bodytypeRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<Bodytype> all = (List<Bodytype>) bodytypeRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.BODYTYPE;
    }
}
