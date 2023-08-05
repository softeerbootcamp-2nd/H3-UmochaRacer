package com.example.backend.domain.cardb.dto;

import com.example.backend.domain.cardb.entity.Cardb;
import lombok.Getter;

@Getter
public class CardbResponseDto {
    private String keyword;
    private String description;
    private String imageSrc;

    public CardbResponseDto() {}

    public CardbResponseDto(Cardb cardb) {
        this.keyword = cardb.getKeyword();
        this.description = cardb.getDescription();
        this.imageSrc = cardb.getImageSrc();
    }
}
