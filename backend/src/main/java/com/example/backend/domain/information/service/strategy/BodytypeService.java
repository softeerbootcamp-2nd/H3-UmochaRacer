package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.repository.BodytypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class BodytypeService implements InformationStrategy {
    private final BodytypeRepository bodytypeRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<Bodytype> all = (List<Bodytype>) bodytypeRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public CommonResponse findInformationById(long id) {
        Optional<Bodytype> target = bodytypeRepository.findById(id);
        if (target.isEmpty()) throw new RestApiException(ResultCode.NO_CAR_INFORMATION_WITH_ID);
        return informationMapper.map(target.get());
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.BODYTYPE;
    }

    @Override
    public CommentResponse findCommentById(long id) {
        String comment = bodytypeRepository.findBodytypeCommentById(id)
                .orElseThrow(() -> new RestApiException(ResultCode.NO_COMMENT_EXIST_FOR_ID));
        return new CommentResponse(comment);
    }

    @Override
    public Long findDetailId(long id) {
        return bodytypeRepository.findDetailIdById(id);
    }

}
