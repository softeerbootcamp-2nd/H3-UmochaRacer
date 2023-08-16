package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CarInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@DisplayName("Exterior Color Service")
class ExteriorColorServiceTest extends AbstractStrategyTest {
    @InjectMocks
    private ExteriorColorService service;

    @Test
    @Override
    void findAllByStrategy() {
        ExteriorColor exteriorColor = new ExteriorColor(1L, "colorCode", "크리미 화이트 펄", "src", 100000, "하얀색은 언제나 인기많아요");

        CarInformationResponse responseDto = CarInformationResponse.builder()
                .id(1L)
                .price(100000)
                .name("크리미 화이트 펄")
                .imageSrc("src")
                .build();

        when(exteriorColorRepository.findAllLimit()).thenReturn(List.of(exteriorColor));
        when(informationMapper.map(exteriorColor)).thenReturn(responseDto);

        List<CommonResponse> result = service.findAll();

        List<CommonResponse> expected = new ArrayList<>();
        expected.add(responseDto);

        assertThat(result).isEqualTo(expected);
        assertThat(result).hasSize(1);
    }
}