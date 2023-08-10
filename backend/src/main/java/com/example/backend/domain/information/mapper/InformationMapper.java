package com.example.backend.domain.information.mapper;

import com.example.backend.domain.information.dto.CarInformationResponse;
import com.example.backend.domain.information.dto.ColorInformationResponse;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.OptionInformationResponse;
import com.example.backend.domain.information.model.car.entity.ExteriorColor;
import com.example.backend.domain.information.model.car.entity.InteriorColor;
import com.example.backend.domain.information.model.option.entity.*;
import org.springframework.stereotype.Component;

@Component
public class InformationMapper {

    public CommonResponse map(ExteriorColor exteriorColor) {
        return ColorInformationResponse.builder()
                .id(exteriorColor.getId())
                .name(exteriorColor.getBaseInfo().getName())
                .imageSrc(exteriorColor.getBaseInfo().getImageSrc())
                .price(exteriorColor.getBaseInfo().getPrice())
                .colorCode(exteriorColor.getColorCode())
                .build();
    }

    public CommonResponse map(InteriorColor interiorColor) {
        return ColorInformationResponse.builder()
                .id(interiorColor.getId())
                .name(interiorColor.getBaseInfo().getName())
                .imageSrc(interiorColor.getBaseInfo().getImageSrc())
                .price(interiorColor.getBaseInfo().getPrice())
                .iconSrc(interiorColor.getIconSrc())
                .build();
    }

    public CommonResponse map(Bodytype bodytype) {
        return CarInformationResponse.builder()
                .id(bodytype.getId())
                .imageSrc(bodytype.getBaseInfo().getImageSrc())
                .name(bodytype.getBaseInfo().getName())
                .price(bodytype.getBaseInfo().getPrice())
                .build();
    }

    public CommonResponse map(DrivingSystem drivingSystem) {
        return CarInformationResponse.builder()
                .id(drivingSystem.getId())
                .imageSrc(drivingSystem.getBaseInfo().getImageSrc())
                .name(drivingSystem.getBaseInfo().getName())
                .price(drivingSystem.getBaseInfo().getPrice())
                .build();
    }

    public CommonResponse map(Powertrain powertrain) {
        return CarInformationResponse.builder()
                .id(powertrain.getId())
                .imageSrc(powertrain.getBaseInfo().getImageSrc())
                .name(powertrain.getBaseInfo().getName())
                .price(powertrain.getBaseInfo().getPrice())
                .build();
    }

    public CommonResponse map(AdditionalOption additionalOption) {
        return OptionInformationResponse.builder()
                .id(additionalOption.getId())
                .name(additionalOption.getBaseInfo().getName())
                .imageSrc(additionalOption.getBaseInfo().getImageSrc())
                .price(additionalOption.getBaseInfo().getPrice())
                .partsSrc(additionalOption.getPartsSrc())
                .build();
    }

    public CommonResponse map(Wheel wheel) {
        return OptionInformationResponse.builder()
                .id(wheel.getId())
                .name(wheel.getBaseInfo().getName())
                .price(wheel.getBaseInfo().getPrice())
                .imageSrc(wheel.getBaseInfo().getImageSrc())
                .partsSrc(wheel.getPartsSrc())
                .build();
    }
}
