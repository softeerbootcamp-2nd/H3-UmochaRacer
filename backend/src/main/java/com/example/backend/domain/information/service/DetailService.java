package com.example.backend.domain.information.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.DetailResponse;
import com.example.backend.domain.information.model.option.entity.Detail;
import com.example.backend.domain.information.model.option.repository.DetailRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DetailService {
    private final DetailRepository repository;

    public DetailResponse getDetailById(Long id) {
        Detail target = repository.findById(id)
                .orElseThrow(() ->new RestApiException(ResultCode.NO_DETAIL_EXIST_FOR_ID));
        return new DetailResponse(target);
    }

    public List<DetailResponse> getOptionDetailById(List<Long> detailIdList) {
        List<DetailResponse> detailResponseList = new ArrayList<>();
        for (Long detailId : detailIdList) {
            Detail detail = repository.findById(detailId)
                    .orElseThrow(() -> new RestApiException(ResultCode.NO_DETAIL_EXIST_FOR_ID));
            detailResponseList.add(new DetailResponse(detail));
        }
        return detailResponseList;
    }
}
