package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.repository.custom.CustomerRepositoryCustom;
import com.laptrinhjavaweb.utils.SqlUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CustomerEntity> getCustomer(CustomerEntity entity) {
        StringBuilder sql = new StringBuilder("SELECT c.* FROM customer c");
        StringBuilder whereQuery = new StringBuilder();
        StringBuilder joinQuery = new StringBuilder();
        buildNormalQuery(entity, whereQuery);
        buildQueryWithJoin(entity,joinQuery, whereQuery);
        sql.append(joinQuery).append("\n WHERE 1 = 1").append(whereQuery).append("\nGROUP BY c.id");
        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }

    private void buildQueryWithJoin(CustomerEntity entity, StringBuilder joinQuery, StringBuilder whereQuery) {
        if (entity.getUserEntities().size() > 0){
            joinQuery.append(" INNER JOIN assignmentcustomer AS a \n" +
                    "ON c.id  = a.customer_id");
            whereQuery.append(SqlUtils.queryUsingOperator("a.staff_id","=",entity.getUserEntities().get(0).getId()));
        }
    }

    private void buildNormalQuery(CustomerEntity entity, StringBuilder whereQuery) {
        whereQuery.append( SqlUtils.queryUsingLike("c.name", entity.getName()))
                    .append( SqlUtils.queryUsingLike("c.phone", entity.getPhone()))
                    .append(SqlUtils.queryUsingLike("c.email", entity.getEmail()))
                    .append(SqlUtils.queryUsingLike("c.companyname", entity.getCompanyName()))
                    .append(SqlUtils.queryUsingLike("c.demand", entity.getDemand()))
                    .append(SqlUtils.queryUsingLike("c.note", entity.getNote()));
    }
}
