package ruoxijun.service;


import ruoxijun.bean.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> getAll();
    int saveEmp(Employee employee);
    boolean checkUser(String empName);
    Employee getEmp(Integer id);
    void updateEmp(Employee employee);
    void deleteEmpById(Integer id);
    void deleteBatch(List<Integer> ids);
}
