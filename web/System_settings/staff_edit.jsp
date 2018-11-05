<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>
<%
    String ids = request.getParameter("ids");
%>
<script>
    var ids = <%=ids%>
        $(document).ready(function () {
          // 查询编辑信息
            $.ajax({
                type:"get",
                cache: false,
                async : true,
                dataType: "json",
                url : "${ctx}/user?method=stratuserecho&ids="+ids,
                success : function(data){
                    if (data.success = 1) {
                        document.getElementById("gaia_id").value=data.rs[0].gaia_id;
                        document.getElementById("id").value=ids;
                        document.getElementById("nick_name").value=data.rs[0].nick_name;
                       // document.getElementById("login_name").value=data.rs[0].login_name;
                       // document.getElementById("old_password").value=data.rs[0].password;
                        //document.getElementById("job_phone").value=data.rs[0].job_number;
                        document.getElementById("phone").value=data.rs[0].phone;
                        document.getElementById("email").value=data.rs[0].e_mail;
                        document.getElementById("department").value=data.rs[0].department_id;
                        // for (var obj in role_id){
                        //     if(role_id[obj]==data.rs[0].role_id){
                        //         $("#role").find("option[value = '"+data.rs[0].role_id+"']").attr("selected","selected");
                        //     }
                        // }
                        document.getElementById("memo").value=data.rs[0].login_name;
                    }
                }
            });

            var role_id=new Array();
            //获取部门信息
            $.ajax({
                type: "get",
                contentType : "application/json",
                url : "${ctx}/department?method=getDepartmentInfoToSel",
                cache: false,
                async: true,
                dataType: "json",
                success : function(data){
                    if(data.success == 1) {
                        var array = data.rs;
                        for (var obj in array) {
                            if(array[obj].department_id==data.rs[0].department_id){
                                $("#department").append("<option   value='"+array[obj].department_id+"'>"+array[obj].id+"_"+array[obj].department_name+"</option>");
                                role_id[obj]=array[obj].id;
                                $("#depId").val(array[obj].id);
                            }else{
                                $("#department").append("<option value='"+array[obj].id+"'>"+array[obj].id+"_"+array[obj].department_name+"</option>");
                                role_id[obj]=array[obj].id;
                            }
                        }
                    }
                }
            });
            //获取角色信息
            $.ajax({
                type: "get",
                contentType : "application/json",
                url : "${ctx}/role?method=getRoleInfoToSel",
                cache: false,
                async: true,
                dataType: "json",
                success : function(data){
                    if(data.success == 1) {
                        var array = data.rs;
                        for (var obj in array) {
                            if(array[obj].id == data.rs[0].id){
                                $("#role").append("<option  value='"+array[obj].id+"'>"+array[obj].role_name+"</option>");
                                $("#roleId").val(array[obj].id);
                            }else{
                                $("#role").append("<option value='"+array[obj].id+"'>"+array[obj].role_name+"</option>");
                            }

                        }
                    }
                }
            });

        });

</script>

<script>
    layui.use('form', function () {
        var form = layui.form;

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
                    window.location.href="staff_edit.jsp?ids="+ids;
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

<div class="layui-body" style="padding: 5px;" >
    <div >
        <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
            <div class="layui-elem-quote">
                <label id="">员工基本信息</label>
                <button class="layui-btn  layui-btn-sm" style="margin-left: 70%" onclick="history.go(-1)">返回</button>
            </div>
        </div>

        <form class="layui-form" >
            <input  id="gaia_id" name="gaia_id" autocomplete="off" class="layui-input" type="hidden"  style="width:20% ;border-color: #0C0C0C">
            <input  id="id" name="id" autocomplete="off" class="layui-input" type="hidden"  style="width:20% ;border-color: #0C0C0C">

            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>员工姓名</label>
                <div class="layui-input-block" style="width: 400px;">
                    <input type="text" id="nick_name" name="nick_name" placeholder="账号"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>账号</label>
                <div class="layui-input-block" style="width: 400px;">
                    <input type="text" id="login_name" name="login_name" placeholder="账号"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>密码</label>
            <div class="layui-input-block" style="width: 400px;">
                <input type="password" id="old_password" name="old_password" placeholder="原密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>


            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline" style="width: 400px;">
                    <input type="text" id="email" name="email"
                           placeholder="请输入Email"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>手机号</label>
                <div class="layui-input-inline" style="width: 400px;">
                    <input type="text" id="phone" name="phone"
                           placeholder="请输入确认新密码"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <input type="text" value="" id="depId" name="depId">
            <input type="text" value="" id="roleId" name="roleId">

            <div class="layui-form-item">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-inline" style="width: 400px;">
                    <textarea placeholder="请输入内容" id="memo" name="memo" class="layui-textarea"></textarea>
                </div>
            </div>

            <div style="margin-left:38%">

                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="formDemo">确定</button>
                <button class="layui-btn" id="reset" type="reset">重置</button>
            </div>

        </form>

        <div class="layui-form-item" >
            <label class="layui-form-label" >部门</label>
            <div class="layui-input-block" >
                <select name="department" id="department" style="width:20% ;height: 35px">
                    <%-- <option value="" selected>请选择部门</option>--%>
                </select>
            </div>
        </div>

        <div class="layui-form-item"  >
            <label class="layui-form-label" >角色</label>
            <div class="layui-input-block" >
                <select name="role" id="role" style="width:20% ;height: 35px">
                    <%--  <option value="" selected>请选择角色</option>--%>
                </select>
            </div>
        </div>

    </div>

</div>

</div>
<script>
    $('#department').change(function(){

        console.log($('#department').find('option:selected').val());
       // $('#department').find('option:selected').attr('selected', 'selected');
        $("#depId").val($('#department').find('option:selected').val());
    });

    $('#role').change(function(){
        console.log($('#role').find('option:selected').val());
        $("#roleId").val($('#role').find('option:selected').val());
        // $('#department').find('option:selected').attr('selected', 'selected');
    });


</script>


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