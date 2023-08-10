package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import com.example.backend.domain.information.model.car.entity.Detail;
import lombok.Getter;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("DRIVING_SYSTEM")
@Getter
public class DrivingSystem {
    private Long id;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private Detail detailId;
    private String comment;
}
