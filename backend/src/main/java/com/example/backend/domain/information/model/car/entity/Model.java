package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Table;

@Table("MODEL")
public class Model {
    @Id
    private Long id;

    private AggregateReference<Trim, Long> trimId;
    private AggregateReference<Powertrain, Long> powertrainId;
    private AggregateReference<Bodytype, Long> bodytypeId;
    private AggregateReference<DrivingSystem, Long> drivingSystemId;
    private Integer price;
}
