package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("MODEL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Model {
    @Id
    private Long id;
    private Trim trimId;
    private Powertrain powertrainId;
    private Bodytype bodytypeId;
    private DrivingSystem drivingSystemId;
    private Integer price;
}
