package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("WHEEL")
@Getter
public class Wheel {
    @Id
    private Long id;
    private Long detailId;
    private Wheel subWheelId;
    private String partsSrc;
    private String flag;
    private String category;
    private String comment;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
}
