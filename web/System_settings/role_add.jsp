<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>

    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px" >
                添加角色
            </blockquote>

            <form class="layui-form">
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">角色名字</label>
                    <div class="layui-input-block">
                        <input id="role_name" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text" style="margin-left: 30%">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block" style="width:20% ;border-color: #0C0C0C">
                        <textarea placeholder="请输入内容" id="memo" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div style="margin-left: 38%">
                    <button class="layui-btn" onclick="Add()">确定</button>
                    <button class="layui-btn">重置</button>
                </div>
            </form>
        </div>
    </div>


<div class="layui-footer">
    <%@ include file="/common/footer.jsp"%>
</div>

<script type="text/javascript">

    function Add() {
        $.ajax({
            type: "get",
            contentType : "application/json",
            url : "${ctx}/role?method=addRoleInfo&role_name="+$("#role_name").val()+"&memo="+$("#memo").val(),
            cache: false,
            async: false,
            dataType: "json",
            success : function(data){

                    window.location.href="role_management.jsp";
                    alert("添加成功")
            }
            ,error:function (error) {
                if(error.responseText=="not_null"){
                    layer.msg('请填写部门名称、部门编号');
                    return false;
                }else if(error.responseText=="echo"){
                    layer.msg('填写的部门信息已存在，请重新填写');
                    return false;
                }else {
                    layer.closeAll();
                    layer.msg('添加失败');
                    return false;
                }
            }
        });
    }
</script>