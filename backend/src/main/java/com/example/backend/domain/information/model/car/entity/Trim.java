package com.example.backend.domain.information.model.car.entity;

import com.example.backend.domain.global.model.BaseInfo;
import com.example.backend.domain.intro.entity.TrimExterior;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import java.util.Set;

@Table("TRIM")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Trim {
    @Id
    private Long id;
    @Embedded(onEmpty = Embedded.OnEmpty.USE_EMPTY)
    private BaseInfo baseInfo;

    @MappedCollection(idColumn = "trim_id")
    private Set<TrimExterior> trimExteriors;

    @Builder
    public Trim(Long id, String name, String imageSrc, int price) {
        this.id = id;
        this.baseInfo = new BaseInfo(name, imageSrc, price);
    }
}
