package action.service;

import cache.ResultPoor;
import common.StringHandler;

import javax.servlet.http.HttpServletRequest;

public class UploadService extends BaseService {
	//添加图片
	public static String addImg(String imageName, String imagePath,String imageThumbnailPath,String imageSamllPath,String imageMediumPath,String imageLargePath,HttpServletRequest req) {
		int userId = StringHandler.getUserId(req);
		int addSid = sendObjectCreate(482,imageName,imagePath,imageThumbnailPath,imageSamllPath,imageMediumPath,imageLargePath,userId,userId);
		String result = ResultPoor.getResult(addSid);
		return result;
	}

//	public static String getIMGInfo(String id) {
//		StringBuffer sql = new StringBuffer();
//		sql.append(GoodsSql.getImageInfo(id));
//		int sid = BaseService.sendObjectBase(9999, sql.toString());
//		return StringHandler.getRetString(ResultPoor.getResult(sid));
//
//	}

	public static String deleteImg(String imgId) {
		int sid = BaseService.sendObjectCreate(314, imgId);
		return ResultPoor.getResult(sid);
	}
}