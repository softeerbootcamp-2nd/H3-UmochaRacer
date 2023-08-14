package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.Wheel;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WheelRepository extends CrudRepository<Wheel, Long> {
    @Query("SELECT comment FROM WHEEL WHERE id = :id")
    String findWheelCommentById(long id);

    @Query("SELECT detail_id FROM WHEEL WHERE id = :id")
    Long findDetailIdById(long id);
}
