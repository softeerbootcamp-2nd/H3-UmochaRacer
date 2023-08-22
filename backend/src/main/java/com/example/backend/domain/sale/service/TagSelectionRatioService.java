package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.dto.RatioSummaryResponse;
import com.example.backend.domain.sale.dto.TagRatioRequest;
import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.repository.TagRatioTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TagSelectionRatioService {
    private final TagRatioTemplateRepository tagRatioTemplateRepository;

    public List<RatioSummaryResponse> getSelectionRatio(TagRatioRequest request) {
        List<Long> tagList = getRelatedTagList(request.getTagList(), request.getCategory(), request.getOptionId());
        List<RatioSummaryResponse> result = new ArrayList<>();
        for(Long tagId: tagList) {
            List<RatioSummary> optionCount = getOptionSelectionRatioWithTag(tagId, request.getCategory(), request.getOptionId());
            int ratio = calculateRatio(optionCount);
            result.add(new RatioSummaryResponse(tagId, ratio));
        }
        return result;
    }

    private int calculateRatio(List<RatioSummary> optionCount) {
        return (int)(100 * optionCount.get(0).getSelectionCount() / optionCount.get(1).getSelectionCount());
    }

    private List<RatioSummary> getOptionSelectionRatioWithTag(Long tagId, String category, Long optionId) {
        if(category.contains("option"))
            return tagRatioTemplateRepository.findAdditionalOptionCount(tagId, category, optionId);
        if(category.contains("color") || category.contains("wheel"))
            return tagRatioTemplateRepository.findColorWheelOptionCount(tagId, category, optionId);
        return tagRatioTemplateRepository.findBaseOptionCount(tagId, category, optionId);
    }


    private List<Long> getRelatedTagList(List<Long> tagList, String category, Long optionId) {
        List<Long> result = new ArrayList<>();
        for(Long tagId: tagList) {
            result.addAll(tagRatioTemplateRepository.findRelatedTagListWithOption(tagId, category, optionId));
        }
        return result;
    }
}
