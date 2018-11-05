<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@include file="../common/header.jsp"%>
    <%@include file="../common/Sys_menu.jsp"%>
    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px" >
                基本信息：
            </blockquote>

            <form>
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <label class="layui-form-label">社会摇</label>
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">登陆密码</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20%;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">Email</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off"  class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-left: 30%">
                    <label class="layui-form-label">座机</label>
                    <div class="layui-input-block">
                        <input name="title" lay-verify="title" autocomplete="off" class="layui-input" type="text" style="width:20% ;border-color: #0C0C0C">
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
                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" >所属组</label>
                    <div class="layui-input-block" >
                        <select name="interest" lay-filter="aihao" style="width:20% ;height: 35px; ">
                            <option value=""></option>
                            <option value="0">写作</option>
                            <option value="1" selected>选择角色</option>
                            <option value="2">游戏</option>
                            <option value="3">音乐</option>
                            <option value="4">旅行</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item layui-form-text" style="margin-left: 30%">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block" style="width:20% ;border-color: #0C0C0C">
                        <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
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