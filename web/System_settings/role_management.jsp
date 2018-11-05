<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>

<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });

    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#departmentInfo'
            ,url:'${ctx}/role?method=getrolelist'
            ,limit:20
            ,limits:[20,50,100]
            ,height: 710
            ,cols: [[
                {type:'checkbox', fixed: 'left'}
                ,{field:'order_num', width:100, title: '排序',align:'center',  fixed: 'left', edit: 'text'}
                ,{field:'role_name', width:150, title: '角色名',align:'center'}
                ,{field:'num', width:150, title: '人数',align:'center' }
                ,{field:'memo', width:300, title: '备注',align:'center'}
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
            ,id:'staffListTabReload'
        });


    });

    function forbidden(){
        var table =layui.table;
        var checkStatus = table.checkStatus('staffListTabReload'),
            data = checkStatus.data;
        var selectCount = checkStatus.data.length;
        if(selectCount==0){
            layer.msg("请选择一条数据！");
            return false;
        };
        layer.confirm('确定删除该角色？',function(index){
            //obj.del();//删除对应行（tr）的DOM结构，并更新缓存
            layer.close(index);
            var ids = new Array(selectCount);
            for(var i=0; i<selectCount; i++){
                ids[i]=checkStatus.data[i].id;
            };
            $.ajax({
                type:"get",
                cache: false,
                async : false,
                dataType: "json",
                url : "${ctx}/role?method=deleterole&ids="+ids,
                success : function(data){
                    if (data.success = 1) {
                        layer.msg('删除成功');
                        table.reload("staffListTabReload")
                    }
                }
            })

        });
    }


    function edit(){
        var table =layui.table;
        var checkStatus = table.checkStatus('staffListTabReload'),
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
        window.location.href='role_edit.jsp?ids='+ids;

    }
</script>
<script type="text/html" id="barDemo">
    <a href="member_table.jsp?id={{d.id}}"><button  lay-event="agree" style="height: 20px;line-height: 20px;width:100px;background-color:#1E9FFF;text-align:center;font-size: 12px;color: #FFFFFF;border-radius:20px;border:none">成员列表</button></a>

</script>
<div class="layui-body" >
    <div style="padding: 20px;">
        <blockquote class="layui-elem-quote" style="margin-top: -10px">角色列表</blockquote>
        <!-- 上部分查询表单-->
        <div class="layui-inline roleInfoManage"style="margin-top: -5px">
            <button class="layui-btn  layui-btn-sm" ><i class="layui-icon">&#xe614;</i>确认排序</button>
            <button class="layui-btn  layui-btn-sm" onclick="forbidden()"><i class="layui-icon">&#xe640;</i>删除</button>
            <button class="layui-btn  layui-btn-sm" onclick="edit()"><i class="layui-icon">&#xe642;</i>编辑</button></a>
        </div>

        <!-- 表格显示-->
        <table class="layui-hide" id="departmentInfo" lay-filter="departmentInfoFilter"></table>
    </div>
    <div id="departmentDetailInfo_Div" style="display: none;margin-top: 5%">
        <div class="layui-form-item"  style="margin-left: 10%">
            <label class="layui-form-label"><label style="color: red">*</label>部门名称:</label>
            <div class="layui-inline">
                <input class="layui-input" type="text" name="department_name" id="department_name">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-left: 10%">
            <label class="layui-form-label"><label style="color: red">*</label>部门编码:</label>
            <div class="layui-inline">
                <input class="layui-input" type="text" name="department_code" id="department_code">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="margin-left: 10%">
            <label class="layui-form-label">备注:</label>
            <div class="layui-inline" style="width: 50%">
                <textarea placeholder="请输入内容" class="layui-textarea" id="remarks" name="remarks"></textarea>
            </div>
        </div>

    </div>

<%@ include file="/common/footer.jsp"%>