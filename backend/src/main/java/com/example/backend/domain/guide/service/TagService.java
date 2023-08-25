package com.example.backend.domain.guide.service;

import com.example.backend.domain.guide.dto.TagInformationResponse;
import com.example.backend.domain.guide.dto.TagListResponse;
import com.example.backend.domain.guide.entity.Tag;
import com.example.backend.domain.guide.mapper.TagInformationMapper;
import com.example.backend.domain.guide.repository.TagRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class TagService {
    private final TagRepository tagRepository;
    private final TagInformationMapper tagInformationMapper;

    public List<TagListResponse> returnAllTag() {
        List<Tag> targets = (List<Tag>) tagRepository.findAll();

        Map<String, List<TagInformationResponse>> results = new HashMap<>();
        for (Tag target : targets) {
            List<TagInformationResponse> tagList = results.getOrDefault(target.getCategory(), new ArrayList<>());
            TagInformationResponse toDto = tagInformationMapper.map(target);
            tagList.add(toDto);
            results.put(target.getCategory(), tagList);
        }
        return tagInformationMapper.mapToResponse(results);
    }
}
