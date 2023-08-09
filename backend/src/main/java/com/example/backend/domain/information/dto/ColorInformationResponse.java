package com.example.backend.domain.information.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class ColorInformationResponse extends CommonResponse {
    private String colorCode;
    private String iconSrc;

    @Builder
    public ColorInformationResponse(long id, String name, String imageSrc, int price, String colorCode, String iconSrc) {
        this.id = id;
        this.name = name;
        this.imageSrc = imageSrc;
        this.price = price;
        this.colorCode = colorCode;
        this.iconSrc = iconSrc;
    }
}
