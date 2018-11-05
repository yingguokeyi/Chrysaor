package action;


import action.service.DepartmentService;
import action.service.RoleService;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;

/**
 * 角色管理
 */
@WebServlet(name = "Role", urlPatterns = "/role")
public class RoleAction extends BaseServlet {

    private static final long serialVersionUID = 1L;

    /**
     * 添加角色信息
     */
    public String addRoleInfo(String role_name, String memo,HttpServletRequest request){
        String res="";
        if(role_name.equals("") ){
            res="not_null";
        }else{
            int userId = StringHandler.getUserId(request);
            res= RoleService.addRoleInfo(role_name,memo,userId);
        }
        return res;
    }

    /**
     * 添加员工信息_获取角色信息
     */
    public String getRoleInfoToSel(){
        String res= RoleService.getRoleInfoToSel();
        return res;
    }
    /**
     * 根据角色ID获取该角色人员
     */
    public String getRoleByid(String id){
        String res= RoleService.getRoleByid(id);
        return res;
    }
    /**
     * 获取角色列表
     */
    public String getrolelist(){
        String res= RoleService.getrolelist();
        return res;
    }

    /**
     * 删除角色
     */
    public String deleterole(String ids){
        String res= RoleService.deleterole(ids);
        return res;
    }

    /**
     * 编辑角色信息（回显）
     */
    public String roleEdit(String ids){
        String res= DepartmentService.sectionEdit(ids);
        return res;
    }
}
