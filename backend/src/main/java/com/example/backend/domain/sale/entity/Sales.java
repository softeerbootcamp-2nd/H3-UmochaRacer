package com.example.backend.domain.sale.entity;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.car.entity.Model;
import com.example.backend.domain.sale.entity.enums.Gender;
import org.springframework.data.annotation.Id;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.data.relational.core.mapping.Table;

@Table("SALES")
public class Sales {
    @Id
    private Long id;
    AggregateReference<Model, Long> modelId;
    AggregateReference<ExteriorColor, Long> exteriorColorId;
    AggregateReference<InteriorColor, Long> interioiColorId;
    AggregateReference<Tag, Long> tag1;
    AggregateReference<Tag, Long> tag2;
    AggregateReference<Tag, Long> tag3;
    private Integer age;
    private Gender gender;
}
