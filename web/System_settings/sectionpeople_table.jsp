<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>
<%
    String id = request.getParameter("id");
%>
<script>
    var id = <%=id%>
        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#departmentInfo'
                ,url:'${ctx}/department?method=getdepementByid&id='+id
                ,limit:20
                ,limits:[20,50,100]
                ,height: 710
                ,cols: [[
                    {type:'checkbox', fixed: 'left'}
                    ,{field:'id', width:120, title: '排序',align:'center',  fixed: 'left', edit: 'text'}
                    ,{field:'nick_name', width:170, title: '姓名',align:'center'}
                    ,{field:'phone', width:200, title: '电话',align:'center' }
                    ,{field:'role_name', width:320, title: '角色',align:'center'}
                    ,{field:'department_name', width:320, title: '部门',align:'center'}
                    ,{fixed: 'right', width: 270, title: '操作',align:'center', toolbar: '#barDemo'}
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

    function edit(){
        var table =layui.table;
        var checkStatus = table.checkStatus('departmentInfo'),
            data = checkStatus.data;
        var selectCount = checkStatus.data.length;
        if(selectCount==0){
            layer.msg("请选择一条数据！");
            return false;
        };
        var ids = new Array(selectCount);
        for(var i=0; i<selectCount; i++){
            ids[i]=checkStatus.data[i].id;
        };
        window.location.href='staff_edit.jsp?ids='+ids;

    }
</script>
<script type="text/html" id="barDemo">

    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" onclick="edit()">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">操作日志</a>

   <%-- <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" href="operation_log.jsp">移除</a>--%>

</script>
    <div class="layui-body" >
        <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
            <div class="layui-elem-quote">
                <label id="">部门人员列表</label>
                <button class="layui-btn  layui-btn-sm" style="margin-left: 70%" onclick="history.go(-1)">返回</button>
            </div>
        </div>

        <div class="main-top">
            <!-- 表格显示-->
            <table class="layui-hide" id="departmentInfo"></table>
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