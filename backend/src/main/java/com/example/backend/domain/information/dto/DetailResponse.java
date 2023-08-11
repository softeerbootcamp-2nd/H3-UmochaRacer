package com.example.backend.domain.information.dto;

import com.example.backend.domain.information.model.option.entity.Detail;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class DetailResponse {
    private String title;
    private String description;
    private String info;
    private String imageSrc;

    public DetailResponse(Detail detail) {
        this.title = detail.getTitle();
        this.description = detail.getDescription();
        this.info = detail.getInfo();
        this.imageSrc = detail.getImageSrc();
    }
}
