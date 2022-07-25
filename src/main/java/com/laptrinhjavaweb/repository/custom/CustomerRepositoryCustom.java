package com.laptrinhjavaweb.repository.custom;

import com.laptrinhjavaweb.entity.CustomerEntity;

import java.util.List;

public interface CustomerRepositoryCustom {

    List<CustomerEntity> getCustomer(CustomerEntity entity);
}
