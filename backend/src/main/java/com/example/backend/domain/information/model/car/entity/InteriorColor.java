package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("INTERIOR_COLOR")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class InteriorColor {
    @Id
    private Long id;
    private AggregateReference<ExteriorColor, Long> exteriorColorId;
    private String iconSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private String comment;

    @Builder
    public InteriorColor(Long id, long exteriorColorId, String iconSrc, String name, String imageSrc, int price, String comment) {
        this.id = id;
        this.iconSrc = iconSrc;
        this.baseInfo = new BaseInfo(name, imageSrc, price);
        this.comment = comment;
        this.exteriorColorId = AggregateReference.to(exteriorColorId);
    }

    public String getName() {
        return baseInfo.getName();
    }
}
