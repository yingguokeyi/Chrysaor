<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
	session.setAttribute("ctx", request.getContextPath());
//	if(StringUtils.isNotBlank(request.getParameter("token"))){
//		session.setAttribute("token", request.getParameter("token"));
//	}
//	if(request.getAttribute("token") != null){
//		session.setAttribute("token", (String)request.getAttribute("token"));
//	}
//	request.setAttribute("portal_server", ConfigurationHelper.getInstance().getValue(ConfigConstant.PORTAL_SERVER));
//	session.setAttribute("sessionUser", ActionHelper.getInstance().getSessionUser(request));
//	session.setAttribute("static_resource_server", "//mps-static.meitianhui.com/product");	//静态资源访问地址

//    String path = request.getContextPath();
//    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <title>运营平台</title>


    <!-- jQuery -->
    <script type="text/javascript" src="${ctx}/common/third-part/jquery-1.11.3.min.js"></script>

    <!-- Layui -->
    <link rel="stylesheet" type="text/css" href="${ctx}/layui/css/layui.css?t=1515376178738" />
    <script type="text/javascript" src="${ctx}/layui/layui.js?t=1515376178738"></script>


    <%--<script src="//res.layui.com/layui/dist/layui.js?t=1515376178738"></script>--%>
    <%--<link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css?t=1515376178738" media="all">--%>





    <script>


        layui.use('element',function () {
            var element = layui.element;
        });


        /**
         * 自动将form表单封装成json对象
         */
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [ o[this.name] ];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };

    </script>


</head>