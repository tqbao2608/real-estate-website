package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.response.TransactionResponseDTO;

import java.util.List;
import java.util.Map;

public interface ITransactionService {

    void save(long id, String code, String note);
    Map<String, List<TransactionResponseDTO>> getTransaction(long id);

}
