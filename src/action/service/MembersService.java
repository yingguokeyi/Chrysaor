package action.service;

import action.sqlhelper.MemberSql;
import cache.AioTcpCache;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import common.StringHandler;
import common.Utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MembersService extends BaseService {
    //查询所有列表
    public static String getMembersList(int page,int limit,int member_level){
        StringBuffer sql = new StringBuffer();
        sql.append(MemberSql.getMemberList).append(" where member_level =").append(member_level);
        sql.append(" and u.department_id IS NULL");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    //查询上级会员
    public static String selectMember(String id){
        int sid = sendObject(152,id,id,id);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }
    //更改会员状态
    public static String updateStatus(String status,String id){
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(145, status, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }
    //逻辑删除会员状态
    public static String delStatus(String id ,String del_status){
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(153, del_status, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    //添加会员
    /* public static String MemberAdd(String jsonString){
     JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String nick_name = jsonObject.get("nick_name").toString();
        String phone = jsonObject.get("phone").toString();
        String sex = jsonObject.get("sex").toString();
        String birthday = jsonObject.get("birthday").toString();
        String e_mail = jsonObject.get("e_mail").toString();
        String account_number = jsonObject.get("account_number").toString();
        String member_level = jsonObject.get("member_level").toString();
        String password = jsonObject.get("psw").toString();
       String qpsw = jsonObject.get("qpsw").toString();
       int phoneI =Integer.valueOf(phone);*/
    public static String MemberAdd(String account_number,String phone,String e_mail,String nick_name ,String member_level,String password,String sex){
        System.out.println("===========================service=======");
        int member_levelI = Integer.valueOf(member_level);
        Date date=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date2 = df.format(date);
        String registration_time = Utils.transformToYYMMddHHmmss(date2);
        String source = "3";
        String status ="1";
        String login_name=nick_name;
        String account_numberI =("".equals(account_number) || account_number ==null ?"":account_number);
        String phoneI =("".equals(phone) || phone ==null ?"":phone);
        String sexI =("".equals(sex) || sex ==null ?"":sex);
        int Lisd = sendObject(AioTcpCache.gtc, 2,"", login_name,password,"","",sexI,phoneI,1,Integer.valueOf(source));
        String result1 = ResultPoor.getResult(Lisd);
        JSONArray json = JSONObject.parseObject(result1).getJSONObject("result").getJSONArray("ids");
        Integer gaia_id = json.getInteger(0);
        int source1 = Integer.parseInt(source);
        int status1 = Integer.parseInt(status);
        int category = 1;
        int sid = sendObjectCreate(144, login_name,gaia_id, phoneI, e_mail, account_numberI, member_levelI,registration_time,source1,status1,category);

        String result = ResultPoor.getResult(sid);
        return result;
    }

    //根据条件查询会员
    public static String getMemberListPage(String id,String nick_name,String phone,String status,String member_level,String registration_time1,String endDate ,String source,int page,int limit) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append(MemberSql.getMemberListPage_sql);
        if (id != null && !id.equals("")) {
            sql.append(" and u.id =").append(id);
        }
        if (nick_name != null && !nick_name.equals("")) {
            sql.append(" and u.nick_name like '%").append(nick_name).append("%'");
        }
        if (phone != null && !phone.equals("")) {
            sql.append(" and u.phone like '%").append(phone).append("%'");
        }
        if (status != null && !status.equals("")) {
            sql.append(" and u.status =").append(status);
        }
        if (member_level != null && !member_level.equals("") && !member_level.equals("null")) {
            sql.append(" and u.member_level =").append(member_level);
        }
        if ((registration_time1 != null && !registration_time1.equals("")) || (endDate!=null && !endDate.equals(""))) {
            String bDate = Utils.transformToYYMMddHHmmss(registration_time1);
            String eDate = Utils.transformToYYMMddHHmmss(endDate);
            System.out.println(bDate);
            sql.append(" and u.registration_time BETWEEN ").append(bDate).append(" and ").append(eDate);
        }
        if (source != null && !source.equals("")) {
            sql.append(" and source =").append(source);
        }
        sql.append(" GROUP BY u.id").append(" ORDER BY registration_time DESC");

        int sid = BaseService.sendObjectBase(9997, sql.toString(), page, limit);
        System.out.println("=========================="+sid);
        String retString = StringHandler.getRetString(ResultPoor.getResult(sid));
        return retString;
    }

    //查询禁止注册账户
    public static String getDisableListPage(int page,int limit,String keyword){
        System.out.println("=======================");
        StringBuffer sql = new StringBuffer();
        sql.append(MemberSql.getDisableListPage);
        if (keyword != null && !keyword.equals("")) {
            sql.append(" and memo like '%").append(keyword).append("%'");
        }
        int sid = BaseService.sendObjectBase(9997, sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }
    //查询会员人数
    public static String selectCountMember(String member_level){
        int sid = sendObject(147,member_level);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    //查询会员地址
    public static String getMemberAddress(String id){
        System.out.println("-------address------");
        int sid = sendObject(148,id);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }
    //更新会员
//    public static String updataMember(String id,String nick_name ,String registration_time ,String source , String phone,String e_mail,String account_number){
      public static String updataMember(String jsonData,String id){
        System.out.println("=======updata===");
          JSONObject jsonObject = JSONObject.parseObject(jsonData);
          int idInt = Integer.valueOf(id);
          String nick_name =(jsonObject.get("nick_name")==null ?"":jsonObject.get("nick_name").toString());
          String phone = jsonObject.get("phone").toString();
          int source = (jsonObject.get("source")==null ||"".equals(jsonObject.get("source"))? 3:(Integer.valueOf(jsonObject.get("source").toString())));
          //String birthday = jsonObject.get("birthday").toString();
          String e_mail = jsonObject.get("e_mail").toString();
          String account_number = jsonObject.get("account_number").toString();
          int member_level = (jsonObject.get("member_level")==null ||"".equals(jsonObject.get("member_level"))? 0:(Integer.valueOf(jsonObject.get("member_level").toString())));
          //String member_level = jsonObject.get("member_level").toString();
          String password = jsonObject.get("password").toString();
          sendObject(AioTcpCache.gtc, 3,"", password, nick_name);
          int sid = sendObjectCreate(149,nick_name,source,phone,e_mail,account_number,member_level,idInt );
          String result = ResultPoor.getResult(sid);
          return result;
    }

    //编辑查询用于回显
    public static String selectUpdata(int id){
        System.out.println("=======selectUpdata===");
        StringBuffer sql = new StringBuffer();
        sql.append(MemberSql.selectUpdata).append(" and u.id =").append(id);
        int sid = BaseService.sendObjectBase(9999,sql.toString());
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    //查看下级会员
    public static String selectMembers(String id,int page,int limit,String phone,String status){
       // int sid = sendObject(151,id);
        StringBuffer sql =new StringBuffer();
        sql.append(MemberSql.selectMemberDown);
        if (phone != null && !phone.equals("")) {
            sql.append(" and f.phone like '%").append(phone).append("%'");
        }
        if (status != null && !status.equals("")) {
            sql.append(" and f.status =").append(status);
        }
        sql.append(" ORDER BY beInvite_date desc");
        int sid = BaseService.sendObjectBase(9997, sql.toString(), id,id,page, limit);
        String result = ResultPoor.getResult(sid);
       String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }


    //查询订单状态
    public static String getMembersOrderStatusList(){
        int addSid = sendObject(154,2);
        return ResultPoor.getResult(addSid);
    }

    //根据用户id查询订单信息
    public static String getMemberOrdersList(String userId, int page,int limit,String order_no,String sku_name,String order_status){
        StringBuffer sql = new StringBuffer();
        sql.append(MemberSql.getMemberOrdersList(userId));
        if (order_no != null && !order_no.equals("")) {
            sql.append(" and der.order_no like '%").append(order_no).append("%'");
        }
        if (sku_name != null && !sku_name.equals("")) {
            sql.append(" and sku.sku_name like '%").append(sku_name).append("%'");
        }
        if (order_status != null && !order_status.equals("")) {
            sql.append(" and der.status =").append(order_status);
        }
        sql.append(" order by der.created_date desc");
        int sid = BaseService.sendObjectBase(9997, sql.toString(),page, limit);
        String retString = StringHandler.getRetString(ResultPoor.getResult(sid));
        return retString;
    }

    //修改会员非会员状态
    public static String updateMemberLevel(String member_level,String id){
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(155, member_level, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    public static String getMemberLevel(int state){
        int i = sendObject(638, state);
        return ResultPoor.getResult(i);
    }

    public static String updatelevel(String id,String level_name,String remark,int userId){
        //等级名称初始状态为启用：0
        int state = 0;
        long date = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String str = sdf.format(date);
        String create_time = Utils.transformToYYMMddHHmmss(str);
        int sid;
        //Id不为null为更新
        if(id == null || "".equals(id)) {
            sid = BaseService.sendObjectCreate(650, level_name,remark,create_time,create_time,state,userId);
        }else {
            sid = BaseService.sendObjectCreate(649, level_name, remark, create_time, userId,id);
        }
        return ResultPoor.getResult(sid);
    }
}
