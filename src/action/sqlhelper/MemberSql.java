package action.sqlhelper;

public class MemberSql {

    //public static final String getMemberListPage_sql ="select * from uranus.t_user  where 1=1 ";
    // public static final String getMemberListPage_sql ="select u.id,u.nick_name,u.registration_time,u.source,u.member_level,u.account_number,g.phone,u.parent_user_id,u.`status`,u.e_mail ,b.invite_id,b.beInvite_phone,(select count(o.buyer_id) from  uranus.b_order AS o where u.id=o.buyer_id and o.status ='102') AS countOrder from uranus.t_user AS u left join uranus.b_invite AS b on u.id =b.id LEFT JOIN uranus.b_order AS  o on u.id = o.buyer_id LEFT JOIN gaia.t_inf_user  AS g on u.gaia_id =g.id where 1=1";
    public static final String getMemberListPage_sql = "SELECT u.id,u.nick_name,u.registration_time,u.source,u.phone AS Invitation_code1,u.member_level,u.account_number,u.phone,u.parent_user_id,u.`status`,u.Invitation_code,u.e_mail,b.invite_id," +
            "b.beInvite_phone,(SELECT a.nick_name FROM uranus.t_user AS a WHERE a.id = u.parent_user_id ) AS sup_member_name,(SELECT COUNT(1) FROM uranus.b_invite AS invite LEFT JOIN uranus.t_user AS g ON invite.invite_id = g.id  WHERE  g.parent_user_id IN" +
            "(SELECT a.id FROM uranus.t_user AS a WHERE a.parent_user_id = u.id )) AS self_num,( SELECT COUNT(1) FROM uranus.b_invite AS invite LEFT JOIN uranus.t_user AS b ON invite.invite_id = b.id WHERE b.parent_user_id = u.id ) AS pare_num, ( SELECT count(o.buyer_id) " +
            "FROM uranus.b_order AS o WHERE u.id = o.buyer_id AND o. STATUS = '102') AS countOrder FROM uranus.t_user AS u LEFT JOIN uranus.b_invite AS b ON u.id = b.id LEFT JOIN uranus.b_order AS o ON u.id = o.buyer_id WHERE 1 = 1 AND ( u.del_status != 1 OR u.del_status IS NULL ) AND u.department_id IS NULL";
    public static final String getDisableListPage = "SELECT u.*,g.login_name,current_date as Systemtime FROM uranus.t_user AS u ,gaia.t_inf_user AS g WHERE u.gaia_id=g.id AND u.`status`=0";
    public static final String certificationListPage_sql = "SELECT id,nick_name,member_level,pay_member,phone,from_unixtime(registration_time,'%y-%m-%d %h:%i') AS registration_time,audit_status FROM uranus.t_user WHERE category=0";

    //查询是否是会员
   // public static final String getMemberList = "SELECT * FROM uranus.t_user AS u";
    public static final String getMemberList = "SELECT u.*,(SELECT  a.nick_name FROM uranus.t_user AS a WHERE a.id = u.parent_user_id) AS sup_member_name,(SELECT COUNT(1) FROM uranus.t_user AS self_user WHERE self_user.parent_user_id IN (SELECT b.id FROM  uranus.t_user AS b  WHERE  b.parent_user_id = u.id)) AS self_num ,(SELECT  COUNT(1) FROM  uranus.t_user AS t_u WHERE t_u.parent_user_id = u.id) AS pare_num FROM uranus.t_user AS u";

    //编辑会员用于回显
    public static final String selectUpdata = "SELECT u.id, u.nick_name,u.registration_time,u.member_level,u.parent_user_id,u.account_number,u.phone as Invitation_code,u.`source`,u.memo,u.e_mail,g.login_name,g.password ,g.sex,u.phone FROM uranus.t_user AS u, gaia.t_inf_user AS g where u.gaia_id =g.id ";

    //查询下级会员
   //public static final String selectMemberDown = "select u.id,u.`status`,u.registration_time,b.invite_id,b.beInvite_name,b.beInvite_phone,b.beInvite_date from uranus.t_user as u INNER JOIN uranus.b_invite as b ON b.invite_id =u.id ";
  // public static final String selectMemberDown = "SELECT * FROM t_user WHERE parent_user_id in(SELECT id FROM t_user WHERE parent_user_id =?) union select * from uranus.t_user where parent_user_id = ? ";
   public static final String selectMemberDown = "SELECT * FROM ( SELECT g.*, invite.beInvite_date FROM uranus.b_invite AS invite LEFT JOIN uranus.t_user AS g ON invite.invite_id = g.id WHERE g.parent_user_id IN (SELECT a.id FROM uranus.t_user AS a WHERE a.parent_user_id = ? ) " +
            "UNION SELECT b.*, invite.beInvite_date FROM uranus.b_invite AS invite LEFT JOIN uranus.t_user AS b  ON invite.invite_id = b.id WHERE	b.parent_user_id = ? ) AS f WHERE 1 = 1";
   //根据用户id查询用户订单
    //public static final String getMemberOrdersList ="SELECT der.order_no, spu.source_code,spu.spu_code, spu.detail_img_ids, sku.sku_name, der.sku_num,sku.market_price, der.status,IF (der.my_is_member = 1,der.profit * der.member_self, der.profit * der.outsider_self) AS backMoney, sku.stock FROM uranus.b_order AS der LEFT JOIN uranus.b_sku AS sku ON der.sku_id = sku.id LEFT JOIN uranus.b_spu AS spu ON sku.spu_id = spu.id WHERE 1 = 1 AND der.buyer_id ="
   public static String getMemberOrdersList(String userId){
       StringBuffer sql = new StringBuffer("SELECT der.order_no, spu.source_code,spu.spu_code, spu.detail_img_ids, sku.sku_name, der.sku_num,sku.market_price, der.status,IF (der.my_is_member = 1,der.profit * der.member_self, der.profit * der.outsider_self) AS backMoney, sku.stock,der.created_date  ");
       sql.append(" FROM uranus.b_order AS der LEFT JOIN uranus.b_sku AS sku ON der.sku_id = sku.id LEFT JOIN uranus.b_spu AS spu ON sku.spu_id = spu.id WHERE 1 = 1 AND der.buyer_id = ");
       sql.append(userId);
       return sql.toString();
   }
}
