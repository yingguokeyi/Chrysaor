<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="staff_management.jsp">广告管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="staff_add.jsp">热搜管理</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="role_management.jsp">消息管理</a>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body" >
        <div>
            <blockquote class="layui-elem-quote layui-text" style=" background-color: #EEEEEE; margin-top: 20px; height: 15px" >
                添加消息
            </blockquote>

            <form>

                <div class="layui-form-item" style="margin-left: 30%">
                    <label class="layui-form-label" >消息位置</label>
                    <div class="layui-input-block" >
                        <select name="interest" lay-filter="aihao" style="width:40% ;height: 35px">
                            <option value=""></option>
                            <option value="0">写作</option>
                            <option value="1" selected>请选择</option>
                            <option value="2">游戏</option>
                            <option value="3">音乐</option>
                            <option value="4">旅行</option>
                        </select>
                    </div>
                </div>


                <div class="layui-form-item layui-form-text" style="margin-left: 30%">
                    <label class="layui-form-label">消息内容</label>
                    <div class="layui-input-block" style="width:40% ;border-color: #0C0C0C">
                        <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div style="margin-left:30% ">
                    <label class="layui-form-label">推送时间:</label>
                </div>
                <div class="layui-form-item" style="margin-left: 30%;margin-top: 70px">
                    <div class="layui-inline">
                        <label class="layui-form-label">开始时间</label>
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

                <div  style="margin-left: 30%">
                    <label class="layui-form-label">推送时间</label>
                    <div class="layui-input-block" >
                        <input name="sex" value="3123131" title="男" checked="" type="radio" style="margin-top: 10px">不限结束时间
                        <input name="sex" value="312312313" title="女" type="radio" style="margin-top: 10px;margin-left: 20px">限制结束时间

                    </div>
                </div>



                <div style="margin-left:30%;margin-top: 100px">
                    <button class="layui-btn">添加</button>

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