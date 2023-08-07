package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("INTERIOR_COLOR")
public class InteriorColor {
    @Id
    private Long id;
    AggregateReference<ExteriorColor, Long> exteriorColorId;
    private String iconSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private String comment;
}
