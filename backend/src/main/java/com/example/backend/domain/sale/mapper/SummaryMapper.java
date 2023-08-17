package com.example.backend.domain.sale.mapper;

import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.entity.SalesSummary;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Component
public class SummaryMapper {
    private SummaryMapper() {
    }

    public List<SalesSummaryResponse> map(List<SalesSummary> dto) {
        int size = dto.size();
        int totalCount = dto.get(size - 1).getSelectionCount();
        return IntStream.range(0, size - 1)
                .mapToObj(dto::get)
                .map(d -> calculateRatio(d, totalCount))
                .collect(Collectors.toList());
    }

    private SalesSummaryResponse calculateRatio(SalesSummary salesSummary, int totalCount) {
        // 현재 값/마지막 값 until 크기-1
        int ratio = 100 * salesSummary.getSelectionCount() / totalCount;
        return new SalesSummaryResponse(salesSummary.getId(), ratio);
    }
}
