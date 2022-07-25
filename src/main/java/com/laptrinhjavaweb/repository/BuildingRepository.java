package com.laptrinhjavaweb.repository;

import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.access.method.P;

import java.util.List;

public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    BuildingEntity findById(long id);
    void deleteByIdIn(long[] ids);
    Page<BuildingEntity> findAll(Pageable pageable);
}
