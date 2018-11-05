package action;

import action.service.DepartmentService;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;

/**
 * 部门管理
 */
@WebServlet(name = "Department", urlPatterns = "/department")
public class DepartmentAction extends BaseServlet {

    private static final long serialVersionUID = 1L;

    /**
     * 添加部门信息
     * 逍遥子_20180327
     * @param department_name
     * @param remarks
     * @param request
     * @return
     */
    public String addDepartmentInfo(String department_name, String remarks,String department_code, HttpServletRequest request){
        String res="";
        if(department_code.equals("") && department_name.equals("") ){
            res="not_null";
        }else{
            int userId = StringHandler.getUserId(request);
            res= DepartmentService.addDepartmentInfo(department_code,department_name,remarks,userId);
        }
        return res;
    }

    /**
     * 获取部门信息列表
     * 逍遥子_20180327
     * @param page
     * @param limit
     * @return
     */
    public String getDepartmentInfo(String page,String limit){
        int pageI = Integer.valueOf(page);
        int limitI = Integer.valueOf(limit);
        String res= DepartmentService.getDepartmentInfo((pageI-1)*limitI,pageI*limitI);
        return res;
    }

    /**
     * 获取部门信息
     * @return
     */
    public String getDepartmentInfoToSel(){
        String res= DepartmentService.getDepartmentInfoToSel();
        return res;
    }

    public String getDepartmentRoleInfoToSel(){
        String res= DepartmentService.getDepartmentRoleInfoToSel();
        return res;
    }

    //更新排序
    public String updateSPUSort(String sort,String id,HttpServletRequest req) {
        String res = DepartmentService.updateDepartmentSort(sort,id,req);
        return res;
    }
    /**
     * 编辑部门信息（回显）
     */
    public String sectionEdit(String ids){
        String res= DepartmentService.sectionEdit(ids);
        return res;
    }
    /**
     * 修改部门信息
     */
    public String updatesectionInfo(String id,String department_name,String department_code,String remarks,HttpServletRequest request){
        int userId = StringHandler.getUserId(request);
        String res = DepartmentService.updatesectionInfo(Integer.valueOf(id),department_name,department_code,remarks,userId);
        return res;
    }

    /**
     * 删除部门
     */
    public String deletedepartment(String ids){
        String res= DepartmentService.deletedepartment(ids);
        return res;
    }

    /**
     * 根据部门ID获取该部门人员
     */
    public String getdepementByid(String id){
        String res= DepartmentService.getdepementByid(id);
        return res;
    }

    /**
     * 验证用户名是否重复
     * @param loginName
     * @return
     */
    public String checkDuplicate(String loginName){
        String res = DepartmentService.checkDuplicate(loginName);
        Integer num = (Integer) DepartmentService.getFieldValue(res,"num",Integer.class);
        if (num >= 1) {
            // 已经重复
            return "{\"msg\":\"1\"}";
        }else{
            return "{\"msg\":\"0\"}";
        }
    }
}
