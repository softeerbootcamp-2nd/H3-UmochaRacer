package com.example.backend.domain.intro.entity;

import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.Trim;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.relational.core.mapping.Table;

@Table("TRIM_EXTERIOR")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class TrimExterior {
    @Id
    private Long id;
    private Long trimId;
    private Long exteriorColorId;

    @Transient
    private Trim trim;
    @Transient
    private ExteriorColor exteriorColor;

    public TrimExterior(Long id, Long trimId, Long exteriorColorId, Trim trim, ExteriorColor exteriorColor) {
        this.id = id;
        this.trimId = trimId;
        this.exteriorColorId = exteriorColorId;
        this.trim = trim;
        this.exteriorColor = exteriorColor;
    }

    public String getTrimName() {
        return trim.getBaseInfo().getName();
    }

    public ExteriorColor getExteriorColor() {
        return this.exteriorColor;
    }
}