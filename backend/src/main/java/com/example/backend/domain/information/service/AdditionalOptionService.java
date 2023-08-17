package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import com.example.backend.domain.information.model.option.repository.AdditionalOptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdditionalOptionService {
    private final AdditionalOptionRepository repository;
    private final InformationMapper informationMapper;

    public List<CommonResponse> getByCategory(String category) {
        List<AdditionalOption> all = repository.findAllByCategoryAndTopOptionIdIsNull(category.toUpperCase());
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    public List<Long> findDetailId(long id) {
        return repository.findDetailIdById(id);
    }
}
