package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.request.CustomerRequestDTO;
import com.laptrinhjavaweb.dto.response.CustomerResponseDTO;

import java.util.List;
import java.util.Map;

public interface ICustomerService {

    List<CustomerResponseDTO> getCustomer(CustomerRequestDTO searchDTO);
    CustomerResponseDTO findById(long id);
    CustomerResponseDTO save(long id, CustomerRequestDTO dto);
    void deleteCustomer(long[] ids);
    void assignmentForStaffs(long customerId, List<Long> staffs);
    List<CustomerResponseDTO> findCustomerByUserId(long id);
    Map<String,String> getMapTransaction();
    CustomerResponseDTO insertTransaction(long id, List<String> code);
}
