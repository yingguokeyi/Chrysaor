package common;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class StringHandler {

    //返回结果集转换Json
    public static String getRetString(String retResult){
        JSONObject jsonObject = JSONObject.parseObject(retResult);
        JSONObject result = jsonObject.getJSONObject("result");
        JSONObject resultObject = JSONObject.parseObject(result.toJSONString());
        jsonObject.remove("result");
        jsonObject.put("total",resultObject.get("total"));
        jsonObject.put("rs",resultObject.get("rs"));
        return jsonObject.toJSONString();
    }



    //从Json结果集上获取特定值
    public static String getKeyOfResult(String inString,String key){
        JSONObject jsonObject = JSONObject.parseObject(inString);
        JSONObject resultJson = jsonObject.getJSONObject("result");
//        JSONObject resultObject = JSONObject.parseObject(resultJson.toJSONString());
//        JSONArray rs = (JSONArray)resultObject.get("rs");
        return resultJson.getJSONArray("rs").getJSONObject(0).getString(key).toString();
    }


    //从Json结果集上获取rs
    public static JSONArray getRsOfResult(String inString){
        JSONObject jsonObject = JSONObject.parseObject(inString);
        JSONObject resultJson = jsonObject.getJSONObject("result");
//      JSONObject resultObject = JSONObject.parseObject(resultJson.toJSONString());
//      JSONArray rs = (JSONArray)resultObject.get("rs");
        JSONArray rs = resultJson.getJSONArray("rs");
        return rs;
    }





    /**
     * 从Json结果集上获取特定集合 by luyou
     * @param inString
     * @param key
     * @return
     */
    public static List<String> getListOfResultByKey(String inString, String key){
        List<String> list = new ArrayList<String>();
        JSONObject jsonObject = JSONObject.parseObject(inString);
        JSONObject resultJson = jsonObject.getJSONObject("result");
        JSONObject resultObject = JSONObject.parseObject(resultJson.toJSONString());
        JSONArray rs = (JSONArray)resultObject.get("rs");
        for (int i = 0; i < rs.size(); i++) {
            list.add(rs.getJSONObject(i).getString(key).toString());
        }
        return list;
    }


    //从Json结果集上获取特定值(ids的第一个结果)
    public static String getIdsOfResult(String inString){
        JSONObject jsonObject = JSONObject.parseObject(inString);
        JSONObject resultJson = jsonObject.getJSONObject("result");
//        JSONObject resultObject = JSONObject.parseObject(resultJson.toJSONString());
//        JSONArray ids = (JSONArray)resultObject.get("ids");
        JSONArray ids = resultJson.getJSONArray("ids");
        return ids.get(0).toString();
    }





    /**
     *  获取商品编码的增加值
     * @param code
     * @return
     */
    public static String incrementAndGetCategoryCode(int code){
        code++;
        String codeStr = String.valueOf(code);
        String RetCode = "";
        switch(codeStr.length()){
            case 3:
                RetCode = codeStr + "000000";//一级类目补六位"0"
                System.out.println(RetCode);
                break;
            case 6:
                RetCode = codeStr + "000";//二级类目补三位"0"
                System.out.println(RetCode);
                break;
            case 9:
                RetCode = codeStr;
                break;
        }
        return RetCode;
    }



    /**
     * 获取登录用户Id
     *
     */
    public static int getUserId(HttpServletRequest req){
        HttpSession session=req.getSession();
        int userId = 0;
        if(session.getAttribute("userId")!=null){
            String userIdStr = session.getAttribute("userId").toString();
            userId = Integer.valueOf(("".equals(userIdStr))?0:Integer.valueOf(session.getAttribute("userId").toString()));
        }
        return userId;
    }


    /**
    * 获取现在时间
    *
    * @return返回字符串格式 yyyy-MM-dd HH:mm:ss
    */
    public static String getStringDate() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentTime);
        return dateString;
    }


    /**
     * 获取创建/操作时间
     * 逍遥子 20180317
     * @return
     */
    public static Integer getLongDate(){
        long time = new Date().getTime();
        String timeStr=String.valueOf(time).substring(0,10);
        return new Long(timeStr).intValue();
    }

    /**
     * 获取创建/操作时间
     * 逍遥子 20180317
     * @return
     */
    public static Integer getLongDate(String date) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date datetime =sdf.parse(date);
        long time = datetime.getTime();
        String timeStr=String.valueOf(time).substring(0,10);
        return new Long(timeStr).intValue();
    }



}
