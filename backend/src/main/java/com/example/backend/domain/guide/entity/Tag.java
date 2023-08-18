package com.example.backend.domain.guide.entity;

import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("TAG")
@Getter
public class Tag {
    @Id
    private Long id;
    private String name;
    private String category;
}
