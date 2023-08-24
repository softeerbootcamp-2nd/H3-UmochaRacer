package com.example.backend.domain.information.dto;

import lombok.Getter;

@Getter
public abstract class CommonResponse {
    protected long id;
    protected String name;
    protected String imageSrc;
    protected int price;
}
