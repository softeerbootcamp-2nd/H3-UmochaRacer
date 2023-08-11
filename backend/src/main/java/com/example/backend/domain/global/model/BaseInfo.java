package com.example.backend.domain.global.model;

import lombok.Getter;

@Getter
public class BaseInfo {
    private String name;
    private String imageSrc;
    private Integer price;

    public BaseInfo(String name, String imageSrc, Integer price) {
        this.name = name;
        this.imageSrc = imageSrc;
        this.price = price;
    }
}
