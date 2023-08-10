package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("INTERIOR_COLOR")
@Getter
public class InteriorColor {
    @Id
    private Long id;
    private ExteriorColor exteriorColorId;
    private String iconSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private String comment;

    @Builder
    public InteriorColor(Long id, ExteriorColor exteriorColorId, String iconSrc, String name, String imageSrc, int price, String comment) {
        this.id = id;
        this.exteriorColorId = exteriorColorId;
        this.iconSrc = iconSrc;
        this.baseInfo = new BaseInfo(name, imageSrc, price);
        this.comment = comment;
    }
}
