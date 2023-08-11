package com.example.backend.domain.information.model.option.entity;

import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("DETAIL")
@Getter
public class Detail {
    @Id
    private Long id;
    private String title;
    private String description;
    private String info;
    private String imageSrc;
}
