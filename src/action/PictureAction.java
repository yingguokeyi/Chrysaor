package action;

import action.service.PictureService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * chrysaor使用
 *
 * @author cuiw
 */
@WebServlet(name = "Picture", urlPatterns = "/picture")
public class PictureAction extends BaseServlet {

    /**
     * 查询所有的图片分类
     *
     * @return
     */
    public String getPictureCategoryInfo() {
        String res = PictureService.getPictureCategoryInfo();
        return StringHandler.getRetString(res);
    }

    /**
     * @param request
     * @param categoryName
     * @return
     */
    public String insertPictureCategory(HttpServletRequest request, String categoryName) {
        String res = PictureService.insertPictureCategory(request, categoryName);
        return StringHandler.getRetString(res);
    }

    /**
     * @param id
     * @return
     */
    public String selectPictureCategoryInfo(String id) {
        String res = PictureService.selectPictureCategoryInfo(id);
        return StringHandler.getRetString(res);
    }

    /**
     * @param id
     * @param categoryName
     * @return
     */
    public String updatePictureCategoryInfo(String id, String categoryName) {
        String res = PictureService.updatePictureCategoryInfo(id, categoryName);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param pictureName
     * @param status
     * @param edit_time
     * @param editend_time
     * @param page
     * @param limit
     * @return
     */
    public String getPictureInfoList(String pictureName, String status, String edit_time, String editend_time, String page, String limit) {
        int pageI = (page == null ? 1 : Integer.valueOf(page));
        int limitI = (limit == null ? 10 : Integer.valueOf(limit));
        String res = PictureService.getPictureInfoList(pictureName,status,edit_time,editend_time,(pageI - 1) * limitI, limitI);
        return StringHandler.getRetString(res);
    }

    public String getCategoryPicture() {
        Map<String, Object> map = new HashMap<String, Object>();
        String res = PictureService.getCategoryPicture();
        //获取有效的商品来源列表
        JSONArray categorySourceList = StringHandler.getRsOfResult(res);
        map.put("categorySourceList", categorySourceList);
        String outString = JSON.toJSONString(map);
        System.out.println("outString>>>>>>>>>>>>>>>>>>" + outString);
        return outString;
    }

    /**
     *
     * @param request
     * @param categoryId
     * @param imgId
     * @param pictureNameInfos
     * @return
     */
    public String savePictureInfo(HttpServletRequest request,String categoryId,String imgId, String pictureNameInfos) {
        String res = PictureService.savePictureInfo(request,categoryId,imgId, pictureNameInfos);
        return StringHandler.getRetString(res);
    }

    public String updatePictureStatus(String ids,String status){
        String res = PictureService.updatePictureStatus(ids,status);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param ids
     * @param status
     * @return
     */
    public String deletePictureInfo(String ids,String status){
        String res = PictureService.deletePictureInfo(ids, status);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param id
     * @param categoryName
     * @param categoryPicture
     * @param showImgIds
     * @return
     */
    public String EditPictureInfo(String id,String categoryName,String categoryPicture,String showImgIds){
        String res = PictureService.EditPictureInfo(id, categoryName, categoryPicture, showImgIds);
        return StringHandler.getRetString(res);
    }

    public String SelectPictureInfo(String id){
        String res = PictureService.SelectPictureInfo(id);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param id
     * @return
     */
    public String isCheckPictureCategory(String id){
        String res = PictureService.isCheckPictureCategory(id);
        return StringHandler.getRetString(res);
    }

    /**
     * 删除图片分类
     * @param id
     * @return
     */
    public String deletePictureCategory(String id){
        String res = PictureService.deletePictureCategory(id);
        return StringHandler.getRetString(res);
    }

    public String isDulplicate(String categoryName){
        String res = PictureService.isDulplicate(categoryName);
        return StringHandler.getRetString(res);
    }
}
