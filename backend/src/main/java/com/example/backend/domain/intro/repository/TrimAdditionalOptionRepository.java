package com.example.backend.domain.intro.repository;

import com.example.backend.domain.intro.entity.TrimAdditionalOption;
import com.example.backend.domain.intro.mapper.TrimAdditionalOptionRowMapper;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrimAdditionalOptionRepository extends PagingAndSortingRepository<TrimAdditionalOption, Long> {
    @Query(
            value = "SELECT tao.id, tao.trim_id, tao.additional_option_id,\n" +
                    "       t.name AS trim_name, ao.name AS ao_name, ao.image_src AS ao_image_src, ao.category\n" +
                    "FROM Trim_Additional_Option tao \n" +
                    "LEFT OUTER JOIN Trim t ON t.id = tao.trim_id \n" +
                    "LEFT OUTER JOIN Additional_option ao ON ao.id = tao.additional_option_id\n" +
                    "WHERE tao.trim_id = :trimId AND (:category = '' OR ao.category = :category) \n" +
                    "LIMIT  :size \n"+
                    "OFFSET :offset",
            rowMapperClass = TrimAdditionalOptionRowMapper.class
    )
    List<TrimAdditionalOption> findAllByCategoryOrderByIdWithPaging(Long trimId, String category, long size, long offset, Pageable page);
}

