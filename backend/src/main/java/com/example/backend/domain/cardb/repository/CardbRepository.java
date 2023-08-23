package com.example.backend.domain.cardb.repository;

import com.example.backend.domain.cardb.entity.Cardb;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CardbRepository extends CrudRepository<Cardb, Long> {
    Optional<Cardb> findByKeyword(String keyword);
}
