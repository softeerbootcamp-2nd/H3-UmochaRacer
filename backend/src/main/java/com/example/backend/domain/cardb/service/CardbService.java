package com.example.backend.domain.cardb.service;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.entity.Cardb;
import com.example.backend.domain.cardb.repository.CardbRepository;
import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CardbService {
    private final CardbRepository repository;

    public CardbResponseDto getDescriptionByKeyword(String keyword) throws RestApiException {
        Cardb target = repository.findByKeyword(keyword)
                .orElseThrow(() -> new RestApiException(ResultCode.NO_KEYWORD_EXIST));
        return new CardbResponseDto(target);
    }
}
