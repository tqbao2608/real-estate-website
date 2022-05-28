package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.builder.BuildingSearch;
import com.laptrinhjavaweb.buildingenum.DistrictEnum;
import com.laptrinhjavaweb.buildingenum.TypeBuildingEnum;
import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.dto.response.BuildingResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.RentAreaEntity;
import com.laptrinhjavaweb.repository.RentAreaRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Component
public class BuildingConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingResponseDTO convertToDto(BuildingEntity entity) {
        BuildingResponseDTO result = modelMapper.map(entity, BuildingResponseDTO.class);

        String district = DistrictEnum.valueOf(entity.getDistrict()).getValue();
        result.setAddress(entity.getStreet() + SystemConstant.COMMA + entity.getWard() + SystemConstant.COMMA + district );
        List<String> listStringRentArea = new ArrayList<>();
        for (RentAreaEntity item: entity.getRentAreaEntityList()) {
            listStringRentArea.add(item.getValue().toString());
        }
        result.setRentArea(String.join(SystemConstant.COMMA, listStringRentArea));
        result.setDistrictCode(DistrictEnum.valueOf(entity.getDistrict()).name());
        result.setDistrictName(district);

        if (!entity.getType().isEmpty() && entity.getType() != null){
            result.setChecked(SystemConstant.CHECKED);
        }

        return result;

    }

    public BuildingEntity convertToEntity(BuildingRequestDTO dto) {
        BuildingEntity result = modelMapper.map(dto, BuildingEntity.class);
        String types = String.join(SystemConstant.COMMA, dto.getTypes());
        result.setType(types);
        List<RentAreaEntity> entity = new ArrayList<>();
        String[] list = dto.getAreaRent().replaceAll(" ","").split(SystemConstant.COMMA);
        if (!list.toString().isEmpty()){
            for (String item: list) {
                if (item.length() > 0){
                    Integer value = Integer.valueOf(item);
                    if (value != null && value > 0){
                        RentAreaEntity areaEntity = new RentAreaEntity();
                        areaEntity.setValue(value);
                        areaEntity.setBuilding(result);
                        entity.add(areaEntity);
                    }
                }
            }
        }
        result.setRentAreaEntityList(entity);
        return result;
    }

    public BuildingEntity convertBuilderToEntity(BuildingSearch buildingSearch){
        BuildingEntity result = modelMapper.map(buildingSearch, BuildingEntity.class);
        return result;
    }

}
