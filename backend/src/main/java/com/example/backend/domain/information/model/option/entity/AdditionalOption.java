package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.Getter;
import org.springframework.data.annotation.Id;
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
    private String flag;
    private String category;
    private String detail;

    public enum Flag {
        BASIC, WHEEL, ADDITIONAL;

        @Override
        public String toString() {
            return super.toString();
        }
    }

    public enum Category {
        PERFORMANCE("성능"), AI_SAFETY("지능형 안전 기술"),
        SAFETY("안전"), EXTERIOR("외관"), INTERIOR("내장"),
        SEAT("시트"), CONVENIENCE("편의"), MULTIMEDIA("멀티미디어"),
        SYSTEM("시스템"), TEMPERATURE("온도 관리"), OUTER_DEVICE("외부 장치"),
        INNER_DEVICE("내부 장치");

        private final String kor;

        Category(String kor) {
            this.kor = kor;
        }

        @Override
        public String toString() {
            return super.toString();
        }
    }
}
