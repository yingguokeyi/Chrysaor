package action.service;

import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.StringHandler;

public class DistrbutionService extends BaseService{


    /**
     * 分销设置_默认分销值列表
     * 逍遥子_20180320
     * @return
     */
    public static String defaultDistributionInfoList(){
        int sid = sendObject(58);
        String distrbutionSetInfoJson= ResultPoor.getResult(sid);
        String rsDistrbutionSetInfoJson= StringHandler.getRetString(distrbutionSetInfoJson);
        return rsDistrbutionSetInfoJson;
    }

    /**
     * 分销设置_非默认分销值列表
     * 逍遥子_20180320
     * @return
     */
    public static String noDefaultDistributionInfoList(){
        int sid = sendObject(74);
        String distrbutionSetInfoJson= ResultPoor.getResult(sid);
        String rsDistrbutionSetInfoJson= StringHandler.getRetString(distrbutionSetInfoJson);
        return rsDistrbutionSetInfoJson;
    }

    /**
     * 添加默认分销规则
     * 逍遥子_20180319
     * @param jsonString
     * @param userId
     * @return
     */
    public static String addDefaultDistributionValSet(String jsonString,int userId){
         JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String member_type = jsonObject.get("member_type").toString();
        String dis_name = jsonObject.get("dis_name").toString();
        int top_level_ratio = Integer.valueOf(jsonObject.get("top_level_ratio").toString());
        int parent_ratio = Integer.valueOf(jsonObject.get("parent_ratio").toString());
        int child_ratio = Integer.valueOf(jsonObject.get("child_ratio").toString());
        int is_default=1;
        int state =0;
        int edit_time= StringHandler.getLongDate();
        int addSid =0;
        if(member_type.equals("2")){
            addSid = sendObjectCreate(59, dis_name,top_level_ratio,parent_ratio,child_ratio,is_default,state,userId,edit_time);
        }else{
            addSid = sendObjectCreate(73, dis_name,top_level_ratio,parent_ratio,child_ratio,is_default,state,userId,edit_time);
        }
        String rsTest = ResultPoor.getResult(addSid);
        return rsTest;
    }


    /**
     * 添加非默认分销规则
     * 逍遥子_20180319
     * @param jsonString
     * @param userId
     * @return
     */
    public static String addNotDefaultDistributionValSet(String jsonString,int userId){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String member_type = jsonObject.get("member_type").toString();
        String dis_name = jsonObject.get("dis_name").toString();
        int top_level_ratio = Integer.valueOf(jsonObject.get("top_level_ratio").toString());
        int parent_ratio = Integer.valueOf(jsonObject.get("parent_ratio").toString());
        int child_ratio = Integer.valueOf(jsonObject.get("child_ratio").toString());
        int is_default=2;
        int state =0;
        int edit_time= StringHandler.getLongDate();
        int addSid =0;
        if(member_type.equals("2")){
            addSid = sendObjectCreate(59, dis_name,top_level_ratio,parent_ratio,child_ratio,is_default,state,userId,edit_time);
        }else{
            addSid = sendObjectCreate(73, dis_name,top_level_ratio,parent_ratio,child_ratio,is_default,state,userId,edit_time);
        }
        String rsTest = ResultPoor.getResult(addSid);
        return rsTest;
    }

    /**
     * 获取返佣规则详细信息
     * 逍遥子_20180320
     * @param id
     * @return
     */
    public static String getDefaultDistributionDetailInfo(String id){
        int sid = sendObject(75,id);
        String distrbutionSetInfoJson= ResultPoor.getResult(sid);
        String rsDistrbutionSetInfoJson= StringHandler.getRetString(distrbutionSetInfoJson);
        return rsDistrbutionSetInfoJson;
    }

    /**
     * 编辑非默认分销值
     * 逍遥子_20180320
     * @param jsonString
     * @param id
     * @param member
     * @param userId
     * @return
     */
    public static String upDefaultDistributionDetailInfo(String jsonString,String id,String member,int userId){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String rebate_name = jsonObject.get("dis_name").toString();
        int top_level_ratio =Integer.valueOf(jsonObject.get("top_level_ratio").toString());
        int parent_ratio = Integer.valueOf(jsonObject.get("parent_ratio").toString());
        int child_ratio = Integer.valueOf(jsonObject.get("child_ratio").toString());
        int edit_time= StringHandler.getLongDate();
        int idInt=Integer.valueOf(id);
        int addSid =0;
        if(jsonObject.get("member_type").toString().equals("1")){
            if(member.equals(jsonObject.get("member_type").toString())==false){
                addSid = sendObjectCreate(60, rebate_name,0,0,0,userId,edit_time,idInt);
            }
            addSid = sendObjectCreate(76, rebate_name,top_level_ratio,parent_ratio,child_ratio,userId,edit_time,idInt);
        }else{
            if(member.equals(jsonObject.get("member_type").toString())==false){
                addSid = sendObjectCreate(76, rebate_name,0,0,0,userId,edit_time,idInt);
            }
            addSid = sendObjectCreate(60, rebate_name,top_level_ratio,parent_ratio,child_ratio,userId,edit_time,idInt);
        }
        String rsTest = ResultPoor.getResult(addSid);
        return rsTest;
    }


    /**
     * 编辑默认分销值
     * 逍遥子_20180320
     * @param jsonString
     * @param id
     * @param member
     * @param userId
     * @return
     */
    public static String upNoDefaultDistributionDetailInfo(String jsonString,String id,String member,int userId){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String rebate_name = jsonObject.get("dis_name").toString();
        int top_level_ratio =Integer.valueOf(jsonObject.get("top_level_ratio").toString());
        int parent_ratio = Integer.valueOf(jsonObject.get("parent_ratio").toString());
        int child_ratio = Integer.valueOf(jsonObject.get("child_ratio").toString());
        int edit_time= StringHandler.getLongDate();
        int idInt=Integer.valueOf(id);
        int addSid =0;
        if(jsonObject.get("member_type").toString().equals("1")){
            if(member.equals(jsonObject.get("member_type").toString())==false){
                addSid = sendObjectCreate(60, rebate_name,0,0,0,userId,edit_time,idInt);
            }
            addSid = sendObjectCreate(76, rebate_name,top_level_ratio,parent_ratio,child_ratio,userId,edit_time,idInt);
        }else{
            if(member.equals(jsonObject.get("member_type").toString())==false){
                addSid = sendObjectCreate(76, rebate_name,0,0,0,userId,edit_time,idInt);
            }
            addSid = sendObjectCreate(60, rebate_name,top_level_ratio,parent_ratio,child_ratio,userId,edit_time,idInt);
        }
        String rsTest = ResultPoor.getResult(addSid);
        return rsTest;
    }

    /**
     * 删除默认分销规则
     * 逍遥子_20180320
     * @param id
     * @param userId
     * @return
     */
    public static String delDistributionValSet(String id,int userId){
        int edit_time= StringHandler.getLongDate();
        int delSid = sendObjectCreate(61,1,userId,edit_time,id);
        String rsTest = ResultPoor.getResult(delSid);
        return rsTest;
    }

    /**
     * 删除默认分销规则
     * 逍遥子_20180320
     * @param id
     * @param userId
     * @return
     */
    public static String noDelDefaultDistributionInfo(String id,int userId){
        int edit_time= StringHandler.getLongDate();
        int delSid = sendObjectCreate(61,1,userId,edit_time,id);
        String rsTest = ResultPoor.getResult(delSid);
        return rsTest;
    }


}
