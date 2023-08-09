//package com.example.backend.domain.information.service.strategy;
//
//import com.example.backend.domain.information.dto.CommonResponse;
//import com.example.backend.domain.information.mapper.InformationMapper;
//import com.example.backend.domain.information.model.car.entity.InteriorColor;
//import com.example.backend.domain.information.model.car.repository.InteriorColorRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Component;
//
//import java.util.List;
//import java.util.stream.Collectors;
//
//@Component
//@RequiredArgsConstructor
//public class InteriorColorStrategy implements InformationStrategy {
//    private final InteriorColorRepository interiorColorRepository;
//
//    @Override
//    public List<CommonResponse> findAll(long exteriorColorId) {
//        List<InteriorColor> all = interiorColorRepository.findAllByExteriorColorId(exteriorColorId);
//        return all.stream().map(InformationMapper::map).collect(Collectors.toList());
//    }
//
//    @Override
//    public StrategyName getStrategyName() {
//        return StrategyName.INTERIOR_COLOR;
//    }
//}
