package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.strategy.InformationStrategy.StrategyName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
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
        StrategyName strategyTarget = StrategyName.getByUri(param);
        return informationStrategies.get(strategyTarget);
    }

    public CommentResponse findInteriorColorCommentById(long id) {
        return interiorColorService.findCommentById(id);
    }
}
