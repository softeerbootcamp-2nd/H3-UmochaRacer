package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("ADDITIONAL_OPTION")
public class AdditionalOption {
    @Id
    private Long id;
    private AggregateReference<AdditionalOption, Long> topOptionId;
    private AggregateReference<Parts, Long> partsId;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String detail;
}
