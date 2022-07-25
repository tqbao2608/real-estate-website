package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.response.TransactionResponseDTO;
import com.laptrinhjavaweb.entity.TransactionEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    public TransactionResponseDTO convertToDto(TransactionEntity entity){

        return  modelMapper.map(entity,TransactionResponseDTO.class);
    }
}
