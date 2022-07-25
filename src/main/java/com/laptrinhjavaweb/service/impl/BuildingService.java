package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.builder.BuildingSearch;
import com.laptrinhjavaweb.buildingenum.DistrictEnum;
import com.laptrinhjavaweb.buildingenum.TypeBuildingEnum;
import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.BuildingConverter;
import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchDTO;
import com.laptrinhjavaweb.dto.response.BuildingResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.BuildingRepository;
import com.laptrinhjavaweb.repository.RentAreaRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.repository.custom.BuildingRepositoryCustom;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.IBuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.util.*;

@Service
public class BuildingService implements IBuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BuildingRepositoryCustom buildingRepositoryCustom;


    @Override
    public List<BuildingResponseDTO> findAll() {
        List<BuildingEntity> entities = buildingRepository.findAll();
        List<BuildingResponseDTO> result = new ArrayList<>();
        for (BuildingEntity item: entities) {
            BuildingResponseDTO  dto = buildingConverter.convertToDto(item);
            result.add(dto);
        }
         List<String> districts = new ArrayList<>();
        for (DistrictEnum item: DistrictEnum.values()) {
            districts.add(item.getValue());
        }
        return result;
    }

    @Override
    public Map<String, String> getDistrictEnum() {
        Map<String, String> result = new HashMap<>();
        for (DistrictEnum item: DistrictEnum.values()) {
            result.put(item.name(),item.getValue());
        }
        return result;
    }

    @Override
    public Map<String, String> getTypeBuildingEnum() {
        Map<String, String> result = new HashMap<>();
        for (TypeBuildingEnum item: TypeBuildingEnum.values()) {
            result.put(item.name(),item.getValue());
        }
        return result;
    }

    @Override
    public List<BuildingResponseDTO> findBuilding(BuildingSearchDTO dto) {
        List<BuildingResponseDTO>  result = new ArrayList<>();
        if (!SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE) && dto.getStaffId() != null){
            dto.setStaffId(SecurityUtils.getPrincipal().getId());
        }
        List<BuildingEntity> buildingEntities = buildingRepositoryCustom.findBuildingByBuilder(convertDtoToBuilder(dto));
        for (BuildingEntity item: buildingEntities) {

            result.add(buildingConverter.convertToDto(item));
        }
        return result;
    }


    @Override
    @Transactional
    public BuildingResponseDTO save(long id,BuildingRequestDTO dto) {
        BuildingEntity buildingEntity = buildingConverter.convertToEntity(dto);
        if (id > 0){
            BuildingEntity entity = Optional.ofNullable(buildingRepository.findById(id)).orElseThrow(
                    () -> new NotFoundException("Building not found !"));
            if (entity != null){
                buildingEntity.setUserEntities(entity.getUserEntities());
            }
        }
        return buildingConverter.convertToDto(buildingRepository.save(buildingEntity));
    }

    @Override
    @Transactional
    public void deleteBuilding(long[] id) {
        if (id.length > 0 && id != null){
            buildingRepository.deleteByIdIn(id);
        }
    }

    @Override
    public BuildingResponseDTO findBuildingById(long id) {
        BuildingEntity buildingEntity = buildingRepository.findOne(id);
        return buildingConverter.convertToDto(buildingEntity);
    }

    @Override
    @Transactional
    public void assignmentBuildingForStaffs(long buildingId, List<Long> staffIds) {
        BuildingEntity buildingFound = Optional.ofNullable(buildingRepository.findById(buildingId)).orElseThrow(
                () -> new NotFoundException("Building not found !"));
        if (staffIds.isEmpty()){
            buildingFound.setUserEntities(null);
        } else {
            List<UserEntity> userFound = Optional.ofNullable(userRepository.findByIdIn(staffIds)).orElseThrow(
                () -> new NotFoundException("User not found !"));
            buildingFound.setUserEntities(userFound);
        }
        buildingRepository.save(buildingFound);
    }

    @Override
    public List<BuildingResponseDTO> getBuilding(String reseachValue, Pageable pageable) {
        Page<BuildingEntity> page = null;

        return null;
    }

    private void convertObjectToMap(Map<String, Object> objectMap, List<String> list, BuildingSearchDTO dto) {
        Field[] allFields = dto.getClass().getDeclaredFields();
        for (Field field : allFields) {
            field.setAccessible(true);
            Object value = null;
            try {
                value = field.get(dto);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
            if ( value != null && !value.equals("") && !(value instanceof Collection)){
                objectMap.put(field.getName().toLowerCase(), value);
            } else if (value instanceof Collection){
                list.addAll((List<String>) value);
            }
        }
    }

    private BuildingSearch convertDtoToBuilder(BuildingSearchDTO dto){
        BuildingSearch buildingSearch = new BuildingSearch.BuildingSearchBuilder()
                .name(dto.getName())
                .district(dto.getDistrict())
                .floorArea(dto.getFloorArea())
                .ward(dto.getWard())
                .street(dto.getStreet())
                .numberOfBasement(dto.getNumberOfBasement())
                .direction(dto.getDirection())
                .level(dto.getLevel())
                .areaFrom(dto.getAreaFrom())
                .areaTo(dto.getAreaTo())
                .rentPriceFrom(dto.getRentPriceFrom())
                .rentPriceTo(dto.getRentPriceTo())
                .managerName(dto.getManagerName())
                .managerPhone(dto.getManagerPhone())
                .staffId(dto.getStaffId())
                .typesList(dto.getTypesList())
                .build();
        return  buildingSearch;
    }


}
