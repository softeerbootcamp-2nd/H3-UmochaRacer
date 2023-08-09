package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Getter;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.annotation.Id;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.data.convert.WritingConverter;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

@Table("ADDITIONAL_OPTION")
@Getter
public class AdditionalOption {
    @Id
    private Long id;
    @MappedCollection(idColumn = "top_option_id")
    private AggregateReference<AdditionalOption,Long> topOptionId;
    private String partsSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String type;
    private String detail;

    public enum Type {
        BASIC, WHEEL, ADDITIONAL;

        @Override
        public String toString() {
            return super.toString();
        }
    }
}
