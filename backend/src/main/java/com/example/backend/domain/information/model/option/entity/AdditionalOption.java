package com.example.backend.domain.information.model.option.entity;

import com.example.backend.domain.global.model.BaseInfo;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.Table;

@Table("ADDITIONAL_OPTION")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AdditionalOption {
    @Id
    private Long id;
    private Long topOptionId;
    private String partsSrc;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;
    private String flag;
    private String category;
    private Long detailId;

    public enum Flag {
        BASIC, ADDITIONAL;

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

    @Builder
    public AdditionalOption(String name, String imageSrc, int price, String category) {
        this.baseInfo = new BaseInfo(name, imageSrc, price);
        this.category = category;
    }

    public String getName() {
        return this.baseInfo.getName();
    }

    public String getImageSrc() {
        return this.baseInfo.getImageSrc();
    }
}
