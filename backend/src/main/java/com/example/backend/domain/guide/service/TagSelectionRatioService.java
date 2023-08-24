package com.example.backend.domain.guide.service;

import com.example.backend.domain.guide.dto.TagSelectionRationResponse;

public interface TagSelectionRatioService {
    TagSelectionRationResponse findSelectionRatio(int tagId);
}
