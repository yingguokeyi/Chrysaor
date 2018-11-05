<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>

    <%@include file="../common/Sys_menu.jsp"%>

    <div class="layui-body" >
        <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 操作日志 </label>

        </div>
        <!-- 上部分查询表单-->
        <div class="main-top" style="background-color:#EEEEEE;width:100%;margin-top: 20px;margin-left: 10px">
            <div class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF;margin-left: 20px;margin-top: 10px">搜索</div>
            <div class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ;margin-top: 10px">重置</div>
            <form class="layui-form" action=""  style="margin-top:10px;">
                <div class="layui-form-item">
                    <div class="layui-inline" style="position: relative;right: 40px">
                        <label class="layui-form-label">账号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item" style="position: absolute;left:300px;top: 130px;">
                        <div class="layui-inline">
                            <label class="layui-form-label">操作时间</label>
                            <div class="layui-input-inline">
                                <input type="date" class="layui-input" id="test15" >
                            </div>
                            <span style="line-height:40px;">~</span>
                        </div>

                        <div class="layui-inline" id="date">
                            <div class="layui-input-inline">

                                <input type="date" class="layui-input" id="test15" >
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline" style="position: relative;right: 40px">
                            <label class="layui-form-label">模块</label>
                            <div class="layui-input-inline">
                                <select name="modules" lay-verify="required" lay-search="">
                                    <option value="">读取部门列表</option>
                                    <option value="1">启用</option>
                                    <option value="2">禁用</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-inline" style="position: absolute;left:300px;top: 170px;">
                        <label class="layui-form-label">关键词</label>
                        <div class="layui-input-inline">
                            <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- 中部表单 -->
        <div class="main-top "style="margin-left: 10px">
            <button class="layui-btn layui-btn-primary layui-btn-sm" >禁用</button>

        </div>
        <div class="main-top">
            <!-- 表格显示-->
            <table class="layui-hide" id="test"></table>

            <script>
                layui.use('table', function(){
                    var table = layui.table;

                    table.render({
                        elem: '#test'
                        ,url:'./demo/table/user.json'
                        ,width: 1720
                        ,height: 600
                        ,cols: [[
                            {field:'', width:20, fixed: 'left'}
                            ,{type:'checkbox', fixed: 'left'}
                            ,{field:'id', width:150, title: '用户名',  fixed: 'left'}
                            ,{field:'username', width:250, title: '手机号'}
                            ,{field:'sex', width:300, title: 'IP地址' }
                            ,{field:'city', width:150, title: '模块'}
                            ,{field:'sign', width: 350, title: '操作内容'}
                            ,{field:'experience', width:300, title: '最后操作时间'}

                        ]]
                        ,page: true
                    });
                });
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