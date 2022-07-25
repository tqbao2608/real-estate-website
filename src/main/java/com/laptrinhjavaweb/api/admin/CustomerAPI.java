package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.dto.request.CustomerRequestDTO;
import com.laptrinhjavaweb.dto.response.UserResponseDTO;
import com.laptrinhjavaweb.dto.response.CustomerResponseDTO;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.ITransactionService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customer")
public class CustomerAPI {

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserService userService;

    @Autowired
    private ITransactionService transactionService;

    @GetMapping("/{customerId}/staffs")
    public ResponseEntity<List<UserResponseDTO>> getStaffs(@PathVariable("customerId") Long id){
        return ResponseEntity.ok(userService.findStaffByCustomerId(id));
    }

    @PostMapping("/{customerId}/assignment")
    public ResponseEntity<Void> assignmentForStaff(@PathVariable("customerId") Long id, @RequestBody List<Long> staffs){
        customerService.assignmentForStaffs(id,staffs);
        return  ResponseEntity.noContent().build();
    }

    @PostMapping
    public ResponseEntity<CustomerResponseDTO> creatStaff(@RequestBody CustomerRequestDTO dto){
        return ResponseEntity.ok(customerService.save(-1 ,dto));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CustomerResponseDTO> updateBuilding(@PathVariable(value = "id",required = false) long id, @RequestBody CustomerRequestDTO dto) {
        return ResponseEntity.ok(customerService.save(id ,dto));
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteStaff(@RequestBody long[] ids) {
        if (ids.length > 0){
            customerService.deleteCustomer(ids);
        }
        return  ResponseEntity.noContent().build();
    }

    @PostMapping("/{customerId}/transaction")
    public ResponseEntity<Void> insertTransaction(
            @PathVariable(value = "customerId", required = false) long customerId,
            @RequestParam(name = "note", required = false) String note,
            @RequestParam(name = "code", required = false) String code){
            transactionService.save(customerId,code,note);
        return ResponseEntity.noContent().build();
        //return  ResponseEntity.ok(customerService.insertTransaction(customerId,code));
    }

}
