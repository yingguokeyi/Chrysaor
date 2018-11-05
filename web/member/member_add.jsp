<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<html>
<head>
    <title>会员添加</title>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function(){
            var form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;
            //日期
            laydate.render({
                elem: '#date'
            });
            laydate.render({
                elem: '#date1'
            });
            //创建一个编辑器
            var editIndex = layedit.build('LAY_demo_editor');
            //监听提交
            // form.on('submit(demo1)', function(data){
            //     layer.alert(JSON.stringify(data.field), {
            //         title: '最终的提交信息'
            //     })
            //     return false;
            // });
           $('#saveMemberBtn').on('click', function(){

               var nick_name =$('#nick_name').val();
               var phone =$('#phone').val();
               var e_mail =$('#e_mail').val();
               var account_number =$('#account_number').val();
               var member_level =$('#member_level').val();
               var sex = $('#sex').val();
               var post =$('#post').val();
               var pwd =$("#pwd").val();
               var pwd2 =$("#pwd2").val();
               if(nick_name ==""){
                   layer.msg("账号不能为空！");
                   return false;
               }
               if(nick_name != phone){
                   layer.msg("账号应与手机号一致！");
                   return false;
               }
               if(phone ==""){
                   layer.msg("手机号不能为空！");
                   return false;
               }

               var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
               if (!myreg.test(phone)) {
                   layer.msg("手机号格式不正确！");
                   return false;
               }

               if(member_level ==""){
                   layer.msg("会员类型不能为空！");
                   return false;
               }
               if(pwd.length < 6){
                   layer.msg("密码长度最低六位数！");
                   return false;
               }
               if(pwd2 ==""){
                   layer.msg("请输入确认密码！");
                   return false;
               }
               if(pwd !=pwd2){
                   layer.msg("输入密码不一致！");
                   return false;
               }
                $.ajax({
                    url: "${pageContext.request.contextPath}/newMember?method=NewMembersAdd",
                  /*  data: "method=MembersAdd&jsonString="+JSON.stringify($('form').serializeObject()),*/
                    data:{"nick_name": nick_name,"phone":phone,"e_mail": e_mail,"account_number":account_number,"member_level":member_level,"password":pwd,"sex":sex},
                    contentType:"application/json",  //缺失会出现URL编码，无法转成json对象
                    cache: true,
                    async : false,
                    dataType: "json",
                    success:function(data) {
                        if(data.success){
                            layer.msg('会员添加成功',{time:5000}, function(){
                                window.parent.location.reload();
                                var index = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                            });

                        }else{
                            layer.msg("异常");
                        }
                    },
                    error : function() {
                        layer.alert("错误");
                    }
                });
                return false;
            });
        });

        /**
         * 自动将form表单封装成json对象
         */
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [ o[this.name] ];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
    </script>
</head>
<body>
    <div class=""><span style="margin-left:30px;">联系人信息</span></div>
    <div class="">
        <form class="layui-form">
           <%-- <input type="hidden" name="method" value="addMember">--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">会员昵称</label>
                    <div class="layui-input-block">
                        <input type="text" name="account_number" id="account_number"  lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="phone" id="phone" required lay-verify="required|phone|number" placeholder="请输入手机号" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-inline">
                        <select name="sex" id="sex" lay-verify="required" lay-search="">
                            <option value=""></option>
                            <option value="0">男</option>
                            <option value="1">女</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">生日</label>
                    <div class="layui-input-inline">
                        <input type="text" name="birthday" id="date" lay-verify="date" placeholder="yyyy/MM/dd"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" name="e_mail" lay-verify="email" id="e_mail" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">职务</label>
                    <div class="layui-input-block">
                        <input type="text" name="post" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="" style=""><span style="margin-left:30px;">账号信息</span></div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <input type="text" name="nick_name"  id="nick_name" required lay-verify="required" placeholder="请输入手机号" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">会员类型</label>
                    <div class="layui-input-block">
                        <select name="member_level" id="member_level"  lay-verify="required" lay-search="">
                            <option value=""></option>
                            <option value="0">非会员</option>
                            <option value="1">会员</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" id="pwd" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">确认密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="password2" id="pwd2" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="reset" class="layui-btn layui-btn-primary">取消</button>
                    <button class="layui-btn" id="saveMemberBtn" lay-filter="demo1">确认</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
