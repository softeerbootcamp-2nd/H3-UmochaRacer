package com.example.backend.domain.cardb.service;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.entity.Cardb;
import com.example.backend.domain.cardb.repository.CardbRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CardbService {
    private final CardbRepository repository;

    public CardbResponseDto getDescriptionByKeyword(String keyword) throws ClassNotFoundException {
        Optional<Cardb> target = repository.findByKeyword(keyword);
        if(target.isEmpty()) throw new ClassNotFoundException();
        return new CardbResponseDto(target.get());
    }
}
