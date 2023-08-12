package com.example.backend.domain.information.service;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ErrorCode;
import com.example.backend.domain.information.dto.IntroResponse;
import com.example.backend.domain.information.dto.SimpleColorResponse;
import com.example.backend.domain.information.mapper.IntroSourceMapper;
import com.example.backend.domain.information.model.car.entity.TrimAdditionalOption;
import com.example.backend.domain.information.model.car.repository.TrimAdditionalOptionRepository;
import com.example.backend.domain.information.model.option.repository.AdditionalOptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OptionInformationService {
    private final AdditionalOptionRepository optionRepository;
    private final IntroSourceMapper introSourceMapper;
    private final TrimAdditionalOptionRepository trimOptionRepository;


    public IntroResponse findBy(Long trimId, String category, int page, int size) {
        if (page == -1) throw new RestApiException(ErrorCode.PAGE_NOT_FOUND);
        if (size == -1) throw new RestApiException(ErrorCode.PAGE_SIZE_NOT_FOUND);

        PageRequest pageRequest = PageRequest.of(page, size);
//        if(category.isBlank()) return findWholeOptions(pageRequest);

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

        List<SimpleColorResponse> results = targets.stream()
                .map(TrimAdditionalOption::getAdditionalOption)
                .map(introSourceMapper::map)
                .collect(Collectors.toList());

        try{
            String trimName = targets.get(0).getTrimName();
            return new IntroResponse(trimName, results);
        }catch (IndexOutOfBoundsException e) {
            throw new RestApiException(ErrorCode.END_PAGE);
        }
    }
}
