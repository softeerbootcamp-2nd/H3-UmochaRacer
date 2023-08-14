package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdditionalOptionRepository extends CrudRepository<AdditionalOption, Long> {
    @Query("SELECT * FROM ADDITIONAL_OPTION ao WHERE ao.category = :category AND ao.top_option_id IS NULL")
    List<AdditionalOption> findAllByCategoryAndTopOptionIdIsNull(String category);
    @Query("SELECT detail_id FROM ADDITIONAL_OPTION WHERE id = :id")
    Long findDetailIdById(long id);
}
