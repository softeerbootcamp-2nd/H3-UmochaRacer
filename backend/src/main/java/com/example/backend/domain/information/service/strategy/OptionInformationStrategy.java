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
public class OptionInformationStrategy implements InformationStrategy {
    private final AdditionalOptionRepository additionalOptionRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<AdditionalOption> all = additionalOptionRepository
                .findAllByTopOptionIdIsNullAndFlag(AdditionalOption.Flag.ADDITIONAL.toString());
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.ADDITIONAL_OPTION;
    }
}
