package com.example.backend.domain.cardb.service;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.entity.Cardb;
import com.example.backend.domain.cardb.repository.CardbRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.only;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CardbServiceTest {
    @Mock
    private CardbRepository cardbRepository;
    @InjectMocks
    private CardbService cardbService;
    private Cardb sample;

    @BeforeEach
    void setUp() {
        sample = new Cardb("디젤2.2", "강력한 엔진", "s3/cardb/abcdef.png");
    }

    @Test
    @DisplayName("키워드에 해당하는 백카사전 정보를 반환한다")
    void shouldReturnDataWhenExist() throws Exception {
        when(cardbRepository.findByKeyword(any()))
                .thenReturn(Optional.of(sample));

        CardbResponseDto result = cardbService.getDescriptionByKeyword("디젤2.2");

        assertThat(result.getKeyword()).isEqualTo("디젤2.2");
        assertThat(result.getDescription()).isEqualTo( "강력한 엔진");
        assertThat(result.getImageSrc()).isEqualTo("s3/cardb/abcdef.png");
    }
    @Test
    @DisplayName("키워드에 해당하는 정보가 없으면 null을 반환한다.")
    void shouldReturnNullWhenDoesNotExist() throws Exception {
        when(cardbRepository.findByKeyword("디젤2.2"))
                .thenReturn(Optional.of(sample));

        CardbResponseDto result = cardbService.getDescriptionByKeyword("안녕");

    }
}