package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("EXTERIOR_COLOR")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ExteriorColor {
    @Id
    private Long id;
    private String colorCode;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String comment;

    @Builder
    public ExteriorColor(Long id, String colorCode, String name, String imageSrc, int price, String comment) {
        this.id = id;
        this.colorCode = colorCode;
        this.baseInfo = new BaseInfo(name, imageSrc, price);
        this.comment = comment;
    }

    public String getName() {
        return this.baseInfo.getName();
    }
}
