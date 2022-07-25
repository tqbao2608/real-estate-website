package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.dto.response.UserResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class UserConverter {

    @Autowired
    private ModelMapper modelMapper;

    public UserDTO convertToDto (UserEntity entity){
        UserDTO result = modelMapper.map(entity, UserDTO.class);
        return result;
    }

    public UserEntity convertToEntity (UserDTO dto){
        UserEntity result = modelMapper.map(dto, UserEntity.class);
        return result;
    }

    public UserResponseDTO convertToDto(BuildingEntity entity, UserEntity userEntities){
        UserResponseDTO results = new UserResponseDTO();
        List<Long> list = convertToListIds( entity.getUserEntities());
        results.setId(userEntities.getId());
        results.setFullName((userEntities.getFullName()));
            if (list.contains(userEntities.getId())) {
                results.setChecked(SystemConstant.CHECKED);
            }
        return results;
    }

    public UserResponseDTO convertToDto(CustomerEntity entity, UserEntity userEntities){
        UserResponseDTO results = new UserResponseDTO();
        List<Long> list = new ArrayList<>();
        entity.getUserEntities().forEach(item ->list.add(item.getId()));
        results.setId(userEntities.getId());
        results.setFullName((userEntities.getFullName()));
        if (list.contains(userEntities.getId())) {
            results.setChecked(SystemConstant.CHECKED);
        }
        return results;
    }

    private List<Long> convertToListIds(List<UserEntity> assignmentStaffs) {
        List<Long> list = new ArrayList<>();
        for (UserEntity item : assignmentStaffs) {
            list.add(item.getId());
        }
        return list;
    }


}
