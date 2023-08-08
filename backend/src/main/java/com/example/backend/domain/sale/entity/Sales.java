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
    private AggregateReference<Model, Long> modelId;
    private AggregateReference<ExteriorColor, Long> exteriorColorId;
    private AggregateReference<InteriorColor, Long> interioiColorId;
    private AggregateReference<Tag, Long> tag1;
    private AggregateReference<Tag, Long> tag2;
    private AggregateReference<Tag, Long> tag3;
    private Integer age;
    private Gender gender;
}
