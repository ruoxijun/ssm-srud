import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import ruoxijun.bean.Department;
import ruoxijun.bean.DepartmentExample;
import ruoxijun.bean.Employee;
import ruoxijun.bean.EmployeeExample;
import ruoxijun.dao.DepartmentMapper;
import ruoxijun.dao.EmployeeMapper;
import ruoxijun.service.EmployeeService;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class MybatisGen {
    @Test // 代码生成器
    public void show() throws Exception {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }

    @Test // 数据库测试
    public void databaseTest(){
        ApplicationContext context = new
                ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper dMapper = context.getBean("departmentMapper", DepartmentMapper.class);
        EmployeeMapper eMapper = context.getBean("employeeMapper", EmployeeMapper.class);
        // 部门插入
//        dMapper.insertSelective(new Department(null,"开发部"));
//        dMapper.insertSelective(new Department(null,"测试部"));

        // 员工插入
//        eMapper.insertSelective(new Employee(null,"haha","m","@qq.com",1));

        // 批量插入
        for(int i = 0; i<100; i++){
            String uuid=UUID.randomUUID().toString().substring(0,4);
            eMapper.insertSelective(new Employee(null,uuid,"1",uuid+"@qq.com",1));
        }

        System.out.println("插入完成");

        // 查询
        List<Employee> employees = eMapper.selectByExample(new EmployeeExample());
        System.out.println(employees);

    }

    @Test // 业务测试
    public void serviceTest(){
        ApplicationContext context =
                new ClassPathXmlApplicationContext("applicationContext.xml");
        EmployeeService employeeService = context.getBean("employeeService", EmployeeService.class);
        // 参1：当前第几页，参2：每页的数据量（数据条数）
        PageHelper.startPage(1,5);
        // 紧跟在这个方法后的第一个MyBatis 查询方法会被进行分页
        List<Employee> emps = employeeService.getAll();
        // 参1：查询的数据集合，参2：连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("连续显示的页码：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(" "+num);
        }
        System.out.println("当前页数据：");
        List<Employee> list = pageInfo.getList();
        for (Employee employee:list){
            System.out.println(employee);
        }
    }
}
