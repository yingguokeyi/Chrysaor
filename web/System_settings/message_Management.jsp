<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="advertising.jsp">广告管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="top_search.jsp">热搜管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="message_Management.jsp">消息管理</a>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body" >
        <div style="background-color: #EEEEEE ;height: 50px;margin-top: 10px;margin-left: 10px">
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 消息管理列表  </label>
            <a href=""><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ;margin-left: 70%">返回</button></a>
            <a href="messageType_add.jsp"><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ; margin-left: 20px">添加消息</button></a>
        </div>
        <!-- 上部分查询表单-->
        <div class="main-top" style="background-color:#EEEEEE;width:100%;margin-top: 20px;margin-left: 10px">
            <form class="layui-form" action=""  style="margin-top:10px;">
                <div class="layui-form-item">
                    <div class="layui-inline">

                        <div class="layui-input-inline" style="margin-left: 20px ;margin-top: 10px">
                            <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">

                        <div class="layui-input-inline" style="margin-left: 20px ;margin-top: 10px">
                            <select name="modules" lay-verify="required" lay-search="">
                                <option value="">所有状态</option>
                                <option value="1">启用</option>
                                <option value="2">禁用</option>
                            </select>
                        </div>

                        <button class="layui-btn" style="margin-left: 20px ;margin-top: 10px;background-color: #ababab">搜索</button>


                    </div>
                </div>

            </form>
        </div>
        <!-- 中部表单 -->
        <div class="main-top "style="margin-left: 10px;background-color:#EEEEEE ;height: 40px;line-height: 40px">
            <button class="layui-btn layui-btn-primary layui-btn-sm" style="margin-left: 20px">禁用</button>
            <button class="layui-btn layui-btn-primary layui-btn-sm" >启用</button>

            <button class="layui-btn layui-btn-primary layui-btn-sm">删除</button>

            <button class="layui-btn layui-btn-primary layui-btn-sm">排序</button>
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
                            ,{field:'id', width:300, title: '消息内容',  fixed: 'left'}
                            ,{field:'username', width:150, title: '推送位置'}
                            ,{field:'sex', width:150, title: '状态' }
                            ,{field:'city', width:250, title: '开始时间'}
                            ,{field:'sign', width: 250, title: '结束时间'}
                            ,{field:'experience', width:150, title: '更新时间'}
                            ,{field:'score', width:150, title: '最后操作人'}

                            ,{fixed: 'right', width: 200, title: '操作', align:'center', toolbar: '#barDemo'}
                        ]]
                        ,page: true
                    });
                });
            </script>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" href="">修改</a>
                <a class="layui-btn layui-btn-xs" lay-event="edit" href="">查看</a>

            </script>
        </div>
    </div>

<div class="layui-footer">
    <%@ include file="/common/footer.jsp"%>
</div>

<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>