package action.service;

import cache.ResultPoor;
import common.BaseCache;
import common.Utils;

/**
 * chrysaor使用
 * Created by 18330 on 2018/9/29.
 */
public class LoginService extends BaseService  {

    public static String getLoginUser(String loginName, String pwd) {
        //int sid = sendObject(AioTcpCache.gtc, 0, "", loginName, pwd);
        int sid = sendObject(3,loginName, Utils.MD5(pwd));
        int gaiaId = (int) getFieldValue(ResultPoor.getResult(sid), "id", Integer.class);
        //如果没有用户，需要处理
        int userSid = sendObject(745, gaiaId);

        String rsTest = ResultPoor.getResult(userSid);

        return rsTest;
    }

    public static String addLoginTime(int userId, String ip) {
        String last_login_time = BaseCache.getDateTime();
        int addId = sendObjectCreate(746, userId, ip, last_login_time);
        String res = ResultPoor.getResult(addId);
        return res;
    }
}
