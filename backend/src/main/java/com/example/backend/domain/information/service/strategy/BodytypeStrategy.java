package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ErrorCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.repository.BodytypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class BodytypeStrategy implements InformationStrategy {
    private final BodytypeRepository bodytypeRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<Bodytype> all = (List<Bodytype>) bodytypeRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.BODYTYPE;
    }

    @Override
    public CommentResponse findCommentById(long id) {
        String comment = bodytypeRepository.findBodytypeCommentById(id);
        if (comment == null) throw new RestApiException(ErrorCode.NO_COMMENT_EXIST_FOR_ID);
        return CommentResponse.builder()
                .comment(comment)
                .build();
    }

}
