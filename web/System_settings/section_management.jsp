<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/Sys_menu.jsp"%>
<% String path = request.getContextPath();%>

<script>
    // $(":checkbox").on("change",function(){
    //     var $checkbox = $(this);
    //     console.log($('input:checked').length);
    // });

    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });

    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#departmentInfo'
            ,url:'${ctx}/department?method=getDepartmentInfo'
            ,limit:20
            ,limits:[20,50,100]
            ,height: 770
            ,cols: [[
                {type:'checkbox', fixed: 'left'}
                ,{field:'department_sort', width:100, title: '排序',align:'center',  fixed: 'left', edit: 'text'}
                ,{field:'department_name', width:150, title: '部门名称',align:'center'}
                ,{field:'department_code', width:150, title: '部门编码',align:'center'}
                ,{field:'pel_num', width:150, title: '人数',align:'center' }
                ,{field:'remarks', width:250, title: '备注',align:'center'}
                ,{field:'create_user', width:100, title: '创建人',align:'center'}
                ,{field:'create_time', width:200, title: '创建时间',align:'center',templet:function (d) {
                        var index="";
                        if(d.create_time==""){
                            index="----";
                        }else{
                            index="20"+d.create_time.substr(0,2)+"-"+d.create_time.substr(2,2)+"-"+d.create_time.substr(4,2)+" "+d.create_time.substr(6,2)+":"+d.create_time.substr(8,2)+":"+d.create_time.substr(10,2);
                        }
                        return index;
                    }}
                ,{field:'edit_user', width:100, title: '操作人',align:'center'}
                ,{field:'edit_time', width:200, title: '操作时间',align:'center',templet:function (d) {
                            var index="";
                            if(d.edit_time==""){
                                index="----";
                            }else{
                                index="20"+d.edit_time.substr(0,2)+"-"+d.edit_time.substr(2,2)+"-"+d.edit_time.substr(4,2)+" "+d.edit_time.substr(6,2)+":"+d.edit_time.substr(8,2)+":"+d.edit_time.substr(10,2);
                            }
                            return index;
                        }}
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
            ,id:'departmentInfoReload'
        });
        // 此处监听无法达到目的
        // table.on('checkbox(departmentInfoFilter)', function(obj){
        //
        //     var data = obj.data;
        //     alert("  data   "+data.id + "  obj.event "+obj.event);
        //
        //     if (obj.event === 'deponUser') {
        //         window.location.href="sectionpeople_table.jsp?id="+data.id+"&department_name="+data.department_name
        //     }
        // });


        var $ = layui.$, active = {
            DepartmentInfo_Sort:function () {
                var checkStatus = table.checkStatus('departmentInfoReload'),
                    data = checkStatus.data;
                var selectCount = checkStatus.data.length;
                if(selectCount==0){
                    layer.msg("请选择一条数据！");
                    return false;
                };
                var ids = "";
                var department_name = "";
                var ids = "";
                for(var i=0; i<selectCount; i++){
                    ids=checkStatus.data[i].id;
                    department_name=checkStatus.data[i].department_name;
                    ids[i]=checkStatus.data[i].id;
                };
            },
            DepartmentInfo_Del:function () {
                var checkStatus = table.checkStatus('departmentInfoReload'),
                    data = checkStatus.data;
                var selectCount = checkStatus.data.length;
                if(selectCount==0){
                    layer.msg("请选择一条数据！");
                    return false;
                };
                layer.confirm('确定删除该角色？',function(index){
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
                        url : "${ctx}/department?method=deletedepartment&ids="+ids,
                        success : function(data){
                            if (data.success = 1) {
                                layer.msg('删除成功');
                                table.reload("departmentInfo")
                            }
                        }
                    });

                });
            },
            DepartmentInfo_Edit:function () {
                var checkStatus = table.checkStatus('departmentInfoReload'),
                    data = checkStatus.data;
                var selectCount = checkStatus.data.length;
                if(selectCount==0){
                    layer.msg("请选择一条数据！");
                    return false;
                };
                var ids = "";
                var department_name = "";
                var department_code = "";
                var remarks = "";
                for(var i=0; i<selectCount; i++){
                    ids=checkStatus.data[i].id;
                    department_name=checkStatus.data[i].department_name;
                    department_code=checkStatus.data[i].department_code;
                    remarks=checkStatus.data[i].remarks;
                };
                layer.open({
                    type: 1
                    , title: '部门信息'
                    , id: 'layerDemo'
                    , area: ['500px']
                    , content: $('#departmentDetailInfo_Div')
                    ,btn: ['保存','关闭']
                    , btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    , yes: function () {
                        $.ajax({
                            type:"get",
                            cache: false,
                            async : false,
                            dataType: "json",
                            url : "${ctx}/department?method=updatesectionInfo",
                            data:{'id':ids,'department_name':$("#department_name").val(),'department_code':$("#department_code").val(),'remarks':$("#remarks").val()},
                            success : function(res){
                                if (res.success = 1) {
                                    layer.closeAll();
                                    layer.msg('保存成功');
                                    table.reload("departmentInfoReload");
                                }
                            }
                        });
                    }
                    ,btn2:function () {
                        layer.closeAll();
                    }
                    ,success:function () {
                        $("#department_name").val(department_name);
                        $("#department_code").val(department_code);
                        $("#remarks").text(remarks);
                    }
                });
            }
        };

        $('.departmentManageDiv .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });


    function forbidden(){

    }

</script>
<script type="text/html" id="barDemo">

   <%-- <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius"  lay-event="deponUser">成员列表</a>
   --%> <a href="sectionpeople_table.jsp?id={{d.id}}"><button  lay-event="agree" style="height: 20px;line-height: 20px;width:100px;background-color:#1E9FFF;text-align:center;font-size: 12px;color: #FFFFFF;border-radius:20px;border:none">成员列表</button></a>

</script>
<div class="layui-body">
    <div style="padding:5px 5px 0px 5px">
        <div class="layui-elem-quote">
            部门列表
        </div>
        <!-- 表单集合-->
        <!-- 上部分查询表单-->
        <div class="layui-inline departmentManageDiv"  style="margin-top: 5px">
            <button class="layui-btn  layui-btn-sm" data-type="DepartmentInfo_Sort" id="DepartmentInfo_Sort"><i class="layui-icon">&#xe614;</i>确认排序</button>
            <button class="layui-btn  layui-btn-sm" data-type="DepartmentInfo_Del" id="GoodsTypeInfo_Del"><i class="layui-icon">&#xe640;</i>删除</button>
            <button class="layui-btn  layui-btn-sm" data-type="DepartmentInfo_Edit" id="DepartmentInfo_Edit"><i class="layui-icon">&#xe642;</i>编辑</button></a>
        </div>
     <!-- 表格显示-->
    <table class="layui-hide" id="departmentInfo" lay-filter="departmentInfoFilter"></table>

</div>
<div id="departmentDetailInfo_Div" style="display: none; padding: 15px;">
    <form class="layui-form layui-form-pane" action="">
        <div class="layui-form-item">
            <label class="layui-form-label"><label style="color: red">*</label>部门名称:</label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="department_name" id="department_name">
            </div>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label"><label style="color: red">*</label>部门编码:</label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="department_code" id="department_code">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" class="layui-textarea" id="remarks" name="remarks"></textarea>
            </div>
        </div>
    </form>
</div>

<%@ include file="/common/footer.jsp"%>