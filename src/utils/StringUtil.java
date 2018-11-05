package utils;


import org.springframework.util.StringUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.*;


/**
 * 字符串工具类
 * 
 * @author Tiny
 *
 */
public class StringUtil extends StringUtils {

	/**
	 * 格式化字符串，如果字符串为空,则返回""
	 * 
	 * @param str
	 * @return
	 */
	public static String formatStr(Object str) {
		if (null == str) {
			return "";
		} else {
			return str.toString();
		}
	}

	/**
	 * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
	 * 
	 * @param params
	 *            需要排序并参与字符拼接的参数组
	 * @return 拼接后字符串
	 */
	public static String createLinkString(Map<String, Object> params,String client_secret) {

		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);
		String prestr = "";
		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			Object value =  params.get(key);
			// 拼接时，不包括最后一个&字符
			/*if (i == keys.size() - 1) {
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}*/
			prestr = prestr+key+value;
		}
		String prestrs = client_secret+prestr+client_secret;
		System.out.println("pdd参数拼接result: "+prestrs);
		return prestrs;
	}

	public static String getStringFromMap(Map<String, Object> map, String key, String defaultValue) {
		if (key == "" || key == null) {
			return defaultValue;
		}
		String result = (String) map.get(key);
		if (result == null) {
			return defaultValue;
		} else {
			return result;
		}
	}

	public static InputStream getStringStream(String sInputString) throws UnsupportedEncodingException {
		ByteArrayInputStream tInputStringStream = null;
		if (sInputString != null && !sInputString.trim().equals("")) {
			tInputStringStream = new ByteArrayInputStream(sInputString.getBytes("UTF-8"));
		}
		return tInputStringStream;
	}

	public static int getIntFromMap(Map<String, Object> map, String key) {
		if (key == "" || key == null) {
			return 0;
		}
		if (map.get(key) == null) {
			return 0;
		}
		return Integer.parseInt((String) map.get(key));
	}

	/**
	 * 转换成小写
	 * 
	 * @param str
	 * @return
	 */
	public static String exChangeToLower(String str) {
		StringBuffer sb = new StringBuffer();
		if (str != null) {
			for (int i = 0; i < str.length(); i++) {
				char c = str.charAt(i);
				if (Character.isUpperCase(c)) {
					sb.append(Character.toLowerCase(c));
				} else {
					sb.append(c);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * 转换成大写
	 * 
	 * @param str
	 * @return
	 */
	public static String exChangeToUpper(String str) {
		StringBuffer sb = new StringBuffer();
		if (str != null) {
			for (int i = 0; i < str.length(); i++) {
				char c = str.charAt(i);
				if (Character.isLowerCase(c)) {
					sb.append(Character.toUpperCase(c));
				} else {
					sb.append(c);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * 转成xml格式
	 * 
	 * @param params
	 *            需要排序并参与字符拼接的参数组
	 * @return 拼接后字符串
	 */
	public static String mapToXML(Map<String, Object> params) {

		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);
		String prestr = "<xml>";
		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			if(params.get(key) != null && params.get(key).toString().length() > 0){
				String value = params.get(key).toString();
				prestr += "<" + key + ">" + value + "</" + key + ">";
			}
		}
		return prestr + "</xml>";
	}

	/**
	 * dom4j 解析xml格式字符串
	 * 
	 * @param xmlString
	 * @return
	 * @throws ParserConfigurationException
	 * @throws IOException
	 * @throws SAXException
	 */
	public static Map<String, Object> xml2Map(String xmlString)
			throws ParserConfigurationException, IOException, SAXException {

		// 这里用Dom的方式解析回包的最主要目的是防止API新增回包字段
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		InputStream is = StringUtil.getStringStream(xmlString);
		Document document = builder.parse(is);

		// 获取到document里面的全部结点
		NodeList allNodes = document.getFirstChild().getChildNodes();
		Node node;
		Map<String, Object> map = new HashMap<String, Object>();
		int i = 0;
		while (i < allNodes.getLength()) {
			node = allNodes.item(i);
			if (node instanceof Element) {
				map.put(node.getNodeName(), node.getTextContent());
			}
			i++;
		}
		return map;
	}

	/**
	 * 含有分割符的字符串,转换成list
	 * 
	 * @param str
	 * @param split
	 * @return
	 */
	public static List<String> str2List(String str, String split) {
		List<String> list = new ArrayList<String>();
		if (null != str && !"".equals(str)) {
			String[] strs = str.split(split);
			for (String s : strs) {
				if (!s.equals("")) {
					list.add(s);
				}
			}
		}
		return list;
	}

	
	/** 
     * StringUtils工具类方法 
     * 获取一定长度的随机字符串，范围0-9，a-z 
     * @param length：指定字符串长度 
     * @return 一定长度的随机字符串 
     */  
    public static String getRandomStringByLength(int length) {  
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";  
        Random random = new Random();  
        StringBuffer sb = new StringBuffer();  
        for (int i = 0; i < length; i++) {  
            int number = random.nextInt(base.length());  
            sb.append(base.charAt(number));  
        }  
        return sb.toString();  
       } 

}
