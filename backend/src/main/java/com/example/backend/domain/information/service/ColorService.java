package com.example.backend.domain.information.service;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.mapper.IntroSourceMapper;
import com.example.backend.domain.information.model.car.entity.TrimExterior;
import com.example.backend.domain.information.model.car.entity.TrimInterior;
import com.example.backend.domain.information.model.car.repository.TrimExteriorRepository;
import com.example.backend.domain.information.model.car.repository.TrimInteriorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ColorService {
    private final TrimExteriorRepository trimExteriorRepository;
    private final TrimInteriorRepository trimInteriorRepository;
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

        return introSourceMapper.mapToResponse(results);
    }

    public List<IntroResponse> returnInColorByEachTrim() {
        List<TrimInterior> targets = (List<TrimInterior>) trimInteriorRepository.findAll();

        HashMap<String, List<CommonResponse>> results = new HashMap<>();
        for (TrimInterior target : targets) {
            List<CommonResponse> trimList = results.getOrDefault(target.getTrimName(), new ArrayList<>());
            CommonResponse toDto = introSourceMapper.map(target.getInteriorColor());
            trimList.add(toDto);
            results.put(target.getTrimName(), trimList);
        }

        return introSourceMapper.mapToResponse(results);
    }
}
