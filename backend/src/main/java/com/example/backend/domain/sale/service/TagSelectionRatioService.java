package com.example.backend.domain.sale.service;

import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.dto.TagRatioRequest;
import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.repository.TagRatioTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TagSelectionRatioService {
    private final TagRatioTemplateRepository tagRatioTemplateRepository;

    public List<SalesSummaryResponse> getSelectionRatio(TagRatioRequest request) {
        List<Long> tagList = getRelatedTagList(request.getTagList(), request.getCategory(), request.getOptionId());
        List<SalesSummaryResponse> result = new ArrayList<>();
        for(Long tagId: tagList) {
            List<SalesSummary> optionCount = getOptionSelectionRatioWithTag(tagId, request.getCategory(), request.getOptionId());
            int ratio = calculateRatio(optionCount);
            result.add(new SalesSummaryResponse(tagId, ratio));
        }
        return result;
    }

    private int calculateRatio(List<SalesSummary> optionCount) {
        return (int)(100 * optionCount.get(0).getSelectionCount() / optionCount.get(1).getSelectionCount());
    }

    private List<SalesSummary> getOptionSelectionRatioWithTag(Long tagId, String category, Long optionId) {
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
