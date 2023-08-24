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
    public List<Long> findBaseOptionByTag(String category, List<Long> tagIds) {
        for(Long tagId: tagIds) {
            List<Long> optionList = tagOptionRepository.findOptionIdByTagId(category, tagId);
            if(optionList.size() != 0)
                return optionList;
        }
        return new ArrayList<>();
    }

    @Override
    public List<Long> findAdditionalOptionByTag(String category, List<Long> tagIds) {
        List<Long> result = new ArrayList<>();
        for(Long tagId: tagIds) {
            result.addAll(tagOptionRepository.findOptionIdByTagId(category, tagId));
        }
        return result;
    }

    @Override
    public List<Long> findTopSalesCount(String category, Gender gender, int age) {
        return tagOptionRepository.findOptionIdByGenderAge(category, gender, age);
    }

    public List<Long> findTopSalesCountOfColor(String category, Gender gender, int age) {
        return tagOptionRepository.findColorIdByGenderAge(category, gender, age);
    }

    public List<Long> findTopSalesCountOfWheel(Gender gender, int age) {
        return tagOptionRepository.findWheelIdByGenderAge(gender, age);
    }
}
