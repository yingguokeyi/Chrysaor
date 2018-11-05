<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">广告管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">热搜管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">消息管理</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div style="background-color: #9d9d9d ;height: 50px">
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 消息管理列表  </label>
            <a href="staff_add.jsp"><button class="layui-btn layui-btn-radius" style="background-color: #BBB5B5 ; margin-left: 60%">返回</button></a>
            <a href="staff_add.jsp"><button class="layui-btn layui-btn-radius" style="background-color: #BBB5B5 ;">添加消息</button></a>
        </div>
        <!-- 上部分查询表单-->
        <div class="main-top" style="background-color:#EEEEEE;height: 60px">


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
        <div class="main-top">
            <button class="layui-btn layui-btn-normal layui-btn-radius" style="background-color: #BBB5B5">禁用</button>
            <button class="layui-btn layui-btn-normal layui-btn-radius" style="background-color: #BBB5B5">启用</button>

            <button class="layui-btn layui-btn-primary layui-btn-radius">删除</button>

            <button class="layui-btn layui-btn-primary layui-btn-radius">排序</button>
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
                        ,height: 332
                        ,cols: [[
                            {field:'', width:20, fixed: 'left'}
                            ,{type:'checkbox', fixed: 'left'}
                            ,{field:'id', width:80, title: 'ID',  fixed: 'left'}
                            ,{field:'username', width:90, title: '会员姓名'}
                            ,{field:'sex', width:80, title: '账号' }
                            ,{field:'city', width:80, title: '手机号'}
                            ,{field:'sign', width: 80, title: '邀请码'}
                            ,{field:'experience', width:90, title: '会员类型'}
                            ,{field:'score', width:90, title: '账号状态'}
                            ,{field:'classify', width:80, title: 'E-mail'}
                            ,{field:'classify', width:90, title: '注册时间'}
                            ,{field:'classify', width:90, title: '注册来源'}
                            ,{field:'classify', width:90, title: '上级会员'}
                            ,{field:'classify', width:100, title: '下级会员人数'}
                            ,{field:'classify', width:90, title: '成交订单数'}
                            ,{field:'wealth', width:120, title: '操作', fixed: 'right'}
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