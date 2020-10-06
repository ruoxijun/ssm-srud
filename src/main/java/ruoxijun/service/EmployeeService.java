package ruoxijun.service;


import ruoxijun.bean.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> getAll();
    int saveEmp(Employee employee);
}
