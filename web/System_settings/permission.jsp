<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>layout 后台大布局 - Layui</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/member-main.css">
    <script src="layui/layui.js" charset="utf-8"></script>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <style>
        .linefg{
            width: 1000px;
            height: 1px;
            background: #0C0C0C;
            margin-top:10px ;
        }

    </style>
</head>
    <%@include file="../common/header.jsp"%>
    <%@include file="../common/Sys_menu.jsp"%>

    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px;" >
               系统管理员-角色权限设置
                <a href="staff_add.jsp"><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ; margin-left: 70%">角色列表</button></a>
            </blockquote>
        </div>
        <div style="margin-left: 20px">
            <input type="checkbox" name="" >  系统设置权限
            <div class="linefg"></div>
            <input type="checkbox" name="" >  1
            <input type="checkbox" name="" style="margin-left: 100px">  2
            <input type="checkbox" name="" style="margin-left: 100px">  3
        </div>

        <div style="margin-left: 20px;margin-top: 100px">
            <input type="checkbox" name="" >  商品中心权限
            <div class="linefg"></div>
            <input type="checkbox" name="" >  1
            <input type="checkbox" name="" style="margin-left: 100px">  2
            <input type="checkbox" name="" style="margin-left: 100px">  3
        </div>


        <div style="margin-left: 20px;margin-top: 100px">
            <input type="checkbox" name="" >  仓储物流权限
            <div class="linefg"></div>
            <input type="checkbox" name="" >  1
            <input type="checkbox" name="" style="margin-left: 100px">  2
            <input type="checkbox" name="" style="margin-left: 100px">  3
        </div>


        <div style="margin-left: 20px;margin-top: 100px">
            <input type="checkbox" name="" >  库房权限
            <div class="linefg"></div>
            <input type="checkbox" name="" >  1
            <input type="checkbox" name="" style="margin-left: 100px">  2
            <input type="checkbox" name="" style="margin-left: 100px">  3
        </div>


        <div style="margin-left: 20px;margin-top: 100px;background-color: #ababab;width: 50%">
            <input type="checkbox" name="" >  订单权限
            <div class="linefg"></div>

            <div style="margin-left: 20px;margin-top: 20px">
                <input type="checkbox" name="" >  已确认订单管理
                <div class="linefg"></div>
                <input type="checkbox" name="" >  1
                <input type="checkbox" name="" style="margin-left: 100px">  2
                <input type="checkbox" name="" style="margin-left: 100px">  3
            </div>


            <div style="margin-left: 20px;margin-top: 70px">
                <input type="checkbox" name="" >  完成备货订单管理
                <div class="linefg"></div>
                <input type="checkbox" name="" >  1
                <input type="checkbox" name="" style="margin-left: 100px">  2
                <input type="checkbox" name="" style="margin-left: 100px">  3
            </div>
        </div>

        <div style="margin-left:60px;margin-top: 30px">
            <button class="layui-btn" >确定</button>
            <button class="layui-btn" style="margin-left: 30px">重置</button>
        </div>
    </div>

</div>


<div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
</div>
</div>

<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>