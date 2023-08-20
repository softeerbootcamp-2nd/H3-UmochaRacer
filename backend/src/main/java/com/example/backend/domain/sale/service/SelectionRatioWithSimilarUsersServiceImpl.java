package com.example.backend.domain.sale.service;

import com.example.backend.domain.guide.dto.EstimateRequest;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.entity.SalesSummary;
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
    public List<SalesSummaryResponse> calculateSelectionRatioWithSimilarUsers(String target, EstimateRequest estimateRequest) {
        List<SalesSummary> summaries = repository.findSelectionRatioWithSimilarUsers(target, estimateRequest);
        List<SalesSummaryResponse> result = summaryMapper.map(summaries);
        Collections.sort(result, (o1, o2)-> o2.getSelectionRatio() - o1.getSelectionRatio());
        return result;
    }
}
