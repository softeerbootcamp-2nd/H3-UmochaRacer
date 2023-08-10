package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.mapper.IntroSourceMapper;
import com.example.backend.domain.information.model.car.entity.TrimExterior;
import com.example.backend.domain.information.model.car.repository.InteriorColorRepository;
import com.example.backend.domain.information.model.car.repository.TrimExteriorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ColorService {
    private final TrimExteriorRepository trimExteriorRepository;
    private final InteriorColorRepository interiorColorRepository;
    private final IntroSourceMapper introSourceMapper;

    public List<IntroResponse> returnExColorByEachTrim() {
        List<TrimExterior> targets = trimExteriorRepository.findAll();

        HashMap<String, List<CommonResponse>> results = new HashMap<>();
        for (TrimExterior target : targets) {
            List<CommonResponse> trimList = results.getOrDefault(target.getTrimName(), new ArrayList<>());
            CommonResponse toDto = introSourceMapper.map(target.getExteriorColor());
            trimList.add(toDto);
            results.put(target.getTrimName(), trimList);
        }

        return introSourceMapper.map(results);
    }
}
