package com.example.backend.domain.information.model.option.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("DETAIL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Detail {
    @Id
    private Long id;
    private String title;
    private String description;
    private String info;
    private String imageSrc;
}
