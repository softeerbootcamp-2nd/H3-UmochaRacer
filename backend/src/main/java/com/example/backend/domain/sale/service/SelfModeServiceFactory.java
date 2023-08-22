package com.example.backend.domain.sale.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.global.utils.StringUtils;
import com.example.backend.domain.sale.dto.SalesSummaryResponse;
import com.example.backend.domain.sale.entity.SalesSummary;
import com.example.backend.domain.sale.mapper.SummaryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SelfModeServiceFactory {
    private final VehicleTypeSaleRatioServiceImpl saleRatioService;
    private final OptionSaleRatioServiceImpl optionSaleRatioService;
    private final VehicleSpecificationSaleRatioServiceImpl vehicleSpecificationSaleRatioServiceImpl;
    private final SummaryMapper summaryMapper;

    public List<SalesSummaryResponse> getSelectionRatio(String target) {
        String columnId = StringUtils.transUriToColumnId(target);
        List<SalesSummary> saleRatio = saleRatioService.findSaleRatio(columnId);
        return mapToResponse(saleRatio);
    }

    public List<SalesSummaryResponse> getVehicleSpecificationSaleRatio(String target) {
        String columnId = StringUtils.transUriToColumnId(target);
        List<SalesSummary> saleRatio = vehicleSpecificationSaleRatioServiceImpl.findSaleRatio(columnId);
        return mapToResponse(saleRatio);
    }

    public List<SalesSummaryResponse> getOptionSelectionRatio(String category) {
        List<SalesSummary> saleRatio = optionSaleRatioService.findSaleRatio(category);
        return mapToResponse(saleRatio);
    }

    private List<SalesSummaryResponse> mapToResponse(List<SalesSummary> saleSummaries) {
        if (saleSummaries.isEmpty()) throw new RestApiException(ResultCode.SALES_NOT_FOUND);
        return summaryMapper.map(saleSummaries);
    }

}
