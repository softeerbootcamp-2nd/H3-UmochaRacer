package com.example.backend.domain.sale.entity;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.car.entity.Model;
import com.example.backend.domain.sale.entity.enums.Gender;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.List;

@Table("SALES")
public class Sales {
    @Id
    private Long id;
    @MappedCollection(keyColumn = "id")
    private List<Model> modelId;
    @MappedCollection(keyColumn = "id")
    private List<ExteriorColor> exteriorColorId;
    @MappedCollection(keyColumn = "id")
    private List<InteriorColor> interiorColors;
    @MappedCollection(keyColumn = "id")
    private List<Tag> tag1;
    @MappedCollection(keyColumn = "id")
    private List<Tag> tag2;
    @MappedCollection(keyColumn = "id")
    private List<Tag> tag3;
    private Integer age;
    private Gender gender;
}
