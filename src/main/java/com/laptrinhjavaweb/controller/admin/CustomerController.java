package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.dto.request.CustomerRequestDTO;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.ITransactionService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "customerControllerOfAdmin")
public class CustomerController {

    @Autowired
     private ICustomerService customerService;

    @Autowired
    private IUserService userService;

    @Autowired
    private ITransactionService transactionService;

    @RequestMapping(value = "/admin/customer", method = RequestMethod.GET)
    public ModelAndView customerList(@ModelAttribute("modelSearch") CustomerRequestDTO searchDTO){
        ModelAndView mav = new ModelAndView("admin/customer/customer-list");
        mav.addObject("model",customerService.getCustomer(searchDTO));
        mav.addObject("staffmaps",userService.getStaffMaps());
        return  mav;
    }
    @RequestMapping(value = "/admin/customer-insert", method = RequestMethod.GET)
    public ModelAndView customerInsert(){
        ModelAndView mav = new ModelAndView("admin/customer/customer-edit");
        return  mav;
    }

    @RequestMapping(value = "/admin/customer-updates", method = RequestMethod.GET)
    public ModelAndView customerUpdates(@RequestParam(required = false, value = "id") Long id){
        ModelAndView mav = new ModelAndView("admin/customer/customer-edit");
        mav.addObject("model",customerService.findById(id));
        mav.addObject("modelTransaction",customerService.getMapTransaction());
        mav.addObject("modelMap", transactionService.getTransaction(id));
        return  mav;
    }
}
