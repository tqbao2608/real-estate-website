package com.laptrinhjavaweb.repository;

import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CustomerRepository extends JpaRepository<CustomerEntity, Long> {
    CustomerEntity findById(long id);
    void deleteByIdIn(long[] ids);
    List<CustomerEntity> findCustomerEntitiesByUserEntities(UserEntity userEntity);

    @Query("SELECT c FROM customer c WHERE (:name is null or c.name = :name) and (:email is null"
            + " or c.email = :email) and (:phone is null or c.phone = :phone) "
            + "and (:companyname is null or c.companyName = :companyname) and (:demand is null or c.demand = :demand)"
            + "and (:note is null or c.note = :note)"
            + "and (:customerEntity is null or c.transactionEntities = :customerEntity)"
            + "and (:userEntities is null or c.userEntities = :userEntities)"
    )
    List<CustomerEntity> findCustomerEntitiesByNameAndPhoneAndEmailAndCompanyNameAndDemandAndNoteAndTransactionEntitiesAndUserEntities
            (@Param("name ") String name, @Param("email") String email, @Param("phone") String phone,
             @Param("companyname") String companyName, @Param("demand") String demand, @Param("note") String note,
             @Param("customerEntity")TransactionEntity transactionEntity, @Param("userEntities") UserEntity userEntity
            );

}
