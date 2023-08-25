package com.example.backend.domain.sale.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.global.utils.StringUtils;
import com.example.backend.domain.sale.dto.RatioSummaryResponse;
import com.example.backend.domain.sale.entity.RatioSummary;
import com.example.backend.domain.sale.mapper.SummaryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SelfModeServiceFactory {
    private final VehicleTypeSaleRatioServiceImpl saleRatioService;
    private final OptionSaleRatioServiceImpl optionSaleRatioService;
    private final VehicleSpecificationSaleRatioServiceImpl vehicleSpecificationSaleRatioServiceImpl;
    private final SummaryMapper summaryMapper;

    public List<RatioSummaryResponse> getSelectionRatio(String target) {
        String columnId = StringUtils.transUriToColumnId(target);
        List<RatioSummary> saleRatio = saleRatioService.findSaleRatio(columnId);
        return mapToResponse(saleRatio);
    }

    public List<RatioSummaryResponse> getVehicleSpecificationSaleRatio(String target) {
        String columnId = StringUtils.transUriToColumnId(target);
        List<RatioSummary> saleRatio = vehicleSpecificationSaleRatioServiceImpl.findSaleRatio(columnId);
        return mapToResponse(saleRatio);
    }

    public List<RatioSummaryResponse> getOptionSelectionRatio(String category) {
        List<RatioSummary> saleRatio = optionSaleRatioService.findSaleRatio(category);
        return mapToResponse(saleRatio);
    }

    private List<RatioSummaryResponse> mapToResponse(List<RatioSummary> saleSummaries) {
        if (saleSummaries.isEmpty()) throw new RestApiException(ResultCode.SALES_NOT_FOUND);
        List<RatioSummaryResponse> result = summaryMapper.map(saleSummaries);
        Collections.sort(result, (o1, o2) -> o2.getSelectionRatio() - o1.getSelectionRatio());
        return result;
    }

}
