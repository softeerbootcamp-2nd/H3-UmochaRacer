package com.example.backend.domain.Information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("ADDITIONAL_OPTION")
public class AdditionalOption {
    @Id
    private Long id;
    AggregateReference<AdditionalOption, Long> topOptionId;
    AggregateReference<Parts, Long> partsId;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String detail;
}
