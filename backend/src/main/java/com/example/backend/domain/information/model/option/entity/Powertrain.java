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
}
