package action.service;

import cache.ResultPoor;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.StringHandler;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class DepartmentService extends BaseService{

    /**
     * 添加部门信息
     * 逍遥子_20180327
     * @param department_name
     * @param remarks
     * @param userId
     * @return
     */
    public static  String addDepartmentInfo(String department_code,String department_name, String remarks,int userId){
        String rsTest ="";
        rsTest=departmentCheckEcho(department_code,department_name);
        if(rsTest==""){
            String create_time= BaseCache.getDateTime();
            int department_sort=getMaxDepartmentSort();
            int addId=sendObjectCreate(813,department_sort,department_code,department_name,remarks,userId,create_time);
            rsTest = ResultPoor.getResult(addId);
        }
        return  rsTest;
    }

    /**
     * 部门信息查重
     * 逍遥子_20180329
     * @param department_name
     * @return
     */
    public static String departmentCheckEcho(String department_code,String department_name){
        int addId=sendObject(812,department_code,department_name);
        String rsTest = ResultPoor.getResult(addId);
        int length = JSONObject.parseObject(rsTest).getJSONObject("result").getJSONArray("rs").size();
        if(length == 0){
            return "";
        }else{
            return "echo";
        }

    }


    /**
     * 获取部门最大排序号
     * 逍遥子_20180327
     * @return
     */
    public static Integer getMaxDepartmentSort(){
        int department_sort=1;
        int addId=sendObject(811);
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
     * 获取部门信息列表
     * 逍遥子_20180327
     * @param begin
     * @param end
     * @return
     */
    public static String getDepartmentInfo(int begin,int end){
        int sid = sendObject(810,begin,end);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    /**
     * poseidon 使用
     * @return
     */
    public static String getDepartmentRoleInfoToSel(){
        Map<String, Object> map = new HashMap<String, Object>();
        // 获取部门
        JSONArray goodsSourceList = StringHandler.getRsOfResult(getValidDeptSourceList());
        // 获取角色
        JSONArray roleSourceList = StringHandler.getRsOfResult(getRoleInfoToSel());
        map.put("result", "success");
        map.put("deptSourceList", goodsSourceList);
        map.put("roleSourceList", roleSourceList);
        String outString = JSON.toJSONString(map);
        System.out.println("outString>>>>>>>>>>>>>>>>>>" + outString);
        return outString;
    }

    /**
     * 添加员工信息_获取角色信息
     */
    public static String getRoleInfoToSel(){
        int sid = sendObject(494);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        return rsGoodsClassifyInfo;
    }

    public static String getDepartmentInfoToSel(){
        int sid = sendObject(495);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }
    //获取部门
    public static String getValidDeptSourceList() {
        int addSid = sendObject(495);
        return ResultPoor.getResult(addSid);
    }

    //更新SPU排序
    public static String updateDepartmentSort(String sort,String id,HttpServletRequest req) {
        int userId = StringHandler.getUserId(req);
        String time= BaseCache.getDateTime();
        int sid = sendObjectCreate(809, Integer.parseInt(sort),userId,time,Integer.parseInt(id));
        String result = ResultPoor.getResult(sid);
        return result;
    }


    public static String sectionEdit(String ids) {
        int sid = sendObject(805,ids);
        String rsFinance = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsFinance);
        return rsFinanceJson;
    }


    /**
     * 修改部门信息
     */
    public static String updatesectionInfo(int id,String department_name,String department_code,String remarks,int userId){
        String edit_time= BaseCache.getDateTime();
        int updateId=sendObjectCreate(806,department_name,department_code,remarks,userId,edit_time,id);
        String rsTest = ResultPoor.getResult(updateId);
        return  rsTest;
    }

    /**
     * 删除部门
     */
    public static String deletedepartment(String ids){
        String[] id = ids.split(",");
        int sid = 0;
        for (String id1 : id) {
            sid = sendObjectCreate(807, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    /**
     * 根据部门ID获取部门人员
     */
    public static String getdepementByid(String id){
        int sid = sendObject(808,id);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson= StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    public static String checkDuplicate(String loginName){
        int sid = sendObject(817, loginName);
        String res = ResultPoor.getResult(sid);
        return res;
    }
}
