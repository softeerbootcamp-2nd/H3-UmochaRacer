package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("INTERIOR_COLOR")
public class InteriorColor {
    @Id
    private Long id;
    @MappedCollection(keyColumn = "id")
    private List<ExteriorColor> exteriorColorId;
    private String iconSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private String comment;
}
