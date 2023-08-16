package com.example.backend.domain.sale.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.global.utils.StringUtils;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.entity.SaleSummary;
import com.example.backend.domain.sale.mapper.SummaryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SelfModeService {
    private final SaleRatioServiceImpl saleRatioService;
    private final OptionSaleRatioServiceImpl optionSaleRatioService;
    private final SummaryMapper summaryMapper;

    public List<SalesSummaryResponse> getSelectionRatio(String target) {
        String columnId = StringUtils.transUriToColumnId(target);
        List<SaleSummary> saleRatio = saleRatioService.findSaleRatio(columnId);
        return mapToResponse(saleRatio);
    }

    public List<SalesSummaryResponse> getOptionSelectionRatio(String category) {
        List<SaleSummary> saleRatio = optionSaleRatioService.findSaleRatio(category);
        return mapToResponse(saleRatio);
    }

    private List<SalesSummaryResponse> mapToResponse(List<SaleSummary> saleSummaries) {
        if(saleSummaries.size() == 0) throw new RestApiException(ResultCode.SALES_NOT_FOUND);
        return summaryMapper.map(saleSummaries);
    }

}
