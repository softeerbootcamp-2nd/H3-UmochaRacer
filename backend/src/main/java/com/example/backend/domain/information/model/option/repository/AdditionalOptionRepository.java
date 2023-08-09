package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.example.backend.domain.information.model.option.entity.AdditionalOption.*;

@Repository
public interface AdditionalOptionRepository extends CrudRepository<AdditionalOption, Long> {
//    @Query("SELECT * FROM Additional_Option ao WHERE ao.top_Option_Id IS NULL AND ao.type = :type")
    List<AdditionalOption> findAllByTopOptionIdIsNullAndType(String type);
    List<AdditionalOption> findAllByType(String type);
}
