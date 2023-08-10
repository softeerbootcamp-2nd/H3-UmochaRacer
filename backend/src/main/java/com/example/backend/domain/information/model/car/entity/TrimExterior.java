package com.example.backend.domain.information.model.car.entity;

import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("TRIM_EXTERIOR")
@Getter
public class TrimExterior {
    @Id
    private Long id;
    private Trim trimId;
    private ExteriorColor exteriorColorId;
}
