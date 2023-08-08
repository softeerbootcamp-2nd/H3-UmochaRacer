package com.example.backend.domain.information.model.option.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("PARTS")
public class Parts {
    @Id
    private Long id;
    private String name;
    private String imageSrc;
}
