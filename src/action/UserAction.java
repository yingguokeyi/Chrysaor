package action;

import action.service.UserService;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebServlet(name = "User", urlPatterns = "/user")
public class UserAction extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public String getUser(String loginName, String pwd, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String res = UserService.login(loginName, pwd);
		int userStatus = (int) UserService.getFieldValue(res, "status", Integer.class);
		if (userStatus == 1) {
			int userId = (int) UserService.getFieldValue(res, "id", Integer.class);
			int department_id = (int) UserService.getFieldValue(res, "department_id", Integer.class);
			String ip = BaseCache.getRemortIP(request);
			UserService.addLoginLoger(userId, ip);
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

	public String getUserByToken(String token) {
		String res = UserService.getUserByToken(token);
		return res;
	}

	/**
	 * 添加员工信息 逍遥子_20180330
	 * 
	 * @param jsonString
	 * @param request
	 * @return
	 */
	public String addStaffInfo(String jsonString, HttpServletRequest request) {
		int userId = StringHandler.getUserId(request);
		String res = UserService.addStaffInfo(jsonString, userId);
		return res;
	}

	/**
	 * 员工管理列表 逍遥子_2018030
	 * 
	 * @param page
	 * @param limit
	 * @return
	 */
	public static String getStaffInfoList(String page, String limit, String login_name, String nick_name, String role,
			String department) {
		int pageI = Integer.valueOf(page);
		int limitI = Integer.valueOf(limit);
		String res = UserService.getStaffInfoList((pageI - 1) * limitI, pageI * limitI, login_name, nick_name, role,
				department);
		return res;
	}


	/**
	 * 员工账号禁用
	 */
	public static String forbidden(String ids){

		String res= UserService.forbidden(ids);
		return res;
	}
	/**
	 * 员工账号启用
	 */
	public static String stratuser(String ids){

		String res= UserService.stratuser(ids);
		return res;
	}
	/**
	 * 员工账号信息编辑
	 */
	public static String stratuserecho(String ids){

		String res= UserService.stratuserecho(ids);
		return res;
	}

	/**
	 * 修改员工信息
	 * 逍遥子_20180330

	 */
	public String updateStaffInfo(String jsonString){
		String res = UserService.updateStaffInfo(jsonString);
		return res;
	}

	/**
	 * 找到用户名返回
	 * @param request
	 * @return
	 */
	public String getUserName(HttpServletRequest request){
		int userId = StringHandler.getUserId(request);
		int gaia_id = UserService.checkUserPwdFirstStep(userId);
				// 一定有此值
		String loginName =  UserService.selectLoginName(gaia_id);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("loginName",loginName);
		return jsonObject.toJSONString();
	}

	public String updateSelfInfo(String jsonString,HttpServletRequest request){
		String res =  UserService.verify(jsonString,request);
		return res;
	}
}