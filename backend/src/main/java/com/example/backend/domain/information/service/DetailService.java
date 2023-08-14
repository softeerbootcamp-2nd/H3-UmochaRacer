package com.example.backend.domain.information.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.DetailResponse;
import com.example.backend.domain.information.model.option.entity.Detail;
import com.example.backend.domain.information.model.option.repository.DetailRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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
}
