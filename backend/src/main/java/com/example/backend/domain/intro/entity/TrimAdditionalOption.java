package com.example.backend.domain.intro.entity;

import com.example.backend.domain.information.model.car.entity.Trim;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.annotation.Transient;
import org.springframework.data.relational.core.mapping.Table;

@Table("Trim_additional_option")
public class TrimAdditionalOption {
    private Long id;
    private Long trimId;
    private Long additionalOptionId;

    @Transient
    private Trim trim;
    @Transient
    private AdditionalOption additionalOption;

    public TrimAdditionalOption(Long id, Long trimId, Long additionalOptionId, Trim trim, AdditionalOption additionalOption) {
        this.id = id;
        this.trimId = trimId;
        this.additionalOptionId = additionalOptionId;
        this.trim = trim;
        this.additionalOption = additionalOption;
    }

    public String getTrimName() {
        return this.trim.getBaseInfo().getName();
    }

    public AdditionalOption getAdditionalOption() {
        return this.additionalOption;
    }
}
