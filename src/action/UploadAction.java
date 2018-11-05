package action;

import action.service.UploadService;
import common.CreateFileUtil;
import common.PropertiesConf;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

//import org.apache.commons.fileupload.FileItem;
//import org.apache.commons.fileupload.FileUploadException;
//import org.apache.commons.fileupload.FileItemFactory;
//import org.apache.commons.fileupload.servlet.ServletFileUpload;
//import org.apache.commons.fileupload.disk.DiskFileItemFactory;

@WebServlet(name = "UploadAction", urlPatterns = "/upload")
public class UploadAction extends BaseServlet {
	
	private static final long serialVersionUID = -9039795233261644955L;

	//图片删除
	public String deleteImg(String imgId) {
		return UploadService.deleteImg(imgId);
	}

	//商品图片上传
	public String uploadGoodsImg(String uploadType,String minCateCode,String goodsTypeCode,HttpServletRequest req,HttpServletResponse resp){
		String address = "";

		SimpleDateFormat sdf1 = new SimpleDateFormat("YYYYMM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("dd");
		Date date = new Date();

		minCateCode = minCateCode == null ? "":minCateCode;
		goodsTypeCode = goodsTypeCode == null ? "":goodsTypeCode;
		String pathTemp = "";
		if (minCateCode != "" && goodsTypeCode != "") {
			 pathTemp = sdf1.format(date) +"/"+sdf2.format(date)+"/" + minCateCode  + "/" +goodsTypeCode + "/";
		} else if (minCateCode == "" && goodsTypeCode == "") {
			 pathTemp = sdf1.format(date) +"/"+sdf2.format(date)+"/";
			// 商品推荐模块 添加栏目图片使用
		}

		if(uploadType.equals("loadShowImg")){
			address = PropertiesConf.UPLOAD_GOODS_IMAGE_PATH + pathTemp + "show/";
		}else if(uploadType.equals("loadDetailImg")){
			address = PropertiesConf.UPLOAD_GOODS_IMAGE_PATH + pathTemp +"detail/";
		} else if (uploadType.equals("loadRecommonImg")) {
			address = PropertiesConf.UPLOAD_GOODS_IMAGE_PATH + pathTemp + "recommon/";
			// 这里存放商品推荐栏目图片
		}else if(uploadType.equals("loadAdvertisingImg")){
			address = PropertiesConf.UPLOAD_ADVERT_IMAGE_PATH_TEST + pathTemp + "advertising/";
			// 广告图片
		}else if (uploadType.equals("loadMessageImg")) {
			address = PropertiesConf.UPLOAD_MESSAGE_IMAGE_PATH + pathTemp ;
		}else if (uploadType.equals("loadPosterImg")) {
			address = PropertiesConf.UPLOAD_POSTER_IMAGE_PATH + pathTemp ;
		}

        String fileName =  uploadIMG(req,address);
		String imgPath = "";
		if(!"".equals(fileName)){
		    if(uploadType.equals("loadShowImg")){
                imgPath = "/goods/" + pathTemp + "show/" + fileName;
			} else if (uploadType.equals("loadRecommonImg")) {
		    	// 商品推荐上传栏目图片链接地址
				imgPath = "/goods/" + pathTemp + "recommon/" + fileName;
			}else if (uploadType.equals("loadAdvertisingImg")){
		    	//广告图片链接地址
				imgPath = "/advert/" + pathTemp + "advertising/" + fileName;
			}else if (uploadType.equals("loadMessageImg")){
				//广告图片链接地址
				imgPath = "/message/" + pathTemp + fileName;
			}else if (uploadType.equals("loadPosterImg")){
				imgPath = "/poster/" + pathTemp + fileName;
			}else {
				imgPath = "/goods/" + pathTemp + "detail/" + fileName;
			}
		}else{
			System.out.println("商品上传有问题");
			return "";
		}
		return UploadService.addImg(fileName,imgPath,"","","","",req);
	}


//	public String getIMGInfo(String id){
//		return UploadService.getIMGInfo(id);
//	}




	public String uploadBrandLogo(HttpServletRequest req, HttpServletResponse resp){
		String address = PropertiesConf.UPLOAD_LOGO_IMAGE_PATH;
		String fileName = uploadIMG(req,address);
		String imgPath = "";
		if(!"".equals(fileName)){
			imgPath =  "/logo/"+fileName;
		}else{
			System.out.println("上传有问题");
			return "";
		}
		return UploadService.addImg("logo",imgPath,"","","","",req);
	}


	public String uploadCategoryImg(HttpServletRequest req){
		String address = PropertiesConf.UPLOAD_CATEGORY_IMAGE_PATH;
		String fileName = uploadIMG(req,address);
		String imgPath = "";
		if(!"".equals(fileName)){
			imgPath = "/category/"+fileName;
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>"+imgPath);
		}else{
			System.out.println("上传有问题");
			return "";
		}
		return UploadService.addImg("category",imgPath,"","","","",req);
	}

	//单张图片上传
	public String uploadIMG(HttpServletRequest req,String address){

		//创建目录
		CreateFileUtil.createDir(address);

		InputStream is = null;
		String newfileName = "";
		try {
			is = req.getInputStream();
			StringBuffer sb = new StringBuffer();
			int count = 0;
			while(true){
				int a = is.read();
				sb.append((char)a);
				if(a == '\r')
					count++;
				if(count==4){
					is.read();
					break;
				}
			}
			String title = sb.toString();
			System.out.println("title>>>>>"+title);
			String[] titles = title.split("\r\n");
			String fileName = titles[1].split(";")[2].split("=")[1].replace("\"","");
			System.out.println(fileName);
			//时间为fileName前缀
			long time = new Date().getTime();
			String postfix = fileName.split("\\.")[1].toString();//后缀 文件格式
			newfileName = String.valueOf(time)+"."+postfix;
			FileOutputStream os = new FileOutputStream(new File(address + newfileName));
			byte[] ob = new byte[1024];
			int length = 0;
			while((length = is.read(ob, 0, ob.length))>0){
				os.write(ob,0,length);
				os.flush();
			}
			os.close();
			is.close();
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return newfileName;
	}


}