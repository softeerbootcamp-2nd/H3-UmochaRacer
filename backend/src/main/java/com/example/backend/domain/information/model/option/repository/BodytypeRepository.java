package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BodytypeRepository extends CrudRepository<Bodytype, Long> {
    @Query("SELECT comment FROM BODYTYPE WHERE id = :id")
    Optional<String> findBodytypeCommentById(long id);

    @Query("SELECT detail_id FROM BODYTYPE WHERE id = :id")
    Long findDetailIdById(long id);
}
