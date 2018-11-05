<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
 <%@include file="../common/Sys_menu.jsp"%>

<script>
    $(document).ready(function () {
        //获取部门信息
        $.ajax({
            type: "get",
            contentType : "application/json",
            url : "${ctx}/department?method=getDepartmentInfoToSel",
            cache: false,
            async: false,
            dataType: "json",
            success : function(data){
                if(data.success == 1) {
                    var array = data.rs;
                    for (var obj in array) {
                        $("#department").append("<option value='"+array[obj].id+"'>"+array[obj].department_code+"_"+array[obj].department_name+"</option>");

                    }
                }
            }
        });
        //获取部门信息
        $.ajax({
            type: "get",
            contentType : "application/json",
            url : "${ctx}/role?method=getRoleInfoToSel",
            cache: false,
            async: false,
            dataType: "json",
            success : function(data){
                if(data.success == 1) {
                    var array = data.rs;
                    for (var obj in array) {
                        $("#role").append("<option value='"+array[obj].id+"'>"+array[obj].role_name+"</option>");

                    }
                }
            }
        });
    });

   function saveStaffInfo() {
         $.ajax({
                type: "get",
                contentType : "application/json",
                url : "${ctx}/user?method=addStaffInfo",
                data:{'jsonString':JSON.stringify($('form').serializeObject())},
                cache: false,
                async: false,
                dataType: "json",
                success : function(data){
                    alert("添加成功");
                    window.location.href="staff_management.jsp";
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
    }
</script>

<div class="layui-body" >
   <div>
       <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
           <div class="layui-elem-quote">
               <label id="">员工基本信息</label>
               <button class="layui-btn  layui-btn-sm" style="margin-left: 70%" onclick="history.go(-1)">返回</button>
           </div>
       </div>
         <form >
            <div style="margin-top: 30px">
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label"><label style="color: red">*</label>姓名</label>
                    <div class="layui-input-block">
                        <input name="nick_name" id="nick_name" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label"><label style="color: red">*</label>账号</label>
                    <div class="layui-input-block">
                        <input name="account_number" id="account_number" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label"><label style="color: red">*</label>登陆密码</label>
                    <div class="layui-input-block">
                        <input name="login_password" id="login_password" autocomplete="off"  class="layui-input" type="password" style="width:20%;border-color: #0C0C0C"><label id="login_password_error"></label>
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label"><label style="color: red"></label>邮箱</label>
                    <div class="layui-input-block">
                        <input name="email" id="email" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label"><label style="color: red">*</label>手机号</label>
                    <div class="layui-input-block">
                        <input name="phone_num" id="phone_num" lay-verify="title" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>

                <%--<div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">Email</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>--%>
                <%--<div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">座机</label>
                    <div class="layui-input-block">
                        <input name="landline_num" id="landline_num" lay-verify="title" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>--%>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" ><label style="color: red">*</label>部门</label>
                    <div class="layui-input-block" >
                        <select name="department" id="department" lay-filter="aihao" style="width:20% ;height: 35px">
                            <option value="0" selected>请选择部门</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" >角色</label>
                    <div class="layui-input-block" >
                        <select name="role" id="role" lay-filter="aihao" style="width:20% ;height: 35px">
                            <option value="0" selected>请选择角色</option>

                        </select>
                    </div>
                </div>

                <div class="layui-form-item layui-form-text" style="margin-left: 30%">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block" style="width:20% ;border-color: #0C0C0C">
                        <textarea placeholder="请输入内容" id="memo" name="memo" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div style="margin-left:38%">
                    <button class="layui-btn" id="save" onclick="saveStaffInfo()">确定</button>
                    <button class="layui-btn" id="reset">重置</button>
                </div>
                </div>
            </form>
        </div>
    </div>


<div class="layui-footer">
    <%@ include file="/common/footer.jsp"%>
</div>