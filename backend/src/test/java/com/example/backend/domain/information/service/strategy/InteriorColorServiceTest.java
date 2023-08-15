package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CarInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.car.repository.InteriorColorRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;

@DisplayName("Interior Color Service")
@ExtendWith(MockitoExtension.class)
class InteriorColorServiceTest {
    @Mock
    private InteriorColorRepository repository;
    @Mock
    private InformationMapper informationMapper;
    @InjectMocks
    private InteriorColorService service;

    @Test
    @DisplayName("내장 색상 정보를 반환한다.")
    void findAllTest() {
        InteriorColor interiorColor = new InteriorColor(1L, 1L, "iconSrc", "인조 가죽", "image src", 0, "블랙은 진리");

        CarInformationResponse responseDto = CarInformationResponse.builder()
                .id(1L)
                .price(0)
                .name("인조 가죽")
                .imageSrc("image src")
                .build();

        when(repository.findAllByExteriorColorId(anyLong())).thenReturn(List.of(interiorColor));
        when(informationMapper.map(interiorColor)).thenReturn(responseDto);

        List<CommonResponse> result = service.findAll(1L);

        List<CommonResponse> expected = new ArrayList<>();
        expected.add(responseDto);

        assertThat(result).isEqualTo(expected);
        assertThat(result).hasSize(1);
    }
}
