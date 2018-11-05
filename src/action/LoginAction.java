package action;

import action.service.LoginService;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * chrysaor使用
 * Created by 18330 on 2018/9/29.
 */
@WebServlet(name = "Login", urlPatterns = "/login")
public class LoginAction extends BaseServlet {

    public String getLoginUser(String loginName, String pwd, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String res = LoginService.getLoginUser(loginName, pwd);
        int userStatus = (int) LoginService.getFieldValue(res, "status", Integer.class);
        if (userStatus == 1) {
            int userId = (int) LoginService.getFieldValue(res, "id", Integer.class);
            int department_id = (int) LoginService.getFieldValue(res, "department_id", Integer.class);
            String ip = BaseCache.getRemortIP(request);
//            LoginService.addLoginTime(userId, ip);
            JSONObject addGoodsPropertyInfoJO = JSONObject.parseObject(res);
            String logStatus = addGoodsPropertyInfoJO.get("success") == null ? ""
                    : (addGoodsPropertyInfoJO.get("success").toString());
            if (logStatus.equals("1")) {
                session.setAttribute("userId", userId);
                session.setAttribute("department_id", department_id);
            }
        }
        return res;
    }

}
