package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("DRIVING_SYSTEM")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DrivingSystem {
    private Long id;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private Long detailId;
    private String comment;
}
