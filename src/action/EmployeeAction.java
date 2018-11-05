package action;

import action.service.EmployeeService;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;

@WebServlet(name = "Employee",urlPatterns = "/employee")
public class EmployeeAction extends BaseServlet {

    private static final long serialVersionUID = 1L;

    //点击编辑
    public String edit_employee(String id){
        String res = EmployeeService.edit_select(id);
        return res;
    }
    public String update_employee(String jsonString){
        System.out.println("================");
        System.out.println(jsonString);
        return EmployeeService.update_employee(jsonString);
    }

}
