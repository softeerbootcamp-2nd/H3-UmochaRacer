package com.example.backend.domain.guide.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.guide.dto.FinalEstimateResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CarRecommendationServiceImpl implements CarRecommendationService {
    private final OptionRecommendationHandlerImpl optionRecommendationHandler;

    @Override
    public FinalEstimateResponse estimate(EstimateRequest estimate) {
//        Field[] fields = FinalEstimateResponse.class.getDeclaredFields();
//        for (Field field : fields)
        return FinalEstimateResponse.builder()
                .powertrainId(getRecommendOptionList("powertrain", estimate).get(0))
                .bodytypeId(getRecommendOptionList("bodytype", estimate).get(0))
                .drivingSystemId(getRecommendOptionList("driving_system", estimate).get(0))
                .exteriorColorId(getRecommendOptionList("exterior_color", estimate).get(0))
                .interiorColorId(getRecommendOptionList("interior_color", estimate).get(0))
                .wheelId(getRecommendOptionList("wheel", estimate).get(0))
                .additionalOptionId(getRecommendOptionList("additional_option", estimate))
                .build();
    }

    private List<Long> getRecommendOptionList(String field, EstimateRequest estimate) {
        if (field.equals("wheel"))
            return getRecommendWheelList(field, estimate);
        if (field.contains("color"))
            return optionRecommendationHandler.findTopSalesCountOfColor(field, estimate.getGender(), estimate.getAge());
        return getRecommendBaseOptionList(field, estimate);
    }

    private List<Long> getRecommendWheelList(String field, EstimateRequest estimate) {
        List<Long> tagList = estimate.getTagList();
        if(tagList.contains(5L) && (tagList.contains(1L) || tagList.contains(10L)))
            return List.of(4L);
        if(tagList.contains(5L))
            return optionRecommendationHandler.findTopSalesCountOfWheel(estimate.getGender(), estimate.getAge());
        return List.of(1L);
    }


    private List<Long> getRecommendBaseOptionList(String field, EstimateRequest estimate) {
        List<Long> optionList = optionRecommendationHandler.findByTag(field, estimate.getTagList());
        if (optionList.size() == 0 && !field.contains("option"))
            return optionRecommendationHandler.findTopSalesCount(field, estimate.getGender(), estimate.getAge());
        return optionList;
    }

}
