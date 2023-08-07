package com.example.backend.domain.Information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("EXTERIOR_COLOR")
public class ExteriorColor {
    @Id
    private Long id;
    private String colorCode;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String comment;
}
