package com.laptrinhjavaweb.repository;

import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    BuildingEntity findById(long id);
    void deleteByIdIn(long[] ids);
    List<BuildingEntity> findByIdIn(long[] ids);
    void deleteByUserEntities(UserEntity list);
    void deleteByUserEntitiesIn(List<UserEntity> list);
}
