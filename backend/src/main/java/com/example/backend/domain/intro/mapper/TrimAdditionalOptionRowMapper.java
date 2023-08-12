package com.example.backend.domain.intro.mapper;

import com.example.backend.domain.information.model.car.entity.Trim;
import com.example.backend.domain.intro.entity.TrimAdditionalOption;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TrimAdditionalOptionRowMapper implements RowMapper<TrimAdditionalOption> {
    @Override
    public TrimAdditionalOption mapRow(ResultSet rs, int rowNum) throws SQLException {
        Trim trim = Trim.builder()
                .name(rs.getString("trim_name"))
                .build();

        AdditionalOption additionalOption = AdditionalOption.builder()
                .name(rs.getString("ao_name"))
                .imageSrc(rs.getString("ao_image_src"))
                .category(rs.getString("category"))
                .build();

        return new TrimAdditionalOption(
                rs.getLong("id"),
                rs.getLong("trim_id"),
                rs.getLong("additional_option_id"),
                trim,
                additionalOption
        );
    }
}
