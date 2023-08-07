package com.example.backend.domain.sale.entity;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Table;

@Table("SALES_OPTION")
public class SalesOption {
    @Id
    private Long id;
    AggregateReference<Sales,Long> salesId;
    AggregateReference<AdditionalOption, Long> optionId;
}
