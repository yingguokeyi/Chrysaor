package common;

import com.alibaba.fastjson.JSONObject;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BaseCache{
	private static String TIME;
	
	public static String getTIME() {
		return TIME;
	}
	
	public static void timeLoop() {
		SimpleDateFormat df = new SimpleDateFormat("YYMMddHHmmss");//设置日期格式
		while(true) {
			TIME = df.format(new Date());
			try {
				Thread.sleep(10000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}


	public static String getDateTime(){
		SimpleDateFormat df = new SimpleDateFormat("YYMMddHHmmss");//设置日期格式
		return df.format(new Date());
	}

	/**
	 * 获取访问客户端IP
	 * 逍遥子_20180330
	 * @param request
	 * @return
	 */
	public static String getRemortIP(HttpServletRequest request) {
		String ipAddress = request.getHeader("x-forwarded-for");
		if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("Proxy-Client-IP");
		}
		if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getRemoteAddr();
			if(ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")){
				//根据网卡取本机配置的IP
				InetAddress inet=null;
				try {
					inet = InetAddress.getLocalHost();
				} catch (UnknownHostException e) {
					e.printStackTrace();
				}
				ipAddress= inet.getHostAddress();
			}
		}
		//对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
		if(ipAddress!=null && ipAddress.length()>15){ //"***.***.***.***".length() = 15
			if(ipAddress.indexOf(",")>0){
				ipAddress = ipAddress.substring(0,ipAddress.indexOf(","));
			}
		}
		return ipAddress;
	}

	/**
	 * 获取操作数据返回状态值
	 * @param res
	 * @return
	 */
	public static String getSuccessVal(String res){
		String resJsonSuccess="";
		if(!res.equals("")){
			JSONObject resJson = JSONObject.parseObject(res);
			resJsonSuccess = resJson.get("success")==null? "":(resJson.get("success").toString());
		}
		return resJsonSuccess;
	}

}