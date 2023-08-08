package com.example.backend.domain.cardb.entity;

import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Table("CARDB")
public class Cardb {
    @Id
    private Long id;
    private String keyword;
    private String description;
    private String imageSrc;

    public Cardb(String keyword, String description, String imageSrc) {
        this.keyword = keyword;
        this.description = description;
        this.imageSrc = imageSrc;
    }
}
