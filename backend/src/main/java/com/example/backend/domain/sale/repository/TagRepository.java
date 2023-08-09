package com.example.backend.domain.sale.repository;

import com.example.backend.domain.sale.entity.Tag;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TagRepository extends CrudRepository<Tag, Long> {
}
