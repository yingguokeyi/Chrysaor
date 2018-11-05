<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
    <%@include file="../common/Sys_menu.jsp"%>
<%
    String id = request.getParameter("id");
%>
    <div class="layui-body" >
        <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 角色列表  </label>
            <a href="role_add.jsp"><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ; margin-left: 75%">添加角色</button></a>
        </div>

        <div class="main-top">
            <!-- 表格显示-->
            <table class="layui-hide" id="departmentInfo"></table>

            <script>
                var id = <%=id%>
                layui.use('table', function(){
                    var table = layui.table;

                    table.render({
                        elem: '#departmentInfo'
                        ,url:'${ctx}/role?method=getRoleByid&id='+id
                        ,limit:20
                        ,limits:[20,50,100]
                        ,height: 710
                        ,cols: [[
                            {type:'checkbox', fixed: 'left'}
                            ,{field:'id', width:100, title: '排序',align:'center',  fixed: 'left', edit: 'text'}
                            ,{field:'nick_name', width:150, title: '姓名',align:'center'}
                            ,{field:'phone', width:150, title: '电话',align:'center' }
                            ,{field:'role_name', width:300, title: '角色',align:'center'}
                            ,{field:'department_name', width:300, title: '部门',align:'center'}
                            ,{fixed: 'right', width: 250, title: '操作',align:'center', toolbar: '#barDemo'}
                        ]]
                        ,page: true //开启分页
                        ,response: {
                            statusName: 'success' //数据状态的字段名称，默认：code
                            ,statusCode: 1  //成功的状态码，默认：0
                            ,msgName: 'errorMessage' //状态信息的字段名称，默认：msg
                            ,countName: 'total' //数据总数的字段名称，默认：count
                            ,dataName: 'rs' //数据列表的字段名称，默认：data
                        }

                    });
                });
            </script>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" href="permission.jsp">编辑</a>
                <a class="layui-btn layui-btn-xs" lay-event="edit">操作日志</a>
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" href="operation_log.jsp">移除</a>
            </script>
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