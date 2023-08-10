package com.example.backend.domain.information.model.option.repository;

import com.example.backend.domain.information.model.option.entity.Bodytype;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BodytypeRepository extends CrudRepository<Bodytype, Long> {
    @Query("SELECT comment FROM Bodytype WHERE id = :id")
    String findBodytypeCommentById(long id);
}
