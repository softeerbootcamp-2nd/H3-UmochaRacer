package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.entity.Powertrain;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("MODEL")
public class Model {
    @Id
    private Long id;
    @MappedCollection(keyColumn = "id")
    private List<Trim> trimId;
    @MappedCollection(keyColumn = "id")
    private List<Powertrain> powertrainId;
    @MappedCollection(keyColumn = "id")
    private List<Bodytype> bodytypeId;
    @MappedCollection(keyColumn = "id")
    private List<DrivingSystem> drivingSystemId;
    private Integer price;
}
