package com.example.backend.domain.guide.service;

import com.example.backend.domain.guide.repository.TagOptionRepository;
import com.example.backend.domain.sale.entity.enums.Gender;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class OptionRecommendationHandlerImpl implements OptionRecommendationHandler {
    private final TagOptionRepository tagOptionRepository;

    @Override
    public List<Long> findByTag(String category, List<Long> tagIds) {
        for(Long tagId: tagIds) {
            List<Long> optionList = tagOptionRepository.findOptionIdByTagId(category, tagId);
            if(optionList.size() != 0)
                return optionList;
        }
        return new ArrayList<>();
    }

    @Override
    public List<Long> findTopSalesCount(String category, Gender gender, int age) {
        return tagOptionRepository.findOptionIdByGenderAge(category, gender, age);
    }

    public List<Long> findTopSalesCountOfColorAndWheel(String category, Gender gender, int age) {
        return tagOptionRepository.findColorOrWheelIdByGenderAge(category, gender, age);
    }
}
