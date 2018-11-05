<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>
<script type="text/javascript">
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layer = layui.layer;

        //监听提交
        form.on('submit(department_Save)', function(data){
            $.ajax({
                type: "get",
                contentType : "application/json",
                url : "${ctx}/department?method=addDepartmentInfo&department_name="+$("#department_name").val()+"&remarks="+$("#remarks").val()+"&department_code="+$("#department_code").val(),
                cache: false,
                async: false,
                dataType: "json",
                success : function(data){
                    if(data.success){
                       // layer.closeAll();
                        alert(' 添加成功 ');
                        //layer.msg('添加成功');
                       // table.reload("departmentInfo")

                    }
                    window.location = "${pageContext.request.contextPath}/System_settings/section_management.jsp"
                    return false;
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
            return false;
        });


    });

</script>
<div class="layui-body" >
  <div>
    <div class="layui-elem-quote">添加部门信息</div>
    <form class="layui-form">
      <div style="margin-top: 30px">
         <div class="layui-form-item"  style="margin-left: 30%">
             <label class="layui-form-label"><label style="color: red">*</label>部门名称</label>
             <div class="layui-input-inline">
                 <input type="text" id="department_name" lay-verify="required" placeholder="请输入部门名称" autocomplete="off" class="layui-input">
             </div>
         </div>
         <div class="layui-form-item"  style="margin-left: 30%">
             <label class="layui-form-label"><label style="color: red">*</label>部门编码</label>
             <div class="layui-input-inline">
                 <input type="text" id="department_code" lay-verify="required" placeholder="请输入部门编码" autocomplete="off" class="layui-input">
             </div>
         </div>
         <div class="layui-form-item layui-form-text" style="margin-left: 30%">
             <label class="layui-form-label">备注</label>
             <div class="layui-input-inline">
                 <textarea placeholder="请输入内容" id="remarks" class="layui-textarea"></textarea>
             </div>
         </div>
         <div style="margin-left: 38%">
             <button class="layui-btn" lay-submit="" lay-filter="department_Save">确定</button>
             <button class="layui-btn">重置</button>
         </div>
      </div>
    </form>
  </div>
  <%@ include file="/common/footer.jsp"%>
</div>