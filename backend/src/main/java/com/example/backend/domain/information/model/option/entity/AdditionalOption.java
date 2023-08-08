package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("ADDITIONAL_OPTION")
@Getter
public class AdditionalOption {
    @Id
    private Long id;
    private AdditionalOption topOptionId;
    private String partsSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private Type type;
    private String detail;

    public enum Type {
        BASIC, WHEEL, ADDITIONAL;
    }
}
