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
            <label style="font-size: 18px;margin-left: 3% ; line-height: 50px" > 添加广告  </label>
            <a href=""><button class="layui-btn layui-btn-primary layui-btn-sm" style="background-color: #FFFFFF ;margin-left: 70%">返回</button></a>
        </div>
        <form class="layui-form" action="" style="margin-top: 50px">
            <div class="layui-form-item">
                <label style="font-size: 14px;margin-left: 100px">广告位：首页banner</label>
            </div>
            <div class="layui-form-item" style="margin-left: 50px">
                <label class="layui-form-label">广告名称:</label>
                <div class="layui-input-block">
                    <input style="width: 500px" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="广告名称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text" style="margin-left: 50px">
                <label class="layui-form-label">说明：</label>
                <div class="layui-input-block" style="width: 500px">
                    <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <label style="margin-left: 50px;font-size: 14px">目标广告位：&nbsp&nbsp&nbsp&nbsp请选择相同尺寸的广告位</label>
            <div class="layui-form-item layui-form-text" style="margin-left: 50px;width: 770px">

                <div class="layui-input-block" style="width: 450px;background-color: #9d9d9d;height: 300px;margin-top: 20px;float: left"></div>
                <div  style="width: 200px;background-color: #00F7DE;height: 300px;margin-top: 20px;float: right"></div>
            </div>
            <label style="margin-left: 50px;font-size: 14px">投放时间：</label>
            <div class="layui-form-item">
                <div class="layui-inline" style="margin-left: 50px;margin-top: 20px">
                    <label class="layui-form-label">开始时间</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="test11" placeholder="yyyy年MM月dd日" type="text">
                    </div>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="test14" placeholder="H点m分" type="text">
                    </div>
                </div>
            </div>
                <div class="layui-form-item">
                    <div class="layui-inline" style="margin-left: 50px;margin-top: 20px">
                        <label class="layui-form-label">结束时间</label>
                        <div class="layui-input-block">
                            <input name="sex" value="男" title="不限制结束时间" checked="" type="radio">
                            <input name="sex" value="女" title="限制结束时间" type="radio">
                        </div>
                        <div class="layui-form-item" style="margin-left: 110px">
                        <div class="layui-input-inline">
                            <input class="layui-input" id="test11" placeholder="yyyy年MM月dd日" type="text">
                        </div>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="test14" placeholder="H点m分" type="text">
                        </div>
                        </div>
                </div>
                </div>
                    <div class="layui-form-item">
                        <div class="layui-inline" style="margin-left: 50px;margin-top: 20px">
                            <label class="layui-form-label">广告类型</label>
                            <div class="layui-tab">
                                <ul class="layui-tab-title" style="width: 600px">
                                    <li><input name="sex" value="女" title="图片" type="radio"></li>
                                    <li><input name="sex" value="女" title="文字链" type="radio"></li>
                                    <li><input name="sex" value="女" title="富媒体" type="radio"></li>
                                    <li><input name="sex" value="女" title="商品" type="radio"></li>

                                </ul>
                                <div class="layui-tab-content">
                                    <div class="layui-tab-item layui-show">
                                        <div class="layui-form-item">
                                            <div class="layui-inline">

                                                <label class="layui-form-label">动作类型：</label>
                                                <div class="layui-input-inline">
                                                    <select name="quiz">
                                                        <option value="">请选择动作类型</option>
                                                        <optgroup label="城市记忆">
                                                            <option value="你工作的第一个城市">你工作的第一个城市</option>
                                                        </optgroup>
                                                        <optgroup label="学生时代">
                                                            <option value="你的工号">你的工号</option>
                                                            <option value="你最喜欢的老师">你最喜欢的老师</option>
                                                        </optgroup>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="layui-form-item" >
                                                <label class="layui-form-label">动作值:</label>
                                                <div class="layui-input-block">
                                                    <input style="width: 500px" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="广告名称" class="layui-input">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-tab-item">
                                        <div class="layui-form-item" >
                                            <label class="layui-form-label">链接文字:</label>
                                            <div class="layui-input-block">
                                                <input style="width: 500px" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="广告名称" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-inline">

                                                <label class="layui-form-label">动作类型：</label>
                                                <div class="layui-input-inline">
                                                    <select name="quiz">
                                                        <option value="">请选择动作类型</option>
                                                        <optgroup label="城市记忆">
                                                            <option value="你工作的第一个城市">你工作的第一个城市</option>
                                                        </optgroup>
                                                        <optgroup label="学生时代">
                                                            <option value="你的工号">你的工号</option>
                                                            <option value="你最喜欢的老师">你最喜欢的老师</option>
                                                        </optgroup>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="layui-form-item" >
                                                <label class="layui-form-label">动作值:</label>
                                                <div class="layui-input-block">
                                                    <input style="width: 500px" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="广告名称" class="layui-input">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-tab-item">
                                        <div class="layui-form-item layui-form-text" style="margin-left: 50px">
                                            <div class="layui-input-block" style="width: 500px">
                                                <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-tab-item">
                                        <div class="layui-form-item layui-form-text" style="margin-left: 50px">
                                            <div class="layui-input-block" style="width: 500px">
                                                <textarea placeholder="该写啥写啥" class="layui-textarea"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                </div>
                            </div>
                          </div>

            <div class="layui-form-item">
                <div class="layui-inline" style="margin-left: 50px;margin-top: 20px">
                    <label class="layui-form-label">是否发布</label>
                    <div class="layui-input-block">
                        <input name="sex" value="男" title="是" checked="" type="radio">
                        <input name="sex" value="女" title="否" type="radio">
                    </div>

                </div>
            </div>
            <div class="layui-form-item" style="margin-left: 50px">
                <label class="layui-form-label">顺序:</label>
                <div class="layui-input-block">
                    <input style="width: 100px" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="1" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="margin-left: 200px">
                <button class="layui-btn layui-btn-primary">添加</button>
            </div>
        </form>
    </div>

</div>


<div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
</div>


<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>

<script>
    //Demo
    layui.use(['form','laydate'], function(){
        var form = layui.form;
        var laydate = layui.laydate;
        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });
        laydate.render({
            elem: '#test11'
            ,format: 'yyyy年MM月dd日'
        });
        laydate.render({
            elem: '#test14'
            ,type: 'time'
            ,format: 'H点m分'
        });
    });


</script>
</body>
</html>