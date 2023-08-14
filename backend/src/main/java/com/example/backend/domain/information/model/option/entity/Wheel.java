package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("WHEEL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Wheel {
    @Id
    private Long id;
    private Long detailId;
    private Long subWheelId;
    private String partsSrc;
    private String flag;
    private String comment;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
}
