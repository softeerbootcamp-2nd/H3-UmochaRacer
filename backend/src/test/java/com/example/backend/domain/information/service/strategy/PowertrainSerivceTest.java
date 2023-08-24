package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CarInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@DisplayName("Powertrain Information Service")
class PowertrainSerivceTest extends AbstractStrategyTest {
    @InjectMocks
    private PowertrainService service;

    @Test
    @DisplayName("파워트레인 정보 전체 목록을 가져온다")
    @Override
    void findAllByStrategy() {
        Powertrain powertrain = new Powertrain("디젤", "amazon/url", 1000, 1L, "효율굿");
        List<Powertrain> powertrains = List.of(powertrain);

        CommonResponse responseDto = CarInformationResponse.builder()
                .id(1)
                .price(1000)
                .name("디젤")
                .imageSrc("amazon/url")
                .build();


        when(powertrainRepository.findAll()).thenReturn(powertrains);
        when(informationMapper.map(powertrain)).thenReturn(responseDto);

        List<CommonResponse> result = service.findAll();

        ArrayList<CommonResponse> expected = new ArrayList<>();
        expected.add(responseDto);

        assertThat(result).isEqualTo(expected);
        assertThat(result).hasSize(1);
    }
}