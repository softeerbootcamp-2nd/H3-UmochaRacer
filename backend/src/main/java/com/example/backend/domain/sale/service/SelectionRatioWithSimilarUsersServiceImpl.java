package com.example.backend.domain.sale.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.dto.RatioSummaryResponse;
import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.mapper.SummaryMapper;
import com.example.backend.domain.sale.repository.SalesTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SelectionRatioWithSimilarUsersServiceImpl implements SelectionRatioWithSimilarUsersService {
    private final SalesTemplateRepository repository;
    private final SummaryMapper summaryMapper;

    @Override
    public List<RatioSummaryResponse> calculateSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest) {
        List<RatioSummary> summaries = repository.findSelectionRatioWithSimilarUsers(target, estimateRequest);
        return getSortedRatioSummaryResponses(summaries);
    }

    @Override
    public List<RatioSummaryResponse> calculateSelectionRatioWitSameAgeAndGender(String target, EstimateRequest estimateRequest) {
        List<RatioSummary> summaries = repository.findSelectionRatioWithSameAgeAndGender(target, estimateRequest);
        return getSortedRatioSummaryResponses(summaries);
    }

    @Override
    public List<RatioSummaryResponse> calculateSelectionRatioWithAdditionalOption(EstimateRequest estimateRequest) {
        List<RatioSummary> summaries = repository.findSelectionRatioOfAdditionalOption(estimateRequest);
        return getSortedRatioSummaryResponses(summaries);
    }

    private List<RatioSummaryResponse> getSortedRatioSummaryResponses(List<RatioSummary> summaries) {
        List<RatioSummaryResponse> result = summaryMapper.map(summaries);
        Collections.sort(result, (o1, o2) -> o2.getSelectionRatio() - o1.getSelectionRatio());
        return result;
    }
}
