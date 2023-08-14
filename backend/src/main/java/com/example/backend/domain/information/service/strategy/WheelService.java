package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.Wheel;
import com.example.backend.domain.information.model.option.repository.WheelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class WheelService implements InformationStrategy {
    private final WheelRepository wheelRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<Wheel> all = (List<Wheel>) wheelRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.WHEEL;
    }

    @Override
    public CommentResponse findCommentById(long id) {
        String comment = wheelRepository.findWheelCommentById(id);
        if (comment == null) throw new RestApiException(ResultCode.NO_COMMENT_EXIST_FOR_ID);
        return CommentResponse.builder()
                .comment(comment)
                .build();
    }

    @Override
    public Long findDetailId(long id) {
        return wheelRepository.findDetailIdById(id);
    }
}
