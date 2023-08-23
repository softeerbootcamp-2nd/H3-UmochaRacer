package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.information.dto.CommentResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.repository.DrivingSystemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DrivingSystemService implements InformationStrategy {
    private final DrivingSystemRepository drivingSystemRepository;
    private final InformationMapper informationMapper;

    @Override
    public List<CommonResponse> findAll() {
        List<DrivingSystem> all = (List<DrivingSystem>) drivingSystemRepository.findAll();
        return all.stream().map(informationMapper::map).collect(Collectors.toList());
    }

    @Override
    public CommonResponse findInformationById(long id) {
        DrivingSystem target = drivingSystemRepository.findById(id)
                .orElseThrow(() -> new RestApiException(ResultCode.NO_CAR_INFORMATION_WITH_ID));
        return informationMapper.map(target);
    }

    @Override
    public StrategyName getStrategyName() {
        return StrategyName.DRIVING_SYSTEM;
    }

    @Override
    public CommentResponse findCommentById(long id) {
        String comment = drivingSystemRepository.findDrivingSystemCommentById(id)
                .orElseThrow(() -> new RestApiException(ResultCode.NO_COMMENT_EXIST_FOR_ID));
        return new CommentResponse(comment);
    }

    @Override
    public Long findDetailId(long id) {
        return drivingSystemRepository.findDetailIdById(id)
                .orElseThrow(() -> new RestApiException(ResultCode.NO_CAR_INFORMATION_WITH_ID));
    }
}
