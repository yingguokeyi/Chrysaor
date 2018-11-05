<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>
<%@include file="../common/Sys_menu.jsp" %>
<script>
    function Map() {
        this.mapArr = {};
        this.arrlength = 0;

        //假如有重复key，则不存入
        this.put = function (key, value) {
            if (!this.containsKey(key)) {
                this.mapArr[key] = value;
                this.arrlength = this.arrlength + 1;
            }
        }
        this.get = function (key) {
            return this.mapArr[key];
        }

        //传入的参数必须为Map结构
        this.putAll = function (map) {
            if (Map.isMap(map)) {
                var innermap = this;
                map.each(function (key, value) {
                    innermap.put(key, value);
                })
            } else {
                alert("传入的非Map结构");
            }
        }
        this.remove = function (key) {
            delete this.mapArr[key];
            this.arrlength = this.arrlength - 1;
        }
        this.size = function () {
            return this.arrlength;
        }

        //判断是否包含key
        this.containsKey = function (key) {
            return (key in this.mapArr);
        }
        //判断是否包含value
        this.containsValue = function (value) {
            for (var p in this.mapArr) {
                if (this.mapArr[p] == value) {
                    return true;
                }
            }
            return false;
        }
        //得到所有key 返回数组
        this.keys = function () {
            var keysArr = [];
            for (var p in this.mapArr) {
                keysArr[keysArr.length] = p;
            }
            return keysArr;
        }
        //得到所有value 返回数组
        this.values = function () {
            var valuesArr = [];
            for (var p in this.mapArr) {
                valuesArr[valuesArr.length] = this.mapArr[p];
            }
            return valuesArr;
        }

        this.isEmpty = function () {
            if (this.size() == 0) {
                return false;
            }
            return true;
        }
        this.clear = function () {
            this.mapArr = {};
            this.arrlength = 0;
        }
        //循环
        this.each = function (callback) {
            for (var p in this.mapArr) {
                callback(p, this.mapArr[p]);
            }
        }
    };
    var deptSourceMap = new Map();
    var roleSourceMap = new Map();
    //JavaScript代码区域
    layui.use('table', function () {
        var table = layui.table;
        var form = layui.form;
        table.render({
            elem: '#staffListTab'
            , url: '${ctx}/user?method=getStaffInfoList'
            , limit: 20
            , limits: [20, 50, 100]
            , height: 600
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'login_name', title: '账号', fixed: 'left'}
                , {field: 'department_name', title: '部门'}
                // ,{field:'job_number', width:100, title: '工号',align:'center', templet:function (d) {
                //         var index=d.department_code+"_"+d.job_number;
                //         return index;
                //     }}
                , {field: 'nick_name', title: '姓名', align: 'center'}
                , {field: 'role_name', title: '角色', align: 'center'}
                , {field: 'STATUS', title: '状态', align: 'center', templet: '#status'}
                , {field: 'phone', title: '电话', align: 'center'}
                , {field: 'e_mail', title: 'E-mail', align: 'center'}
                /*,{field:'classify', width:200, title: '座机',align:'center'}*/
                , {
                    field: 'last_login_time', title: '最后登录时间', align: 'center', templet: function (d) {
                        var index = "";
                        if (d.last_login_time != "") {
                            index = 20 + d.last_login_time.substr(0, 2) + "-" + d.last_login_time.substr(2, 2) + "-" + d.last_login_time.substr(4, 2) + " " + d.last_login_time.substr(6, 2) + ":" + d.last_login_time.substr(8, 2) + ":" + d.last_login_time.substr(10, 2);
                        } else {
                            index = "----";
                        }

                        return index;
                    }
                }
            ]]
            , page: true //开启分页
            , response: {
                statusName: 'success' //数据状态的字段名称，默认：code
                , statusCode: 1  //成功的状态码，默认：0
                , msgName: 'errorMessage' //状态信息的字段名称，默认：msg
                , countName: 'total' //数据总数的字段名称，默认：count
                , dataName: 'rs' //数据列表的字段名称，默认：data
            }
            , id: 'staffListTabReload'
        });

        //点击按钮 搜索
        $('#searchBtn').on('click', function () {
            //执行重载
            table.reload('staffListTabReload', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    login_name: $('#login_name').val(),
                    nick_name: $('#nick_name').val(),
                    role: $('#role').val(),
                    department: $('#department').val(),
                }
            });
            return false;
        });

        $("#edit").on('click',function () {
            console.log("edit");
            var table = layui.table;
            var checkStatus = table.checkStatus('staffListTabReload'),
                data = checkStatus.data;
            var selectCount = checkStatus.data.length;
            if (selectCount == 0) {
                layer.msg("请选择一条数据！");
                return false;
            }

            if (selectCount > 1) {
                layer.msg("请选择一条数据！");
                return false;
            }

            var ids = new Array(selectCount);
            for (var i = 0; i < selectCount; i++) {
                ids[i] = checkStatus.data[i].id;
            };

            console.log(" 获取准备数据 ");
            $("#u_department").empty();
            $("#u_role").empty();

            //获取准备数据
            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/department",
                data: "method=getDepartmentRoleInfoToSel",
                dataType: "json",
                success: function (data) {
                    if (data.result == 'success') {
                        //获取来源
                        var array = data.deptSourceList;
                        if (array.length > 0) {
                            for (var obj in array) {
                                console.log(1)
                                $("#u_department").append("<option value='" + array[obj].department_id + "'>" + array[obj].department_name + "</option>");
                                deptSourceMap.put(array[obj].department_id, array[obj].department_name);
                            }
                        }
                        //
                        var brandSourceList = data.roleSourceList;
                        if (brandSourceList.length > 0) {
                            for (var obj in brandSourceList) {
                                $("#u_role").append("<option value='" + brandSourceList[obj].id + "'>" + brandSourceList[obj].role_name + "</option>");
                                roleSourceMap.put(brandSourceList[obj].id, brandSourceList[obj].role_name);
                            }
                        }
                        //(注意：需要重新渲染)
                        form.render('select');
                    } else {
                        layer.msg("异常3333");
                    }
                },
                error: function () {
                    layer.msg("错误brand");
                }
            });

            // 查看编辑信息
            $.ajax({
                type: 'get',
                url: "${ctx}/user?method=stratuserecho&ids=" + ids,
                contentType: "application/json",  //缺失会出现URL编码，无法转成json对象
                cache: true,
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.success = 1) {
                        document.getElementById("u_gaia_id").value = data.rs[0].gaia_id;
                        document.getElementById("u_id").value = ids;
                        document.getElementById("u_nick_name").value = data.rs[0].nick_name;
                        document.getElementById("u_login_name").value = data.rs[0].login_name;
                        document.getElementById("u_old_password").value = "aaaaaa";
                        document.getElementById("u_phone").value = data.rs[0].phone;
                        document.getElementById("u_email").value = data.rs[0].e_mail;
                        document.getElementById("u_department").value = data.rs[0].department_id;
                        document.getElementById("u_memo").value = data.rs[0].login_name;

                        var deptId = data.rs[0].department_id;
                        var roleId = data.rs[0].role_id;

                        // 部门
                        if (deptId && (deptSourceMap.size() > 0)) {
                            $("#u_department").empty();
                            deptSourceMap.each(function (value, key) {
                                console.log(" key "+key + " value "+value);
                                if (value == deptId) {
                                    $("#u_department").append("<option value='" + value + "' selected> " + " " + key + " " + "</option>");
                                } else {
                                    $("#u_department").append("<option value='" + value + "'> " + " " + key + " " + "</option>");
                                }
                            });

                            //角色
                            if (roleId && (roleSourceMap.size() > 0)) {
                                $("#u_role").empty();
                                roleSourceMap.each(function (value, key) {
                                    console.log(" key " + key + " value  " + value);
                                    if (value == roleId) {
                                        $("#u_role").append("<option value='" + value + "' selected> " +" "+ key + "</option>");
                                    } else {
                                        $("#u_role").append("<option value='" + value + "'> "+" " + key + "</option>");
                                    }
                                });
                            }
                        }
                    }
                },
                error: function () {
                    layer.msg("错误");
                }
            });

            var EditOpen = layer.open({
                type: 1,
                title: '编辑员工信息',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                btn: ['保存', '取消'],
                content: $('#updateEmployeeInfo'),
                yes: function (data) {
                    console.log("update");
                    var u_nick_name = $("#u_nick_name").val();
                    if (u_nick_name == "") {
                        layer.msg(" 员工姓名不能为空! ");
                        return false;
                    }
                    var u_login_name = $("#u_login_name").val();
                    if (u_login_name == "") {
                        layer.msg(" 账号不能为空! ");
                        return false;
                    }else if (u_login_name.length < 6) {
                        layer.msg(" 账号长度不能小于6位! ");
                        return false;
                    }
                    var flag = checkDulicate(u_login_name);
                    if (flag) {
                        layer.msg(" 此账号已经重复! ");
                        return false;
                    }

                    var u_old_password = $("#u_old_password").val();
                    if (u_old_password == "") {
                        layer.msg(" 密码不能为空! ");
                        return false;
                    }else if (u_old_password.length < 6) {
                        layer.msg(" 密码长度不能小于6位! ");
                        return false;
                    }

                    var u_phone = $("#u_phone").val();
                    if (u_phone == "") {
                        layer.msg(" 电话不能为空! ");
                        return false;
                    }
                    //手机号正则
                    var phoneReg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
                    //电话
                    if (!phoneReg.test(u_phone)) {
                        layer.msg('请输入有效的手机号码！');
                        return false;
                    }

                    $.ajax({
                        type: "get",
                        contentType : "application/json",
                        url : "${ctx}/user?method=updateSelfInfo",
                        data:{
                            'jsonString':JSON.stringify($('#updateEmployeeInfoForm').serializeObject())
                        },
                        cache: false,
                        async: false,
                        dataType: "json",
                        success : function(data){
                            layer.msg("员工信息编辑成功!");
                            console.log(data.msg);
                            layer.close(EditOpen);
                            table.reload("staffListTabReload");
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

                }, btn2: function () {

                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            });

        });

        $("#add").on('click',function () {

            var EditOpen = layer.open({
                type: 1,
                title: '添加员工信息',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                btn: ['新增', '取消'],
                content: $('#addEmployeeInfo'),
                yes: function (data) {
                    var u_nick_name = $("#i_nick_name").val();
                    if (u_nick_name == "") {
                        layer.msg(" 员工姓名不能为空! ");
                        return false;
                    }
                    // else if (u_nick_name.length <= 6) {
                    //     layer.msg(" 密码长度不能小于六位! ");
                    //     return false;
                    // }
                    var u_login_name = $("#i_login_name").val();
                    if (u_login_name == "") {
                        layer.msg(" 账号不能为空! ");
                        return false;
                    }else if (u_login_name.length < 6) {
                        layer.msg(" 账号长度不能小于六位! ");
                        return false;
                    }
                    var u_old_password = $("#i_old_password").val();
                    if (u_old_password == "") {
                        layer.msg(" 密码不能为空! ");
                        return false;
                    }else if (u_old_password.length < 6) {
                        layer.msg(" 密码长度不能小于六位! ");
                        return false;
                    }

                    var u_phone = $("#i_phone").val();
                    if (u_phone == "") {
                        layer.msg(" 电话不能为空! ");
                        return false;
                    }

                    //手机号正则
                    var phoneReg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
                    //电话
                    var phone = $.trim($('#i_phone').val());
                    if (!phoneReg.test(phone)) {
                        layer.msg('请输入有效的手机号码！');
                        return false;
                    }

                     var flag = checkDulicate(u_login_name);
                    if (flag == true) {
                        layer.msg("  此账号已经重复！  ");
                        return false;
                    }

                    $.ajax({
                        type: "get",
                        contentType : "application/json",
                        url : "${ctx}/user?method=addStaffInfo",
                        data:{
                            'jsonString':JSON.stringify($('#addEmployeeInfoForm').serializeObject())
                        },
                        cache: false,
                        async: false,
                        dataType: "json",
                        success : function(data){
                            layer.msg("员工信息添加成功!");
                            console.log(data.msg);
                            layer.close(EditOpen);
                            table.reload("staffListTabReload");
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
                }, btn2: function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            });
            $("#i_nick_name").val("");
            $("#i_login_name").val("");
            $("#i_old_password").val("");
            $("#i_phone").val("");
            $('#i_email').val("");
            $('#i_memo').val("");
            $("#i_department").empty();
            $("#i_role").empty();
            //获取部门信息
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "${ctx}/department?method=getDepartmentInfoToSel",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.success == 1) {
                        var array = data.rs;
                        for (var obj in array) {
                            $("#i_department").append("<option value='" + array[obj].department_id + "'>" + array[obj].department_name + "</option>");
                        }
                    }
                }
            });

            //获取角色信息
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "${ctx}/role?method=getRoleInfoToSel",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.success == 1) {
                        var array = data.rs;
                        for (var obj in array) {
                            $("#i_role").append("<option value='" + array[obj].id + "'>" + array[obj].role_name + "</option>");

                        }
                    }
                }
            });
        });
        // 验证账号是否重复
        function checkDulicate(loginName) {
            var flag = false;
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "${ctx}/department?method=checkDuplicate",
                data:{
                  loginName:loginName
                },
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    console.log(data.msg);
                    if (data.msg == 1) {
                        console.log(1);
                        flag = true;
                        //layer.msg(" ");
                    } else if (data.msg == 0) {
                        //layer.msg(" ");
                        console.log(0);
                    }
                }
            });
            return flag;
        }
    });

    function forbidden() {

        var table = layui.table;
        var checkStatus = table.checkStatus('staffListTabReload'),
            data = checkStatus.data;
        var selectCount = checkStatus.data.length;
        if (selectCount == 0) {
            layer.msg("请选择一条数据！");
            return false;
        }
        ;
        layer.confirm('确定禁用该账号？', function (index) {
            //obj.del();//删除对应行（tr）的DOM结构，并更新缓存
            layer.close(index);
            var ids = new Array(selectCount);
            for (var i = 0; i < selectCount; i++) {
                ids[i] = checkStatus.data[i].id;
            }
            ;

            $.ajax({
                type: "get",
                cache: false,
                async: false,
                dataType: "json",
                url: "${ctx}/user?method=forbidden&ids=" + ids,
                success: function (data) {
                    if (data.success = 1) {
                        layer.msg('禁用成功');
                        table.reload("staffListTabReload")
                    }
                }
            })

        });
    }

    function startuser() {
        var table = layui.table;
        var checkStatus = table.checkStatus('staffListTabReload'),
            data = checkStatus.data;
        var selectCount = checkStatus.data.length;
        if (selectCount == 0) {
            layer.msg("请选择一条数据！");
            return false;
        }
        ;
        layer.confirm('确定启用该账号？', function (index) {
            //obj.del();//删除对应行（tr）的DOM结构，并更新缓存
            layer.close(index);
            var ids = new Array(selectCount);
            for (var i = 0; i < selectCount; i++) {
                ids[i] = checkStatus.data[i].id;
            }
            ;

            $.ajax({
                type: "get",
                cache: false,
                async: false,
                dataType: "json",
                url: "${ctx}/user?method=stratuser&ids=" + ids,
                success: function (data) {
                    if (data.success = 1) {
                        layer.msg('启用成功');
                        table.reload("staffListTabReload")
                    }
                }
            })

        });
    }

</script>
<script type="text/html" id="status">
    {{# if(d.STATUS=='1'){}}
    <span>可用</span>

    {{# }else if(d.STATUS=='0'){ }}
    <span style="color:#FF0000; ">已禁用</span>
    {{# } }}
</script>
<script>
    $(document).ready(function () {
        //获取部门信息
        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "${ctx}/department?method=getDepartmentInfoToSel",
            cache: false,
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.success == 1) {
                    var array = data.rs;
                    for (var obj in array) {
                        $("#department").append("<option value='" + array[obj].department_id + "'>" + array[obj].department_name + "</option>");
                    }
                }
            }
        });
        //获取角色信息
        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "${ctx}/role?method=getRoleInfoToSel",
            cache: false,
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.success == 1) {
                    var array = data.rs;
                    for (var obj in array) {
                        $("#role").append("<option value='" + array[obj].id + "'>" + array[obj].role_name + "</option>");

                    }
                }
            }
        });
    });
</script>
<div class="layui-layout layui-layout-admin">
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 20px;">
            <div class="layui-row">
                <div class="layui-elem-quote" style="background-color: #EEEEEE">
                    <label>员工管理列表</label>
                </div>

                <form class="layui-form layui-form-pane" action="">
                    <div style="background-color: #f2f2f2;padding:5px 0">
                        <div class="layui-form-item" style="margin-bottom:5px">
                            <div class="layui-inline">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="login_name" autocomplete="off" class="layui-input"
                                           placeholder="请输入账号">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="nick_name" autocomplete="off" class="layui-input"
                                           placeholder="请输入姓名">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item" style="margin-bottom: 0">

                            <div class="layui-inline">
                                <label class="layui-form-label">角色</label>
                                <div class="layui-input-inline">
                                    <select name="role" id="role" style="width:20% ;height: 35px">
                                        <option value="" selected>请选择角色</option>
                                    </select>
                                </div>
                            </div>

                            <div class="layui-inline">
                                <label class="layui-form-label">部门</label>
                                <div class="layui-input-inline">
                                    <select name="department" id="department" lay-filter="aihao"
                                            style="width:20% ;height: 35px">
                                        <option value="" selected>请选择部门</option>
                                    </select>
                                </div>
                            </div>
                            <%--<div class="layui-input-inline">--%>
                            <%--<input type="checkbox" id="showStopSale" name="showStopSale" value="" title="有停售规格">--%>
                            <%--</div>--%>
                            <button class="layui-btn layui-btn-sm" style="margin-left:10px;" id="searchBtn"><i
                                    class="layui-icon">&#xe615;</i>搜索
                            </button>
                            <button type="reset" class="layui-btn layui-btn-sm"><i class="layui-icon">&#x2746;</i>重置
                            </button>


                        </div>
                    </div>

                </form>

                <div>
                    <!-- 中部表单 -->
                    <div class="layui-inline staffInfoManage" style="margin-top: 10px;">
                        <button class="layui-btn  layui-btn-sm" onclick="forbidden()">禁用</button>
                        <button class="layui-btn  layui-btn-sm" onclick="startuser()">启用</button>
                        <button class="layui-btn  layui-btn-sm" id="edit" >编辑</button>
                        <%--<a href="staff_add.jsp"> <button class="layui-btn layui-btn-primary layui-btn-sm">添加员工</button></a>--%>
                        <button class="layui-btn  layui-btn-sm" id="add">添加员工</button>


                    </div>
                    <table class="layui-table" id="staffListTab" lay-filter="staffListFilter"></table>

                </div>

            </div>
        </div>

        <!-- 编辑员工页面 -->
    <form id="updateEmployeeInfoForm">
        <div id="updateEmployeeInfo" style="display: none;">
            <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
                <div class="layui-elem-quote">
                    <label id="">员工基本信息</label>
                </div>
            </div>

            <form class="layui-form">
                <input id="u_gaia_id" name="u_gaia_id" autocomplete="off" class="layui-input" type="hidden"
                       style="width:20% ;border-color: #0C0C0C">
                <input id="u_id" name="u_id" autocomplete="off" class="layui-input" type="hidden"
                       style="width:20% ;border-color: #0C0C0C">

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>员工姓名</label>
                    <div class="layui-input-block" style="width: 400px;">
                        <input type="text" id="u_nick_name" name="u_nick_name" placeholder="员工姓名"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>账号</label>
                    <div class="layui-input-block" style="width: 400px;">
                        <input type="text" id="u_login_name" name="u_login_name" placeholder="账号"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>重置密码</label>
                    <div class="layui-input-block" style="width: 400px;">
                        <input type="text" id="u_old_password" name="u_old_password" placeholder="密码"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-inline" style="width: 400px;">
                        <input type="text" id="u_email" name="u_email"
                               placeholder="请输入Email"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>手机号</label>
                    <div class="layui-input-inline" style="width: 400px;">
                        <input type="text" id="u_phone" name="u_phone"
                               placeholder="请输入手机号"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>

                <input type="hidden" value="" id="u_depId" name="u_depId">
                <input type="hidden" value="" id="u_roleId" name="u_roleId">

                <div class="layui-form-item">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-inline" style="width: 400px;">
                        <textarea placeholder="请输入内容" id="u_memo" name="u_memo" class="layui-textarea"></textarea>
                    </div>
                </div>

            </form>

            <div class="layui-form-item">
                <label class="layui-form-label">部门</label>
                <div class="layui-input-block">
                    <select name="u_department" id="u_department" style="width:20% ;height: 35px">
                        <%-- <option value="" selected>请选择部门</option>--%>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">角色</label>
                <div class="layui-input-block">
                    <select name="u_role" id="u_role" style="width:20% ;height: 35px">
                        <%--  <option value="" selected>请选择角色</option>--%>
                    </select>
                </div>
            </div>

        </div>
</form>

        <!-- 添加员工页面-->
    <form id="addEmployeeInfoForm">
            <div id="addEmployeeInfo" style="display: none;">
                <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
                    <div class="layui-elem-quote">
                        <label>员工基本信息</label>
                    </div>
                </div>

                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><label style="color: red">*</label>员工姓名</label>
                        <div class="layui-input-block" style="width: 400px;">
                            <input type="text" id="i_nick_name" name="i_nick_name" placeholder="员工姓名"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label"><label style="color: red">*</label>账号</label>
                        <div class="layui-input-block" style="width: 400px;">
                            <input onblur="" type="text" id="i_login_name" name="i_login_name" placeholder="账号"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label"><label style="color: red">*</label>初始化密码</label>
                        <div class="layui-input-block" style="width: 400px;">
                            <input type="text" id="i_old_password" name="i_old_password" placeholder="密码"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>


                    <div class="layui-form-item">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline" style="width: 400px;">
                            <input type="text" id="i_email" name="u_email"
                                   placeholder="请输入Email"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label"><label style="color: red">*</label>手机号</label>
                        <div class="layui-input-inline" style="width: 400px;">
                            <input type="text" id="i_phone" name="i_phone"
                                   placeholder="请输入手机号"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">备注</label>
                        <div class="layui-input-inline" style="width: 400px;">
                            <textarea placeholder="请输入内容" id="i_memo" name="i_memo" class="layui-textarea"></textarea>
                        </div>
                    </div>

                </form>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>部门</label>
                    <div class="layui-input-block">
                        <select name="i_department" id="i_department" style="width:20% ;height: 35px">
                            <%-- <option value="" selected>请选择部门</option>--%>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>角色</label>
                    <div class="layui-input-block">
                        <select name="i_role" id="i_role" style="width:20% ;height: 35px">
                            <%--  <option value="" selected>请选择角色</option>--%>
                        </select>
                    </div>
                </div>

            </div>
        </form>

    </div>
    <%@ include file="/common/footer.jsp" %>

