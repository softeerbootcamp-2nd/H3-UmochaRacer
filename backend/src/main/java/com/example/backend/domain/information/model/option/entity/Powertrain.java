package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("POWERTRAIN")
@Getter
public class Powertrain {
    @Id
    private Long id;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private Long detailId;
    private String comment;

    public Powertrain(String name, String imageSrc, int price, Long detailId, String comment) {
        this.baseInfo = new BaseInfo(name, imageSrc, price);
        this.detailId = detailId;
        this.comment = comment;
    }
}
