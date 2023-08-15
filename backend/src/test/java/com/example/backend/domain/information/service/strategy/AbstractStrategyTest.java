package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.car.repository.ExteriorColorRepository;
import com.example.backend.domain.information.model.car.repository.InteriorColorRepository;
import com.example.backend.domain.information.model.option.repository.BodytypeRepository;
import com.example.backend.domain.information.model.option.repository.DrivingSystemRepository;
import com.example.backend.domain.information.model.option.repository.PowertrainRepository;
import com.example.backend.domain.information.model.option.repository.WheelRepository;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public abstract class AbstractStrategyTest {
    @Mock
    protected PowertrainRepository powertrainRepository;
    @Mock
    protected BodytypeRepository bodytypeRepository;
    @Mock
    protected DrivingSystemRepository drivingSystemRepository;
    @Mock
    protected ExteriorColorRepository exteriorColorRepository;
    @Mock
    protected WheelRepository wheelRepository;

    @Mock
    protected InformationMapper informationMapper;

    abstract void findAllByStrategy();
}
