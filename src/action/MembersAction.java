package action;

import action.service.MembersService;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Member", urlPatterns = "/member")
public class MembersAction extends BaseServlet {
    private static final long serialVersionUID = 1L;

    //查看会员
    public String getMembersList(String page, String limit, String member_level) {
        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        int member_levelI = Integer.valueOf(member_level);
        return MembersService.getMembersList((pageI - 1) * end, end, member_levelI);
    }

    //更新会员状态（禁用，启用）
    public String updateStatus(String status, String id) {
        String res = MembersService.updateStatus(status, id);
        return res;
    }


    //添加会员
    /* public String MembersAdd(String jsonString){*/
    public String MembersAdd(String account_number, String phone, String e_mail, String nick_name, String member_level, String password, String sex) {
        String result = MembersService.MemberAdd(account_number, phone, e_mail, nick_name, member_level, password, sex);
        return result;
    }


    //会员条件查询
    public String getMemberListPage(String id,String nick_name, String phone, String status, String member_level,String registration_time, String endDate, String source, String page, String limit) throws Exception {
        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return MembersService.getMemberListPage(id,nick_name, phone, status,member_level, registration_time, endDate, source, (pageI - 1) * end, end);
    }
    //编辑等级名称
    public String updateMemberlevel(String id,String level_name,String remark,HttpServletRequest request){
        HttpSession session=request.getSession();
        int userId=Integer.valueOf(session.getAttribute("userId").toString());
       return MembersService.updatelevel(id,level_name,remark,userId);
    }


    //查看禁止账户
    public String getDisableListPage(String page, String limit, String keyword) {
        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return MembersService.getDisableListPage((pageI - 1) * end, end, keyword);
    }

    //查询会员人数
    public String selectCountMember(String type) {
        System.out.println("=========type========");
        return MembersService.selectCountMember(type);
    }

    //查询会员地址
    public String getMemberAddress(String id) {
        return MembersService.getMemberAddress(id);
    }

    //更新会员
    //public String updataMember(String id,String nick_name ,String registration_time ,String source , String phone,String e_mail,String account_number){
    //return MembersService.updataMember( id, nick_name , registration_time , source ,  phone, e_mail, account_number);
    public String updataMember(String jsonData, String id) {
        String res = MembersService.updataMember(jsonData, id);
        return res;
    }



    //编辑会员回显
    public String selectUpdata(String id) {
        int ids = Integer.valueOf(id);
        return MembersService.selectUpdata(ids);
    }


    //查看上级会员
    public String selectMember(String id) {
        return MembersService.selectMember(id);
    }


    //查询下级会员
    public String selectMembers(String id, String page, String limit, String phone, String status) {
        int pageI = Integer.valueOf(page);
        int limitI = Integer.valueOf(limit);
        return MembersService.selectMembers(id, (pageI - 1) * limitI, limitI, phone, status);
    }


    //删除
    public String delMembers(String id, String del_status) {
        String res = MembersService.delStatus(id, del_status);
        return res;
    }


    //获取订单的状态
    public String getMembersOrderStatusList() {
        return MembersService.getMembersOrderStatusList();
    }


    //根据用户id查询用户订单信息
    public String getMemberOrdersList(String userId, String page, String limit, String order_no, String sku_name, String order_status) {
        int pageI = Integer.valueOf(page);
        int limitI = Integer.valueOf(limit);
        String res = MembersService.getMemberOrdersList(userId, (pageI - 1) * limitI, limitI, order_no, sku_name, order_status);
        return res;
    }


    //修改会员非会员状态
    public String updateMemberLevel(String member_level, String id) {
        String res = MembersService.updateMemberLevel(member_level, id);
        return res;
    }

    //会员等级查询
    public String findMember(){
        String memberLevel = MembersService.getMemberLevel(0);
        return StringHandler.getRetString(memberLevel);
    }

}
