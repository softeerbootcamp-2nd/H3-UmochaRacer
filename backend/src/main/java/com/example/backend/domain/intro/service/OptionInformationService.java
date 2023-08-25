package com.example.backend.domain.intro.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import com.example.backend.domain.intro.dto.IntroResponse;
import com.example.backend.domain.intro.dto.SimpleIntroResponse;
import com.example.backend.domain.intro.mapper.IntroSourceMapper;
import com.example.backend.domain.intro.entity.TrimAdditionalOption;
import com.example.backend.domain.intro.repository.TrimAdditionalOptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OptionInformationService {
    private final IntroSourceMapper introSourceMapper;
    private final TrimAdditionalOptionRepository trimOptionRepository;


    public IntroResponse findBy(Long trimId, String category, int page, int size) {
        if (page < 0) throw new RestApiException(ResultCode.PAGE_NOT_FOUND);
        if (size <= 0) throw new RestApiException(ResultCode.PAGE_SIZE_ERROR);

        PageRequest pageRequest = PageRequest.of(page, size);

        return findAllByCategory(trimId, category, pageRequest);
    }

    private IntroResponse findAllByCategory(Long trimId, String category, PageRequest pageRequest) {
        // Category에 없는 단어일 경우 exception 날아가도록 validation
        List<TrimAdditionalOption> targets = trimOptionRepository.findAllByCategoryOrderByIdWithPaging(
                trimId,
                category.toUpperCase(),
                pageRequest.getPageSize(),
                pageRequest.getOffset(),
                pageRequest
        );

        List<SimpleIntroResponse> results = targets.stream()
                .map(TrimAdditionalOption::getAdditionalOption)
                .map(introSourceMapper::map)
                .collect(Collectors.toList());

        try{
            String trimName = targets.get(0).getTrimName();
            return new IntroResponse(trimName, results);
        }catch (IndexOutOfBoundsException e) {
            throw new RestApiException(ResultCode.END_PAGE);
        }
    }
}
