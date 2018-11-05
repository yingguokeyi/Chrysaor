package action.service;

import cache.ResultPoor;
import common.BaseCache;
import common.StringHandler;

public class RoleService extends BaseService {



    public static  String addRoleInfo(String role_name, String memo,int userId){
        String rsTest ="";
//        rsTest=departmentCheckEcho(department_code,department_name);
//        if(rsTest==""){
        String create_time= BaseCache.getDateTime();
        int order_num=getMaxRoleSort();
        int addId=sendObjectCreate(803,order_num,role_name,memo,userId,create_time);
        rsTest = ResultPoor.getResult(addId);
//        }
         return  rsTest;
    }
    /**
     * 获取角色最大排序号
     */
    public static Integer getMaxRoleSort(){
        int department_sort=1;
        int addId=sendObject(815);
        String rsTest = ResultPoor.getResult(addId);
        String maxSubCode = StringHandler.getKeyOfResult(rsTest,"max_sort_num");
        if(maxSubCode.equals("")==false && maxSubCode!=null){
            department_sort=Integer.valueOf(maxSubCode);
            department_sort=department_sort+1;
            return department_sort;
        }else{
            return department_sort;
        }
    }


    /**
     * 添加员工信息_获取角色信息
     */
    public static String getRoleInfoToSel(){
        int sid = sendObject(494);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    /**
     * 根据部门ID获取部门人员
     */
    public static String getRoleByid(String id){
        int sid = sendObject(804,id);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    /**
     * 获取角色列表
     */
    public static String getrolelist(){
        int sid = sendObject(802);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    /**
     * 删除角色
     */
    public static String deleterole(String ids){
        String[] id = ids.split(",");
        int sid = 0;
        for (String id1 : id) {
            sid = sendObjectCreate(814, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }
}
