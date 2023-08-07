package com.example.backend.domain.sale.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("TAG")
public class Tag {
    @Id
    private Long id;
    private String name;
}
