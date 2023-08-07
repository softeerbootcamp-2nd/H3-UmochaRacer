package com.example.backend.domain.Information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("DRIVING_SYSTEM")
public class DrivingSystem {
    private Long id;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_NULL)
    private BaseInfo baseInfo;
    private String detail;
    private String comment;
}
