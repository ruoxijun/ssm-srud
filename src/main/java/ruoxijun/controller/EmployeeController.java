package ruoxijun.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import ruoxijun.bean.Employee;
import ruoxijun.pojo.Msg;
import ruoxijun.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable(value = "ids") String ids) {
        if (ids.contains("-")) { // 批量删除
            ArrayList<Integer> integers = new ArrayList<>();
            String[] split = ids.split("-");
            for (String s : split) {
                integers.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(integers);
        } else { // 单个删除
            int i = Integer.parseInt(ids);
            employeeService.deleteEmpById(i);
        }
        return Msg.success();
    }

    // 更新员工
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        System.out.println("----------------------------------------"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    // 获取某员工信息
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().addData("emp",employee);
    }

    // 检查用户名是否重名
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 判断用户名是否合法
        String regx = "(^[a-zA-Z0-9]{4,12}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regx)) {
            return Msg.fail().addData("va_msg","名字格式有误,可以是2-5位中文或4-12位英文和数字的组合");
        }
        // 数据库校验用户名是否重复
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().addData("va_msg","姓名重复");
        }
    }

    // 添加员工信息
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()) {
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误字段："+error.getField());
                System.out.println("错误信息："+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().addData("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    // json接受列表数据页面
    @RequestMapping("/listJson")
    public String toListJson(){
        return "listJson";
    }

    // 返回列表json数据
    @ResponseBody
    @RequestMapping("/empsJson")
    public Msg getEmpsJson(@RequestParam(value = "pn",defaultValue = "1") int pn){
        // 参1：当前第几页，参2：每页的数据量（数据条数）
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        // 参1：查询的数据集合，参2：连续显示的页数
        PageInfo pageInfo = new PageInfo(list, 5);
        return Msg.success().addData("pageInfo",pageInfo);
    }

    // jsp显示列表页面
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") int pn, Model model){
        // 页码，数据量
        PageHelper.startPage(pn,5);
        // 所有员工
        List<Employee> emps = employeeService.getAll();
        // 查询的数据，连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
