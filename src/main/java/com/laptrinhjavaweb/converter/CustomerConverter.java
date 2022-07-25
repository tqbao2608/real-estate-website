package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.request.CustomerRequestDTO;
import com.laptrinhjavaweb.dto.response.CustomerResponseDTO;
import com.laptrinhjavaweb.entity.CustomerEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomerConverter {

    @Autowired
    private ModelMapper modelMapper;

    public CustomerResponseDTO convertToDto(CustomerEntity customerEntity){
        CustomerResponseDTO result = modelMapper.map(customerEntity,CustomerResponseDTO.class);

        return result;
    }

    public CustomerEntity convertToEntity(CustomerRequestDTO dto){

        return modelMapper.map(dto,CustomerEntity.class);
    }
}
