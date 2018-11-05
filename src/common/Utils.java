package common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;


public class Utils {

    /**
     * 将 订单状态转化
     * @param
     * @return
     */
    public static String orderStaueFormat(String state) {
        int stateInt = Integer.valueOf(state);
        String stateStr = "";
        if (stateInt == 103) {
            stateStr = "待备货";
        }
        if (stateInt == 104) {
            stateStr = "待发货";
        }
        if (stateInt == 101) {
            stateStr = "待支付";
        }
        if (stateInt == 105) {
            stateStr = "已发货";
        }
        if (stateInt == 106) {
            stateStr = "待提收";
        }
        if (stateInt == 107) {
            stateStr = "已提收";
        }
        if (stateInt == 108) {
            stateStr = "已完成";
        }
        if (stateInt == 110) {
            stateStr = "已取消";
        }
        if (stateInt == 111) {
            stateStr = "已取消";
        }
        if (stateInt == 113) {
            stateStr = "已取消";
        }
        if (stateInt == 112) {
            stateStr = "异常订单";
        }
        if (stateInt == 109) {
            stateStr = "失效订单";
        }
        return stateStr;
    }


    /**
     * 将2018-03-16 00:00:00 转换成 180316000000
     * @param inTime
     * @return
     */
    public static String transformToYYMMddHHmmss(String inTime) {
        String outTime;
        outTime = inTime.replace(" ","").replace("-","").replace(":","");
        return outTime.substring(2);
    }

    /**
     * 将 BaseCaseTime 180507184405 转换成 2018-03-16 00:00:00
     * @param inTime
     * @return
     */
    public static String baseCaseTimeFrmat(String inTime) {
        if(inTime.equals("")){
            return "";
        }

        String outTime = inTime.substring(0,2)+'-'+inTime.substring(2,4)+'-'+inTime.substring(4,6)+' '+inTime.substring(6,8)+':'+inTime.substring(8,10)+':'+inTime.substring(10,12);
        return outTime;
    }

    /**
     * 根据是是否试会员，算返现金额
     * @param
     * @return
     */
    public static String caseReturn(String membeLevel,String cashbake,String memberReturn,String outsiderReturnm) {
        if(Integer.valueOf(cashbake)==0||cashbake.startsWith("-")){
            return "0.00";
        }
        if(Integer.valueOf(membeLevel)==1){
            if(memberReturn.equals("0")){
                return "0.00";
            }else{
                Double me = new Double(memberReturn);
                BigDecimal num1 = new BigDecimal(me);
                BigDecimal num2 = new BigDecimal(cashbake);
                BigDecimal num3 = new BigDecimal(10000);
                return  String.valueOf(num1.multiply(num2).divide(num3).setScale(2,BigDecimal.ROUND_HALF_UP));
            }

        }else{
            if(outsiderReturnm.equals("0")){
                return "0.00";
            }else{
                Double dou= new Double(outsiderReturnm);
                BigDecimal numa = new BigDecimal(dou);
                BigDecimal numb = new BigDecimal(cashbake);
                BigDecimal numc = new BigDecimal(10000);
                String ss = String.valueOf(numa.multiply(numb).divide(numc).setScale(2,BigDecimal.ROUND_HALF_UP));
                return  ss;
            }
        }
    }




    public static String DateToTimestamp(Date time) {
        Timestamp ts = new Timestamp(time.getTime());
        return ((ts.getTime()) / 1000) + "";
    }


    //MD5加密
    public static String MD5(String sign) {

        byte[] bytes = null;

        try
        {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            bytes = md5.digest(sign.toString().getBytes("UTF-8"));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
        // 将MD5输出的二进制结果转换为小写的十六进制
        StringBuilder sign_s = new StringBuilder();

        for (int i = 0; i < bytes.length; i++)
        {
            String hex = Integer.toHexString(bytes[i] & 0xFF);

            if (hex.length() == 1)
            {
                sign_s.append("0");
            }

            sign_s.append(hex);

        }
        System.out.println("MD5:"+sign_s.toString());
        return sign_s.toString();
    }

    public static String getTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmssSSS");
        return df.format(new Date());
    }

    public String turnTime(String abc){
        Long timestamp = Long.parseLong(abc);
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date(timestamp));
        return date;
    }
    // GET 请求
    //  public String userInter(String url){
    //      HttpURLConnection connection;
    //      URL realUrl;
    //      String result="";
    //      try {
    //          realUrl = new URL(url);
    //          connection = (HttpURLConnection) realUrl.openConnection();
    //          connection.connect();
    //          BufferedReader reader = new BufferedReader(
    //                  new InputStreamReader(connection.getInputStream(),"UTF-8"));
    //          String line="";
    //          while ((line = reader.readLine()) != null) {
    //              result+=line;
    //          }
    //          connection.disconnect();
    //      } catch (Exception e) {
    //          e.printStackTrace();
    //      }
    //      return result;
    //  }
    //POST 请求
    public static  String sendPost(String url, String param) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            //          conn.setRequestProperty("accept", "*/*");
            //          conn.setRequestProperty("connection", "Keep-Alive");
            //          conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            out.print(param);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(),"UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送 POST请求出现异常!"+e);
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
        }
        return result;
    }

    /**
     *
     * 功能描述：去除字符串首部为"0"字符

     * @param str 传入需要转换的字符串
     * @return 转换后的字符串
     */
    public static String removeZero(String str){
        char  ch;
        String result = "";
        if(str != null && str.trim().length()>0 && !str.trim().equalsIgnoreCase("null")){
            try{
                for(int i=0;i<str.length();i++){
                    ch = str.charAt(i);
                    if(ch != '0'){
                        result = str.substring(i);
                        break;
                    }
                }
            }catch(Exception e){
                result = "";
            }
        }else{
            result = "";
        }
        return result;

    }
    /**
     *
     * 功能描述：金额字符串转换：单位分转成单元
     * @param
     * @return 转换后的金额字符串
     */
    public static String fenToYuan(Object o) {
        if(o == null)
            return "0.00";
        String s = o.toString();
        int len = -1;
        StringBuilder sb = new StringBuilder();
        if (s != null && s.trim().length()>0 && !s.equalsIgnoreCase("null")){
            s = removeZero(s);
            if (s != null && s.trim().length()>0 && !s.equalsIgnoreCase("null")){
                len = s.length();
                int tmp = s.indexOf("-");
                if(tmp>=0){
                    if(len==2){
                        sb.append("-0.0").append(s.substring(1));
                    }else if(len==3){
                        sb.append("-0.").append(s.substring(1));
                    }else{
                        sb.append(s.substring(0, len-2)).append(".").append(s.substring(len-2));
                    }
                }else{
                    if(len==1){
                        sb.append("0.0").append(s);
                    }else if(len==2){
                        sb.append("0.").append(s);
                    }else{
                        sb.append(s.substring(0, len-2)).append(".").append(s.substring(len-2));
                    }
                }
            }else{
                sb.append("0.00");
            }
        }else{
            sb.append("0.00");
        }
        return sb.toString();
    }
    /**
     *
     * 功能描述：金额字符串转换：单位元转成单位分
     * @param
     * @return 转换后的金额字符串
     */
    public static String yuanToFen(Object o) {
        if(o == null)
            return "0";
        String s = o.toString();
        int posIndex = -1;
        String str = "";
        StringBuilder sb = new StringBuilder();
        if (s != null && s.trim().length()>0 && !s.equalsIgnoreCase("null")){
            posIndex = s.indexOf(".");
            if(posIndex>0){
                int len = s.length();
                if(len == posIndex+1){
                    str = s.substring(0,posIndex);
                    if(str == "0"){
                        str = "";
                    }
                    sb.append(str).append("00");
                }else if(len == posIndex+2){
                    str = s.substring(0,posIndex);
                    if(str == "0"){
                        str = "";
                    }
                    sb.append(str).append(s.substring(posIndex+1,posIndex+2)).append("0");
                }else if(len == posIndex+3){
                    str = s.substring(0,posIndex);
                    if(str == "0"){
                        str = "";
                    }
                    sb.append(str).append(s.substring(posIndex+1,posIndex+3));
                }else{
                    str = s.substring(0,posIndex);
                    if(str == "0"){
                        str = "";
                    }
                    sb.append(str).append(s.substring(posIndex+1,posIndex+3));
                }
            }else{
                sb.append(s).append("00");
            }
        }else{
            sb.append("0");
        }
        str = removeZero(sb.toString());
        if(str != null && str.trim().length()>0 && !str.trim().equalsIgnoreCase("null")){
            return str;
        }else{
            return "0";
        }
    }

    /*
     *  商品编码位数位：13位；
     1-2位位商品来源，如：JD
     后面数字生成规则：
     1）3-6位为日期，如：0521；
     2）7-10位为时间上午10:56，如：1056；
     3）11-14位为随机数字，如：0000；
     @author cuiw
     */
    public static String SpuProductCodeRule(){
        LocalTime time = LocalTime.now();
        String[] timeStr =  time.toString().split(":");
        String hourMin = timeStr[0]+timeStr[1];
        LocalDate date = LocalDate.now();
        String[] dateStr =  date.toString().split("-");
        String month =  dateStr[1]+dateStr[2];
        int ran=(int)(Math.random()*9000)+1000;
        String resStr = month+hourMin+ran;
        return resStr;
    }

    public static String dataSourceToString(String dataSource){
        if(null !=dataSource && !"".equals(dataSource)) {
            if ("miniWetCat".equals(dataSource)) {
                return "小程序";
            } else {
                return "APP";
            }
        }else {
            return "--";
        }
    }

    public static String paymentWayKeyToString(String paymentWayKey){
        if(null !=paymentWayKey && !"".equals(paymentWayKey)) {
            if ("WetCat".equals(paymentWayKey)) {
                return "微信支付";
            } else {
                return "--";
            }
        }else {
            return "--";
        }
    }

    /**
     * 字符串转整型 用于金额的转换
     * @param value
     * @return
     */
    public static int StringConvertToInt(String value){
        float _temp = Float.parseFloat(value) * 100;
        float _float = (float) (Math.round(_temp * 100)) / 100;
        int _Int = ((Number) _float).intValue();
        return _Int;
    }

    public static String zdzOrderStatus(String status){
        int stateInt = Integer.valueOf(status);
        String stateStr = "";
        if (stateInt == 0) {
            stateStr = "待处理";
        }
        if (stateInt == 1) {
            stateStr = "已完成";
        }
        if (stateInt == 2) {
            stateStr = "已失效";
        }
        if (stateInt == 3) {
            stateStr = "用户退款";
        }
        return stateStr;
    }

    public static String createLinkString(Map<String, Object> params, String clientSecret) {

        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);
        String prestr = "";
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key).toString();
            prestr = prestr + key +  value;
        }
        String s = clientSecret + prestr + clientSecret;
        return s;
    }
}