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
        Optional<Detail> target = repository.findById(id);
        if (target.isEmpty()) throw new RestApiException(ResultCode.NO_DETAIL_EXIST_FOR_ID);
        return new DetailResponse(target.get());
    }

    public List<DetailResponse> getOptionDetailById(List<Long> detailIdList) {
        List<DetailResponse> detailResponseList = new ArrayList<>();
        for (Long detailId : detailIdList) {
            Optional<Detail> detail = repository.findById(detailId);
            if (detail.isEmpty()) throw new RestApiException(ResultCode.NO_DETAIL_EXIST_FOR_ID);
            detailResponseList.add(new DetailResponse(detail.get()));
        }
        return detailResponseList;
    }
}
