package com.example.backend.domain.intro.service;

import com.example.backend.domain.intro.dto.IntroResponse;
import com.example.backend.domain.intro.dto.SimpleIntroResponse;
import com.example.backend.domain.intro.mapper.IntroSourceMapper;
import com.example.backend.domain.intro.entity.TrimExterior;
import com.example.backend.domain.intro.entity.TrimInterior;
import com.example.backend.domain.intro.repository.TrimExteriorRepository;
import com.example.backend.domain.intro.repository.TrimInteriorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ColorService {
    private final TrimExteriorRepository trimExteriorRepository;
    private final TrimInteriorRepository trimInteriorRepository;
    private final IntroSourceMapper introSourceMapper;

    public List<IntroResponse> returnExColorByEachTrim() {
        List<TrimExterior> targets = trimExteriorRepository.findAll();

        Map<String, List<SimpleIntroResponse>> results = new HashMap<>();
        for (TrimExterior target : targets) {
            List<SimpleIntroResponse> trimList = results.getOrDefault(target.getTrimName(), new ArrayList<>());
            SimpleIntroResponse toDto = introSourceMapper.map(target.getExteriorColor());
            trimList.add(toDto);
            results.put(target.getTrimName(), trimList);
        }

        return introSourceMapper.mapToResponse(results);
    }

    public List<IntroResponse> returnInColorByEachTrim() {
        List<TrimInterior> targets = trimInteriorRepository.findAll();

        Map<String, List<SimpleIntroResponse>> results = new HashMap<>();
        for (TrimInterior target : targets) {
            List<SimpleIntroResponse> trimList = results.getOrDefault(target.getTrimName(), new ArrayList<>());
            SimpleIntroResponse toDto = introSourceMapper.map(target.getInteriorColor());
            trimList.add(toDto);
            results.put(target.getTrimName(), trimList);
        }

        return introSourceMapper.mapToResponse(results);
    }
}
