package com.example.backend.domain.sale.entity;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("SALES_OPTIONS")
public class SalesOptions {
    @Id
    private Long id;
    @MappedCollection(keyColumn = "id")
    private List<Sales> salesId;
    @MappedCollection(keyColumn = "id")
    private List<AdditionalOption> optionId;
}
