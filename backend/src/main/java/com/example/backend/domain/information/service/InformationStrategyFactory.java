package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.strategy.InformationStrategy.StrategyName;
import com.example.backend.domain.information.service.strategy.InteriorColorStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Component
public class InformationStrategyFactory {
    private final Map<StrategyName, InformationStrategy> informationStrategies;
    private final InteriorColorStrategy interiorColorStrategy;

    @Autowired
    public InformationStrategyFactory(Set<InformationStrategy> informationStrategies, InteriorColorStrategy interiorColorStrategy) {
        this.informationStrategies = new EnumMap<>(StrategyName.class);
        for (InformationStrategy strategy : informationStrategies) {
            this.informationStrategies.put(strategy.getStrategyName(), strategy);
        }
        this.interiorColorStrategy = interiorColorStrategy;
    }

    public InformationStrategy findInformationStrategy(String param) {
        return informationStrategies.get(StrategyName.valueOf(param.toUpperCase()));
    }

    public List<CommonResponse> findInteriorColorByExteriorColor(long exteriorColorId) {
        return interiorColorStrategy.findAll(exteriorColorId);
    }

    public CommentResponse findInteriorColorCommentById(long id) {
        return interiorColorStrategy.findCommentById(id);
    }
}
