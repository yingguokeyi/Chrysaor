package action.service;

import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.RedisClient;
import common.StringHandler;
import common.Utils;

import javax.servlet.http.HttpServletRequest;

public class UserService extends BaseService {
    /**
     * @param @param  loginName
     * @param @param  pwd
     * @param @return 参数
     * @return String    返回类型
     * @throws
     * @Title: login
     * @Description: TODO(登陆接口)
     */
    public static String login(String loginName, String pwd) {
        //int sid = sendObject(AioTcpCache.gtc, 0, "", loginName, pwd);
        int sid = sendObject(3,loginName, Utils.MD5(pwd));
        int gaiaId = (int) getFieldValue(ResultPoor.getResult(sid), "id", Integer.class);
        //如果没有用户，需要处理
        int userSid = sendObject(4, gaiaId);

        String rsTest = ResultPoor.getResult(userSid);

        return rsTest;
    }

    /**
     * @param @param  token
     * @param @return 参数
     * @return String    返回类型
     * @throws
     * @Title: getUserByToken
     * @Description: TODO(根据token取用户信息)
     */
    public static String getUserByToken(String token) {
        return RedisClient.hget("token_user", token, "userText");
    }

    public static String getUserIdByToken(String token) {
        return RedisClient.hget("token_user", token, "userId");
    }

    /**
     * 添加t_user员工信息
     * 逍遥子_20180330
     *
     * @param jsonString
     * @param userId
     * @return
     */
    public static String addStaffInfo(String jsonString, int userId) {
        int addId = 0;
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String rsTest = "";

            String nick_name = jsonObject.get("i_nick_name").toString();
            String account_number = jsonObject.get("i_login_name").toString();
            String login_password = jsonObject.get("i_old_password").toString();
            String email = jsonObject.get("u_email").toString();
            String phone_num = jsonObject.get("i_phone").toString();
            String department = jsonObject.get("i_department").toString();
            String role = jsonObject.get("i_role").toString();
            String memo = jsonObject.get("i_memo").toString();
            //int job_number = getMaxJob_number(department);
//			String landline_num = (jsonObject.get("landline_num")==null? "":(jsonObject.get("landline_num").toString()));
//			String memo = (jsonObject.get("memo")==null? "":(jsonObject.get("memo").toString()));
//			int source_code = (jsonObject.get("source_code")==null? 0:(Integer.valueOf(jsonObject.get("source_code").toString())));
//			int create_time= StringHandler.getLongDate();
            int gaia_id = addGainaUserInfo(account_number, login_password, phone_num);
            if (gaia_id != 0) {
                addId = sendObjectCreate(801, nick_name, gaia_id, department, "", email, phone_num, 1, 1, role, memo);
                rsTest = ResultPoor.getResult(addId);
            }

        return rsTest;
    }

    /**
     * 添加gaia用户信息
     * 逍遥子_20180330
     *
     * @param account_number
     * @param login_password
     * @param phone_num
     * @return
     */
    public static Integer addGainaUserInfo(String account_number, String login_password, String phone_num) {
        int gaia_id = 0;
        int addId = sendObjectCreate(226, account_number, Utils.MD5(login_password), phone_num, 1, 1);
        String res = ResultPoor.getResult(addId);
        JSONObject resJson = JSONObject.parseObject(res);
        String resJsonSuccess = resJson.get("success") == null ? "" : (resJson.get("success").toString());
        if (resJsonSuccess.equals("1")) {
            gaia_id = Integer.valueOf(StringHandler.getIdsOfResult(res));
//            gaia_id = (int) UserService.getFieldValue(res, "ids", Integer.class);

        }
        return gaia_id;
    }

    /**
     * 获取最大工号
     * 逍遥子_20180330
     *
     * @param department
     * @return
     */
    public static Integer getMaxJob_number(String department) {
        int addSid = sendObject(802, department);
        String job_number = getFieldValue(ResultPoor.getResult(addSid), "max_job_num", String.class).toString();
        if (job_number.equals("")) {
            int num = 1001;
            return num;
        } else {
            int job_numberInt = Integer.valueOf(job_number);
            return job_numberInt + 1;
        }
    }

    /**
     * 记录登录时间
     * 逍遥子_20180330
     *
     * @param userId
     * @return
     */
    public static String addLoginLoger(int userId, String ip) {
        String last_login_time = BaseCache.getDateTime();
        int addId = sendObjectCreate(228, userId, ip, last_login_time);
        String res = ResultPoor.getResult(addId);
        return res;
    }

    public static String getStaffInfoList(int begin, int end, String login_name, String nick_name, String role, String department) {
        String sql = "";
        if (login_name != null && login_name != "") {
            sql += " And login_name LIKE '%" + login_name + "%'";
        }
        if (nick_name != null && nick_name != "") {
            sql += " And userInfo.nick_name LIKE '%" + nick_name + "%'";
        }
        if (role != null && role != "") {
            sql += " AND userInfo.role_id = " + Integer.valueOf(role);
        }
        if (department != null && department != "") {
            sql += " AND userInfo.department_id = " + Integer.valueOf(department);
        }
        sql += " GROUP BY userInfo.id ORDER BY userInfo.id DESC";

        int sid = sendObjectBase(493, sql, begin, end);
        String rsGoodsClassifyInfo = ResultPoor.getResult(sid);
        String rsFinanceJson = StringHandler.getRetString(rsGoodsClassifyInfo);
        return rsFinanceJson;
    }

    public static String forbidden(String ids) {
        String[] id = ids.split(",");
        int sid = 0;
        for (String id1 : id) {
            sid = sendObjectCreate(496, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    public static String stratuser(String ids) {
        String[] id = ids.split(",");
        int sid = 0;
        for (String id1 : id) {
            sid = sendObjectCreate(497, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    public static String stratuserecho(String ids) {
        int sid = sendObject(498, ids);
        String rsFinance = ResultPoor.getResult(sid);
        String rsFinanceJson = StringHandler.getRetString(rsFinance);
        return rsFinanceJson;
    }

    /**
     * 修改t_user员工信息
     */
    public static String updateStaffInfo(String jsonString) {
        int updateId = 0;
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String rsTest = "";
        String id = jsonObject.get("id").toString();
        String gaia_id = jsonObject.get("gaia_id").toString();
        String nick_name = jsonObject.get("nick_name").toString();
        String account_number = jsonObject.get("login_name").toString();
        String login_password = jsonObject.get("login_password").toString();
        String email = jsonObject.get("email").toString();
        String phone_num = jsonObject.get("phone_num").toString();
        String department = jsonObject.get("department").toString();
        String role = jsonObject.get("role").toString();
        String memo = jsonObject.get("memo").toString();
//			String landline_num = (jsonObject.get("landline_num")==null? "":(jsonObject.get("landline_num").toString()));
//			String memo = (jsonObject.get("memo")==null? "":(jsonObject.get("memo").toString()));
//			int source_code = (jsonObject.get("source_code")==null? 0:(Integer.valueOf(jsonObject.get("source_code").toString())));
//			int create_time= StringHandler.getLongDate();
        String resJsonSuccess = updateGainaUserInfo(account_number, login_password, gaia_id);
        if (resJsonSuccess.equals("1")) {
            updateId = sendObjectCreate(332, nick_name, department, email, phone_num, role, memo, id);
            rsTest = ResultPoor.getResult(updateId);
        }

        return rsTest;
    }

    /**
     * 修改gaia用户信息
     * 逍遥子_20180330
     */
    public static String updateGainaUserInfo(String account_number, String login_password, String gaia_id) {
        int addId = sendObjectCreate(333, account_number, Utils.MD5(login_password), gaia_id);
        String res = ResultPoor.getResult(addId);
        JSONObject resJson = JSONObject.parseObject(res);
        String resJsonSuccess = resJson.get("success") == null ? "" : (resJson.get("success").toString());
        return resJsonSuccess;
    }

    /**
     * 获取用户登录名
     *
     * @param gaiaId
     * @return
     */
    public static String selectLoginName(int gaiaId) {
        int loginId = sendObject(345, gaiaId);
        String res = ResultPoor.getResult(loginId);
        String loginName = (String) UserService.getFieldValue(res, "login_name", String.class);
        return loginName;
    }

    /**
     * 验证用户原密码是否正常
     *
     * @param jsonString
     * @return
     */
    public static String verify(String jsonString, HttpServletRequest request) {
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String oPwd = jsonObject.get("u_old_password").toString();
        String phone = jsonObject.get("u_phone").toString();
//        String jobPone = jsonObject.get("job_phone").toString();
        String email = jsonObject.get("u_email").toString();
        String depId ="";
        String roleId = "";

        boolean flag = false;
        //  默认已经拥有gaia_id
        try {
            depId = jsonObject.get("u_department").toString();
            roleId = jsonObject.get("u_role").toString();
            // 取到 说明gaia_id 已经具备
        } catch (Exception e) {
           // e.printStackTrace();
            depId = "";
            roleId = "";
            flag = true;
            // 取不到 担心没有 则说明 不是 员工管理添加修改界面操作  而是个人密码的修改
        }
        int gaia_id = 0;
        if (flag) {
            gaia_id = checkUserPwdFirstStep(StringHandler.getUserId(request));
        } else {
            String gaia_id_temp = jsonObject.get("u_gaia_id").toString();
            gaia_id = Integer.valueOf(gaia_id_temp);
            // 此处执行为员工修改登录密码
            // 员工登录密码修改
            String login_name = jsonObject.get("u_login_name").toString();
            String  res = updateGainaUserInfo(login_name,oPwd,gaia_id+"");
            // 直接由登录人输入员工新密码 更新
            String nick_name = jsonObject.get("u_nick_name").toString();
            String memo = jsonObject.get("u_memo").toString();
            String id = jsonObject.get("u_id").toString();
            int updateId = sendObjectCreate(816, nick_name, depId, email, phone, roleId, memo,"",id);
            String rsTest = ResultPoor.getResult(updateId);
            if (rsTest.equals("")){
                jsonObject.put("msg","修改 失败 ");
            }else{
                jsonObject.put("msg", "修改成功");
            }
            return jsonObject.toString();
        }

        String userNum = checkUserPwdSecondStep(gaia_id, oPwd);
        // 查询是否有此人
        String res = "";
        if (userNum.equals("0")) {
            jsonObject.put("msg", "用户输入原密码错误");
            return jsonObject.toJSONString();
        } else if (userNum.equals("1")) {
            // 原密码正确 进行更新
                String nPwd = jsonObject.get("new_password").toString();
                // 个人登录密码修改
                res = updateInfoUser(nPwd, phone, gaia_id);
            if ("" == res) {
                jsonObject.put("msg", "更新失敗");
                return jsonObject.toJSONString();
            } else {
                res = updateUser(phone, email, "", StringHandler.getUserId(request));
                jsonObject.put("msg", "修改成功");
            }
        }
        return jsonObject.toJSONString();
    }

    /**
     * @param userId
     * @return
     */
    public static int checkUserPwdFirstStep(int userId) {
        int uId = sendObject(499, userId);
        String res = ResultPoor.getResult(uId);
        int gaia_id = (int) UserService.getFieldValue(res, "gaia_id", Integer.class);
        return gaia_id;
    }

    /**
     * @param gaiaId
     * @param oldPwd
     * @return
     */
    public static String checkUserPwdSecondStep(int gaiaId, String oldPwd) {
        int sid = sendObject(342, gaiaId, Utils.MD5(oldPwd));
        String res = ResultPoor.getResult(sid);
        String userNum = (String) UserService.getFieldValue(res, "userNum", String.class);
        return userNum;
    }

    /**
     * 修改t_infoUser
     *
     * @param newPwd
     * @param phone
     * @param gaiaId
     * @return
     */
    public static String updateInfoUser(String newPwd, String phone, int gaiaId) {
        int sid = sendObjectCreate(343, Utils.MD5(newPwd), phone, gaiaId);
        String res = ResultPoor.getResult(sid);
        JSONObject resJson = JSONObject.parseObject(res);
        String resJsonSuccess = resJson.get("success") == null ? "" : (resJson.get("success").toString());
        return resJsonSuccess;
    }

    /**
     * @param phone
     * @param email
     * @param job_number
     * @param userId
     * @return
     */
    public static String updateUser(String phone, String email, String job_number, int userId) {
        int uId = sendObjectCreate(800, phone, email, job_number, userId);
        String res = ResultPoor.getResult(uId);
        JSONObject resJson = JSONObject.parseObject(res);
        String resJsonSuccess = resJson.get("success") == null ? "" : (resJson.get("success").toString());
        return resJsonSuccess;
    }
}