package ruoxijun.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ruoxijun.bean.Employee;
import ruoxijun.pojo.Msg;
import ruoxijun.service.EmployeeService;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    // 添加员工信息
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        int code = employeeService.saveEmp(employee);
        if (code == 1) {
            return Msg.success();
        }
        return Msg.fail();
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
