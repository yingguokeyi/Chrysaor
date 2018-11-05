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
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 热搜词管理  </label>
            <a href="role_add.jsp"><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ; margin-left: 75%">添加热搜词</button></a>
        </div>
        <!-- 上部分查询表单-->
        <div class="main-top" style="background-color:#EEEEEE;width:100%;margin-top: 20px;margin-left: 10px;height: 50px;line-height: 50px">
            <div style="margin-left: 30px">
                <button class="layui-btn layui-btn-primary layui-btn-sm" style="margin-left: 20px">排序</button>

            </div>


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
                            ,{field:'id', width:300, title: '排序',  fixed: 'left'}
                            ,{field:'username', width:300, title: '热搜词'}
                            ,{field:'sex', width:300, title: '添加时间' }


                            ,{fixed: 'right', width: 250, align:'center',title: '操作', toolbar: '#barDemo'}
                        ]]
                        ,page: true
                    });
                });
            </script>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" href="">删除</a>


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