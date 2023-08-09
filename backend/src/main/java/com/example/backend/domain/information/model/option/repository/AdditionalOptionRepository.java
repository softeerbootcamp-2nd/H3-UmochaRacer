package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdditionalOptionRepository extends CrudRepository<AdditionalOption, Long> {
//    @Query("SELECT * FROM Additional_Option ao WHERE ao.top_Option_Id IS NULL AND ao.flag = :flag")
    List<AdditionalOption> findAllByTopOptionIdIsNullAndFlag(String flag);
    List<AdditionalOption> findAllByFlag(String flag);
}
