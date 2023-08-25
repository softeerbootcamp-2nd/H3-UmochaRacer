package com.example.backend.domain.information.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class CarInformationResponse extends CommonResponse {

    @Builder
    public CarInformationResponse(long id, String name, String imageSrc, int price) {
        this.id = id;
        this.name = name;
        this.imageSrc = imageSrc;
        this.price = price;
    }
}
