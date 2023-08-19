package com.example.backend.domain.information.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.car.repository.InteriorColorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class InteriorColorService {
    private final InteriorColorRepository interiorColorRepository;
    private final InformationMapper informationMapper;

    public List<CommonResponse> findAll(long exteriorColorId) {
        List<InteriorColor> all = interiorColorRepository.findAllByExteriorColorId(exteriorColorId);
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    public CommonResponse findInformationById(long id) {
        Optional<InteriorColor> target = interiorColorRepository.findById(id);
        if (target.isEmpty()) throw new RestApiException(ResultCode.NO_CAR_INFORMATION_WITH_ID);
        return informationMapper.map(target.get());
    }

    public CommentResponse findCommentById(long id) {
        String comment = interiorColorRepository.findInteriorColorCommentById(id);
        if (comment == null) throw new RestApiException(ResultCode.NO_COMMENT_EXIST_FOR_ID);
        return CommentResponse.builder()
                .comment(comment)
                .build();
    }
}
