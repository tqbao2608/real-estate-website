package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchDTO;
import com.laptrinhjavaweb.dto.response.BuildingResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface IBuildingService {
    List<BuildingResponseDTO> findAll();
    Map<String, String> getDistrictEnum();
    Map<String, String> getTypeBuildingEnum();
    List<BuildingResponseDTO> findBuilding(BuildingSearchDTO dto);
    BuildingResponseDTO save(long id,BuildingRequestDTO  dto);
    void deleteBuilding(long[] id);
    BuildingResponseDTO findBuildingById(long id);
    void assignmentBuildingForStaffs(long buildingId, List<Long> staffIds);
    List<BuildingResponseDTO> getBuilding(String reseachValue, Pageable pageable);

}
