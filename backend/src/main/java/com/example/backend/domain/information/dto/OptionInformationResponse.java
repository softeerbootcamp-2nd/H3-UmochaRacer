package com.example.backend.domain.information.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OptionInformationResponse extends CommonResponse {
    // 상위 옵션이 null 값일 때만 반환
    private String partsSrc;

    @Builder
    public OptionInformationResponse(long id, String name, String imageSrc, int price, String partsSrc) {
        this.id = id;
        this.name = name;
        this.imageSrc = imageSrc;
        this.price = price;
        this.partsSrc = partsSrc;
    }
}
