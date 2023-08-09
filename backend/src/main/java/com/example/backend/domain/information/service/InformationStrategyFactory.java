package com.example.backend.domain.information.service;

import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.strategy.InformationStrategy.StrategyName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.Map;
import java.util.Set;

@Component
public class InformationStrategyFactory {
    private Map<StrategyName, InformationStrategy> informationStrategies;

    // Autowired 대신 AnnotationConfigApplicationContext??
    @Autowired
    public InformationStrategyFactory(Set<InformationStrategy> informationStrategies) {
        this.informationStrategies = new EnumMap<>(StrategyName.class);
        for(InformationStrategy strategy: informationStrategies) {
            this.informationStrategies.put(strategy.getStrategyName(), strategy);
        }
    }

    public InformationStrategy findInformationStrategy(String param) {
        return informationStrategies.get(StrategyName.valueOf(param.toUpperCase()));
    }
}
