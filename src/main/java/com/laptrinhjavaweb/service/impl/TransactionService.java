package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.buildingenum.TransactionEnum;
import com.laptrinhjavaweb.converter.TransactionConverter;
import com.laptrinhjavaweb.dto.response.TransactionResponseDTO;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.repository.TransactionRepository;
import com.laptrinhjavaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TransactionService implements ITransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private TransactionConverter transactionConverter;

    @Autowired
    private CustomerRepository customerRepository;

    @Override
    public void save(long id, String code, String note) {
        TransactionEntity transactionEntity = new TransactionEntity();
        CustomerEntity customerFound = Optional.ofNullable(customerRepository.findById(id)).orElseThrow(
                () -> new NotFoundException("Customer not found !"));
        transactionEntity.setCode(code);
        transactionEntity.setNote(note);
        transactionEntity.setCustomerEntity(customerFound);
        transactionRepository.save(transactionEntity);
    }

    @Override
    public Map<String, List<TransactionResponseDTO>> getTransaction(long id) {
        Map<String, List<TransactionResponseDTO>> result = new HashMap<>();
        for (TransactionEnum item: TransactionEnum.values()) {
            List<TransactionEntity>  entities = transactionRepository.findByCustomerEntity_IdAndCodeIn(id,item.name());
            List<TransactionResponseDTO> listValues = new ArrayList<>();
            entities.forEach(itemListValues -> listValues.add(transactionConverter.convertToDto(itemListValues)));
            result.put(item.name(),listValues);
        }
        return result;
    }
}
