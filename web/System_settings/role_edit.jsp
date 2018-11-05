<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>
<%
    String ids = request.getParameter("ids");
%>
    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px" >
                编辑部门
            </blockquote>

            <form>
                <input name="id" id="id" lay-verify="title" autocomplete="off"  class="layui-input" type="hidden" style="width:20%;border-color: #0C0C0C">
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">部门名称</label>
                    <div class="layui-input-block">
                        <input name="department_name" id="department_name" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item " style="margin-left: 30%">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block" style="width:20% ;border-color: #0C0C0C">
                        <textarea placeholder="请输入内容" id="remarks" name="remarks" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div style="margin-left: 38%">
                    <button class="layui-btn" onclick="saveStaffInfo()">确定</button>
                    <button class="layui-btn">重置</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
</div>
</div>

<script>
    var ids = <%=ids%>
        $(document).ready(function () {
            $.ajax({
                type:"get",
                cache: false,
                async : false,
                dataType: "json",
                url : "${ctx}/department?method=sectionEdit&ids="+ids,
                success : function(data){
                    if (data.success = 1) {
                        document.getElementById("department_name").value=data.rs[0].department_name;
                        document.getElementById("id").value=ids;
                        document.getElementById("remarks").value=data.rs[0].remarks;
                    }
                }
            })
        });

    function saveStaffInfo() {

        $.ajax({
            type: "get",
            contentType : "application/json",
            url : "${ctx}/department?method=updatesectionInfo",
            data:{'jsonString':JSON.stringify($('form').serializeObject())},
            cache: false,
            async: false,
            dataType: "json",
            success : function(data){
                window.location.href="section_management.jsp";
                alert("修改成功")

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
