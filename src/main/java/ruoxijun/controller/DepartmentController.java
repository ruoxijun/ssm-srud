package ruoxijun.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ruoxijun.bean.Department;
import ruoxijun.pojo.Msg;
import ruoxijun.service.DepartmentService;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().addData("depts",depts);
    }

}
