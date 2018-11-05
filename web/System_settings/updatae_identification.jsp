<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="staff_management.jsp">员工管理列表</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="staff_add.jsp">添加员工</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="role_management.jsp">角色管理列表</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="role_add.jsp">添加角色</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="section_management.jsp">部门管理列表</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="section_add.jsp">添加部门</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="operation_log.jsp">操作日志</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">个人设置</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="message_Management.jsp">消息管理</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px" >
                账号信息：
            </blockquote>

            <form>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>

                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">电子邮箱</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">手机号码</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>

                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" >部门</label>
                    <div class="layui-input-block" >
                        <select name="interest" lay-filter="aihao" style="width:20% ;height: 35px">
                            <option value=""></option>
                            <option value="0">写作</option>
                            <option value="1" selected>请选择部门</option>
                            <option value="2">游戏</option>
                            <option value="3">音乐</option>
                            <option value="4">旅行</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" >角色</label>
                    <div class="layui-input-block" >
                        <select name="interest" lay-filter="aihao" style="width:20% ;height: 35px">
                            <option value=""></option>
                            <option value="0">写作</option>
                            <option value="1" selected>请选择角色</option>
                            <option value="2">游戏</option>
                            <option value="3">音乐</option>
                            <option value="4">旅行</option>
                        </select>
                    </div>
                </div>



                <div style="margin-left:38%">
                    <button class="layui-btn">确定</button>
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
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>