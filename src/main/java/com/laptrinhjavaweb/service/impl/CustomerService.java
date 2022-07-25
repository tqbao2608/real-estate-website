package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.buildingenum.TransactionEnum;
import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.CustomerConverter;
import com.laptrinhjavaweb.dto.request.CustomerRequestDTO;
import com.laptrinhjavaweb.dto.response.CustomerResponseDTO;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.repository.custom.CustomerRepositoryCustom;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class CustomerService implements ICustomerService {

    @Autowired
    private CustomerConverter customerConverter;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerRepositoryCustom customerRepositoryCustom;

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<CustomerResponseDTO> getCustomer(CustomerRequestDTO searchDTO) {
        List<CustomerResponseDTO> result = new ArrayList<>();
        CustomerEntity customerEntity = customerConverter.convertToEntity(searchDTO);
        if (!SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)){
            UserEntity userEntity = userRepository.findOne(SecurityUtils.getPrincipal().getId());
            customerEntity.setUserEntities(Collections.singletonList(userEntity));
        }

        List<CustomerEntity> customerEntities =
                customerRepositoryCustom.getCustomer(customerEntity);
        customerEntities.forEach(item ->{ result.add(customerConverter.convertToDto(item));});
        return result;
    }

    @Override
    public CustomerResponseDTO findById(long id) {
        CustomerEntity customerEntity = customerRepository.findById(id);
        return customerConverter.convertToDto(customerEntity);
    }

    @Override
    @Transactional
    public CustomerResponseDTO save(long id, CustomerRequestDTO dto) {
        CustomerEntity customerEntity = customerConverter.convertToEntity(dto);
        if (id > 0) {
            CustomerEntity customerFound = Optional.ofNullable(customerRepository.findById(id)).orElseThrow(
                    () -> new NotFoundException("Customer not found !"));
            if (customerFound != null) {
                customerEntity.setTransactionEntities(customerFound.getTransactionEntities());
                customerEntity.setUserEntities(customerFound.getUserEntities());
            }
        }
        return customerConverter.convertToDto(customerRepository.save(customerEntity));
    }

    @Override
    @Transactional
    public void deleteCustomer(long[] ids) {
        if ( ids.length > 0){
            customerRepository.deleteByIdIn(ids);
        }
    }

    @Override
    @Transactional
    public void assignmentForStaffs(long customerId, List<Long> staffs) {
        CustomerEntity customerFound = Optional.ofNullable(customerRepository.findById(customerId)).orElseThrow(
                () -> new NotFoundException("Customer not found !"));
        if (staffs.isEmpty()){
            customerFound.setUserEntities(null);
        } else {
            List<UserEntity> userFound = Optional.ofNullable(userRepository.findByIdIn(staffs)).orElseThrow(
                    () -> new NotFoundException("User not found !"));
            customerFound.setUserEntities(userFound);
        }
        customerRepository.save(customerFound);
    }

    @Override
    public List<CustomerResponseDTO> findCustomerByUserId(long id) {
        List<CustomerResponseDTO> results = new ArrayList<>();
        UserEntity userEntity = new UserEntity();
        userEntity.setId(id);
        customerRepository.findCustomerEntitiesByUserEntities(userEntity).forEach(
                item -> results.add(customerConverter.convertToDto(item)));
        return results;
    }

    @Override
    public Map<String, String> getMapTransaction() {
        Map<String, String> result = new HashMap<>();
        for (TransactionEnum item: TransactionEnum.values()) {
            result.put(item.name(),item.getValue());
        }
        return result;
    }

    @Override
    @Transactional
    public CustomerResponseDTO insertTransaction(long id, List<String> code) {
        CustomerEntity customerFound = Optional.ofNullable(customerRepository.findById(id)).orElseThrow(
                () -> new NotFoundException("Customer not found !"));
        List<TransactionEntity> transactionEntityList = new ArrayList<>();
        for (String item: code) {
            TransactionEntity transactionEntity = new TransactionEntity();
            transactionEntity.setCode(item);
            transactionEntity.setNote(TransactionEnum.valueOf(item).getValue());
            transactionEntity.setCustomerEntity(customerFound);
            transactionEntityList.add(transactionEntity);
        }
        customerFound.setTransactionEntities(transactionEntityList);
        return customerConverter.convertToDto( customerRepository.save(customerFound));
    }
}
