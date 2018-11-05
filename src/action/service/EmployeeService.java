package action.service;

import cache.ResultPoor;
import common.StringHandler;

public class EmployeeService extends BaseService {

    //点击编辑--回显
    public static String edit_select(String id){
        int sid = sendObject(141,id);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static String update_employee(String jsonString){
        return "";
    }
}
