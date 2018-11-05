<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>
<%@include file="/common/Sys_menu.jsp"%>
<script>
    layui.use('form', function () {
        var form = layui.form;
        //自定义验证
        form.verify({
            pass: [
                /^[\S]{6,12}$/
                , '密码必须6到12位，且不能出现空格'
            ]
            , newPassword: function (value) {
                var $oldPasswordID = $("#old_password");
                if (value == $oldPasswordID.val()) {
                    return '新密码与旧密码相同,请更改新密码';
                }
            }
            , confirmNewPassword: function (value) {
                var $newPasswordID = $("#new_password");
                if (value != $newPasswordID.val()) {
                    return '两次输入的新密码不同';
                }
            }
            , landline: function (value) {
                var reg = new RegExp(/\d{3}-\d{8}|\d{4}-\d{7}/);
                if (!reg.test(value)) {
                    return '座机不正确,请输入格式为:区号+电话号码的数字';
                }
            }
        });
        //监听提交
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                type: "get",
                contentType : "application/json",
                url : "${ctx}/user?method=updateSelfInfo",
                data:{
                     'jsonString':JSON.stringify($('form').serializeObject())
                },
                cache: false,
                async: false,
                dataType: "json",
                success : function(data){
                 //layer.msg(data.msg);
                 alert(data.msg);
                 window.location.href="person_settings.jsp";
                }
                ,error:function (error) {
                    if(error.responseText!=""){
                        alert(error.responseText);
                        return false;
                    }else{
                        layer.closeAll();
                        layer.msg('添加失败');
                        return false;
                    }

                }
            });
        });
    });
</script>
<script type="application/javascript">

    $(document).ready(function(){

        $.ajax({
            type: "get",
            contentType : "application/json",
            url : "${ctx}/user?method=getUserName",
            cache: false,
            async: false,
            dataType: "json",
            success : function(data){
              //  alert("  data  "+ data.loginName);
                document.getElementById('username').innerHTML = data.loginName;
            }
            ,error:function (error) {
                if(error.responseText!=""){
                    console.log(error.responseText)

                    return false;
                }else{

                    return false;
                }

            }
        });

    });


</script>
<!-- 内容主体区域 -->
<div class="layui-body" style="padding: 30px;">
    <blockquote class="layui-elem-quote"> 修改个人资料</blockquote>
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">账号 </label>
            <label class="layui-form-label" style="text-align: left" id="username">11</label>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">旧密码</label>
            <div class="layui-input-inline" style="width: 400px;">
                <input type="password" name="old_password" id="old_password" required lay-verify="pass"
                       placeholder="请输入旧密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-inline" style="width: 400px;">
                <input type="password" name="new_password" id="new_password" required lay-verify="pass|newPassword"
                       placeholder="请输入新密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">确认新密码</label>
            <div class="layui-input-inline" style="width: 400px;">
                <input type="password" name="confirm_password" required lay-verify="pass|confirmNewPassword"
                       placeholder="请输入确认新密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block" style="width: 400px;">
                <input type="text" name="phone" required lay-verify="phone" placeholder="请输入手机号"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">座机</label>
            <div class="layui-input-block" style="width: 400px;">
                <input type="text" name="job_phone" required lay-verify="landline" placeholder="请输入座机"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">E-mail</label>
            <div class="layui-input-block" style="width: 400px;">
                <input type="text" name="email" required lay-verify="email" placeholder="请输入E-mail"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn">重置</button>
            </div>
        </div>
    </form>
    <%@ include file="/common/footer.jsp" %>
