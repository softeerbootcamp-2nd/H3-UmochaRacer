package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("ADDITIONAL_OPTION")
public class AdditionalOption {
    @Id
    private Long id;
    @MappedCollection(keyColumn = "id")
    private List<AdditionalOption> topOptionId;
    @MappedCollection(keyColumn = "id")
    private List<Parts> partsId;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private Type type;
    private String detail;

    enum Type {
        BASIC, WHEEL, ADDITIONAL;
    }
}
