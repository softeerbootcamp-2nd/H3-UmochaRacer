package com.example.backend.domain.information.mapper;

import com.example.backend.domain.information.dto.CarInformationResponse;
import com.example.backend.domain.information.dto.ColorInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.OptionInformationResponse;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import com.example.backend.domain.information.model.option.entity.Bodytype;
import com.example.backend.domain.information.model.option.entity.DrivingSystem;
import com.example.backend.domain.information.model.option.entity.Powertrain;

public class InformationMapper {
    private InformationMapper() {
    }

    public static CommonResponse map(ExteriorColor exteriorColor) {
        return ColorInformationResponse.builder()
                .id(exteriorColor.getId())
                .name(exteriorColor.getBaseInfo().getName())
                .imageSrc(exteriorColor.getBaseInfo().getImageSrc())
                .price(exteriorColor.getBaseInfo().getPrice())
                .colorCode(exteriorColor.getColorCode())
                .build();
    }

    public static CommonResponse map(InteriorColor interiorColor) {
        return ColorInformationResponse.builder()
                .id(interiorColor.getId())
                .name(interiorColor.getBaseInfo().getName())
                .imageSrc(interiorColor.getBaseInfo().getImageSrc())
                .price(interiorColor.getBaseInfo().getPrice())
                .iconSrc(interiorColor.getIconSrc())
                .build();
    }

    public static CommonResponse map(Bodytype bodytype) {
        return CarInformationResponse.builder()
                .id(bodytype.getId())
                .imageSrc(bodytype.getBaseInfo().getImageSrc())
                .name(bodytype.getBaseInfo().getName())
                .price(bodytype.getBaseInfo().getPrice())
                .build();
    }

    public static CommonResponse map(DrivingSystem drivingSystem) {
        return CarInformationResponse.builder()
                .id(drivingSystem.getId())
                .imageSrc(drivingSystem.getBaseInfo().getImageSrc())
                .name(drivingSystem.getBaseInfo().getName())
                .price(drivingSystem.getBaseInfo().getPrice())
                .build();
    }

    public static CommonResponse map(Powertrain powertrain) {
        return CarInformationResponse.builder()
                .id(powertrain.getId())
                .imageSrc(powertrain.getBaseInfo().getImageSrc())
                .name(powertrain.getBaseInfo().getName())
                .price(powertrain.getBaseInfo().getPrice())
                .build();
    }

    public static CommonResponse map(AdditionalOption additionalOption) {
        return OptionInformationResponse.builder()
                .id(additionalOption.getId())
                .name(additionalOption.getBaseInfo().getName())
                .imageSrc(additionalOption.getBaseInfo().getImageSrc())
                .price(additionalOption.getBaseInfo().getPrice())
                .partsSrc(additionalOption.getPartsSrc())
                .build();
    }
}
