package com.example.backend.domain.information.model.car.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("TRIM")
public class Trim {
    @Id
    private Long id;
    private String name;
}
