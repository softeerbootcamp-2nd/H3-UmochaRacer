package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.strategy.InformationStrategy.StrategyName;
import com.example.backend.domain.information.service.strategy.InteriorColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Component
public class InformationStrategyFactory {
    private final Map<StrategyName, InformationStrategy> informationStrategies;
    private final InteriorColorService interiorColorService;

    @Autowired
    public InformationStrategyFactory(Set<InformationStrategy> informationStrategies, InteriorColorService interiorColorService) {
        this.informationStrategies = new EnumMap<>(StrategyName.class);
        for (InformationStrategy strategy : informationStrategies) {
            this.informationStrategies.put(strategy.getStrategyName(), strategy);
        }
        this.interiorColorService = interiorColorService;
    }

    public InformationStrategy findInformationStrategy(String param) {
        return informationStrategies.get(StrategyName.valueOf(param.toUpperCase()));
    }

    public List<CommonResponse> findInteriorColorByExteriorColor(long exteriorColorId) {
        return interiorColorService.findAll(exteriorColorId);
    }

    public CommentResponse findInteriorColorCommentById(long id) {
        return interiorColorService.findCommentById(id);
    }
}
