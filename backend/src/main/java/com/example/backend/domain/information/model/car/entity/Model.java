package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("MODEL")
@Getter
public class Model {
    @Id
    private Long id;
    private Trim trimId;
    private Powertrain powertrainId;
    private Bodytype bodytypeId;
    private DrivingSystem drivingSystemId;
    private Integer price;
}
