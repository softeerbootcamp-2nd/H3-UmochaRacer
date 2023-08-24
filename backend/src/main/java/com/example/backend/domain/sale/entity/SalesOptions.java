package com.example.backend.domain.sale.entity;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Table;

@Table("SALES_OPTIONS")
public class SalesOptions {
    @Id
    private Long id;
    private AggregateReference<Sales, Long> salesId;
    private AggregateReference<AdditionalOption, Long> optionId;
}
