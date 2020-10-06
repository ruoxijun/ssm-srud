package ruoxijun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ruoxijun.bean.Employee;
import ruoxijun.dao.EmployeeMapper;

import java.util.List;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override // 查询所有员工
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }
}
