package com.example.backend.domain.guide.mapper;

import com.example.backend.domain.guide.dto.TagInformationResponse;
import com.example.backend.domain.guide.dto.TagListResponse;
import com.example.backend.domain.guide.entity.Tag;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class TagInformationMapper {
    private TagInformationMapper() {
    }

    public TagInformationResponse map(Tag tag) {
        return new TagInformationResponse(tag.getId(), tag.getName());
    }

    public List<TagListResponse> mapToResponse(Map<String, List<TagInformationResponse>> dtos) {
        return dtos.entrySet().stream()
                .map(entry -> new TagListResponse(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }
}
