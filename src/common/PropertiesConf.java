package common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesConf{
	
	public static Integer SOCKETPORT;
	
	public static String PHANTOM;
	
	public static String REDIS_IP;
	
	public static Integer REDIS_PORT;

	public static String HESTIA;
	public static String IMG_URL_PREFIX;
	public static String UPLOAD_LOGO_IMAGE_PATH;
	public static String UPLOAD_CATEGORY_IMAGE_PATH;
	public static String UPLOAD_GOODS_IMAGE_PATH;
	public static String UPLOAD_ADVERT_IMAGE_PATH;
	public static String UPLOAD_ADVERT_IMAGE_PATH_TEST;
	public static String IMG_URL_PREFIX_TEST;
//	public static String UPLOAD_PLAN_IMAGE_PATH;
	public static String UPLOAD_MESSAGE_IMAGE_PATH;
	public static String UPLOAD_POSTER_IMAGE_PATH;


	public void init(){
		Properties prop = new Properties();
		InputStream in = getClass().getResourceAsStream("/properties/BaseConnect.properties");
		try {
			prop.load(in);
			
			SOCKETPORT = Integer.valueOf((String) prop.get("socketPort"));
			
			PHANTOM = (String) prop.get("phantom");
			
			String redisPath = prop.getProperty("redis");
			REDIS_IP = redisPath.split(":")[0];
			REDIS_PORT = Integer.valueOf(redisPath.split(":")[1]);

			HESTIA = (String) prop.get("hestia");
			IMG_URL_PREFIX =  (String) prop.get("imgUrlPrefix");
			UPLOAD_LOGO_IMAGE_PATH = (String)prop.get("uploadLogoImagePath");
			UPLOAD_CATEGORY_IMAGE_PATH= (String)prop.get("uploadCategoryImagePath");
			UPLOAD_GOODS_IMAGE_PATH = (String)prop.get("uploadGoodsImagePath");
			UPLOAD_ADVERT_IMAGE_PATH = (String)prop.get("uploadAdvertImagePath");
			UPLOAD_ADVERT_IMAGE_PATH_TEST = (String)prop.get("uploadAdvertImagePathTest");
			IMG_URL_PREFIX_TEST = (String)prop.get("imgUrlPrefixTest");
			UPLOAD_MESSAGE_IMAGE_PATH = (String) prop.get("uploadMessageImagePath");
			UPLOAD_POSTER_IMAGE_PATH = (String) prop.get("uploadPosterImagePath");

//			UPLOAD_PLAN_IMAGE_PATH = (String)prop.get("uploadPlanImagePath");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}