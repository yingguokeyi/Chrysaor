<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/picture/picture_menu.jsp"%>
<script type="text/javascript" src="${ctx}/js/Utils.js?t=1515376178738"></script>

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
    var categorySourceMap = new Map();

    var pictureIdCode = "";
    var pictureCode = "";
    // JavaScript 代码区域
    layui.use(['element','upload','laydate','table'], function(){
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var table = layui.table;
        var form = layui.form;
        var upload = layui.upload;

        laydate.render({
            elem: '#edit_time'
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#editend_time'
            ,type: 'datetime'
        });

        table.render({
            elem: '#test'
            ,url:'${ctx}/picture?method=getPictureInfoList'
            ,height: 580
            ,cols: [[
                {type:'checkbox',fixed: 'left'}
                ,{field:'id', width:60, title: 'ID',align:'center',fixed: 'left',sort: true}
                ,{field:'picture_name', width:300, title: '图片名称',align:'center'}
                ,{field:'category_name', width:150, title: '图片分类',align:'center'}
                ,{field:'img_id', width:250, title: '图片',align:'center',templet:'#imgPath'}
                ,{field:'status', width:80, title: '状态',align:'center',templet: '#statusTemplet'}
                ,{field:'creator', width:200, title: '创建人',align:'center'}
                ,{field:'update_time', width:180, title: '编辑时间',align:'center',templet:'#editTimeTmpl'}
                ,{field:'create_time', width:180, title: '创建时间',align:'center',templet:'#createTimeTmpl'}
                ,{fixed:'right',title:'操作', width:260,align:'center', toolbar: "#barDemo"}
            ]]
            ,id: 'listTable'
            ,limit:20
            ,limits:[50,100]
            ,page: true
            ,response: {
                statusName: 'success'
                ,statusCode: 1
                ,msgName: 'errorMessage'
                ,countName: 'total'
                ,dataName: 'rs'
            }
        });

        //点击按钮 搜索
        $('#sreachBtn').on('click', function(){
            var pictureName = $('#pictureName').val();
            var status = $('#status').val();
            var edit_time = $('#edit_time').val();
            var editend_time = $('#editend_time').val();
            if(CompareDate(edit_time,editend_time)){
                layer.msg("开始时间不能大于结束时间");
                return false;
            }
            table.reload('listTable', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,where: {
                    pictureName: pictureName,
                    status: status,
                    edit_time: edit_time,
                    editend_time: editend_time
                }
            });
            return false;
        });

        function CompareDate(d1,d2){
            return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
        }

        //批量启用
        $('#status_open').on('click', function(){
            var checkStatus = table.checkStatus('listTable');
            var data = checkStatus.data;
            var selectCount = data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };
            if(selectCount >= 1){
                layer.confirm('确定启用吗？', function (index) {
                    layer.close(index);
                    var ids = new Array(selectCount);
                    for (var i = 0; i < selectCount; i++) {
                        ids[i] = checkStatus.data[i].id;
                    }

                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/picture",
                        data: "method=updatePictureStatus&status=1&ids=" + ids,
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                layer.msg("操作成功");
                                table.reload("listTable");
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.alert("错误");
                        }
                    })
                });
            }
            return false;
        });

        //批量删除
        $('#status_delete').on('click', function(obj){

            var checkStatus = table.checkStatus('listTable');
            var data = checkStatus.data;
            var selectCount = data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };
            if(selectCount >= 1){
                layer.confirm('确定删除吗？', function (index) {
                    layer.close(index);
                    var ids = new Array(selectCount);
                    for (var i = 0; i < selectCount; i++) {
                        ids[i] = checkStatus.data[i].id;
                        if (checkStatus.data[i].status == "1") {
                            layer.msg(checkStatus.data[i].picture_name + "  正在启用 请禁用之后再删除");
                            return false;
                        }
                    }

                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/picture",
                        data: "method=deletePictureInfo&ids=" + ids + "&status=1",
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                layer.msg("删除成功");
                                table.reload("listTable");
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.msg("错误");
                        }
                    })
                });
            }
            return false;
        });

        //批量停用
        $('#status_shut').on('click', function(){
            var checkStatus = table.checkStatus('listTable');
            var data = checkStatus.data;
            var selectCount = data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };
            if(selectCount >= 1){
                layer.confirm('确定停用吗？', function (index) {
                    layer.close(index);
                    var ids = new Array(selectCount);
                    for (var i = 0; i < selectCount; i++) {
                        ids[i] = checkStatus.data[i].id;
                    }

                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/picture",
                        data: "method=updatePictureStatus&status=0&ids=" + ids,
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                layer.msg("操作成功");
                                table.reload("listTable");
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.alert("错误");
                        }
                    })
                });
            }
            return false;
        });

        $('#add_picture').on('click', function (){
            $("#categoryPicture").empty();
            // 拉取图片分类数据
            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/picture",
                data: "method=getCategoryPicture",
                dataType: "json",
                success: function (data) {
                        //获取分类来源
                        var array = data.categorySourceList;
                        if (array.length > 0) {
                            for (var obj in array) {
                                $("#categoryPicture").append("<option value='" + array[obj].id + "'>" + array[obj].category_name + " [" + array[obj].id + "]" + "</option>");
                                categorySourceMap.put(array[obj].id, array[obj].category_name);
                            }
                        }
                        //(注意：需要重新渲染)
                        form.render('select');
                },
                error: function () {
                    layer.msg("错误");
                }
            });

            layer.open({
                type: 1
                , title: '新增上传图片'
                , id: 'layerDemo'
                , area: ['600px','600px']
                , content: $('#AddPictureUpload')
                , btn: ['保存','取消']
                , btnAlign: 'c' //按钮居中
                , shade: 0 //不显示遮罩
                , yes: function (data) {
                    // 这里上传图片记录信息
                    var imgId = $("#ImgIds").val();
                    var pictureNameInfos = $("#pictureNames").val();
                    var categoryId = $("#categoryPicture").val();
                    if (categoryId == "") {
                        layer.msg(" 图片分类不能为空 ");
                        return false;
                    } else if (imgId == "") {
                        layer.msg(" 上传图片不能为空  ");
                        return false;
                    }

                    console.log("categoryId " + categoryId);

                        $.ajax({
                            type: "get",
                            async: false, // 同步请求
                            cache: true,// 不使用ajax缓存
                            contentType: "application/json",
                            url: "${ctx}/picture?method=savePictureInfo",
                            data: {
                                "imgId": imgId,
                                "pictureNameInfos": pictureNameInfos,
                                "categoryId":categoryId
                            },
                            dataType: "json",
                            success: function (data) {

                                    layer.msg('上传成功',{time: 1000}, function () {
                                        window.location.reload();
                                    });

                            },
                            error: function () {
                                layer.msg("错误");
                            }
                        });

                }
                ,btn2:function () {
                    layer.closeAll();
                }
            });
        });
        
        table.on('tool(picuresList)', function(obj){
            var data = obj.data;
            var name = obj.data.picture_name;
            if (obj.event === 'statusEdit') {
                var index = layer.open({
                    type: 1
                    , title: '编辑'+name
                    , id: 'layerDemo'
                    // 宽度 高度
                    , area: ['80%','80%']
                    , content: $('#updatePictureInfo')
                    , btn: ['保存','取消']
                    , btnAlign: 'c' //按钮居中
                    , shade: 0 //不显示遮罩
                    , yes: function (data) {
                        var u_pid = $("#u_pid").val();
                        var u_category_name = $("#u_category_name").val();
                        var u_categoryPicture = $("#u_categoryPicture").val();
                        var showImgIds = $("#showImgIds").val();

                        if (u_pid == "") {
                            layer.msg(" 警告 查看编辑ID为空 ");
                            return false;
                        }
                        if (u_category_name == "") {
                            layer.msg(" 图片名称不能为空 ");
                            return false;
                        } else if (u_categoryPicture == "") {
                            layer.msg(" 图片分类不能为空 ");
                            return false;
                        } else if (showImgIds == "") {
                            layer.msg(" 上传图片不能为空 ");
                            return false;
                        }

                        $.ajax({
                            type: "get",
                            async: false, // 同步请求
                            cache: true,// 不使用ajax缓存
                            contentType: "application/json",
                            url: "${ctx}/picture?method=EditPictureInfo",
                            data: {
                                "id": u_pid,
                                "categoryName":u_category_name,
                                "categoryPicture":u_categoryPicture,
                                "showImgIds":showImgIds
                            },

                            dataType: "json",
                            success: function (data) {
                                if (data.success) {
                                    layer.msg('编辑成功',{time: 1000}, function () {
                                        layer.close(index);
                                        table.reload("listTable");
                                    });
                                } else {
                                    layer.msg("异常");
                                }
                            },
                            error: function () {
                                layer.msg("错误");
                            }
                        });
                    }
                    ,btn2:function () {

                        var index=parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    }
                });
                // 拉取数据
                selectPictureInfo(obj.data.id);
                return false;
            }
            if (obj.event === 'statusDelete') {
                console.log(obj.data.status);
                if (obj.data.status == "1") {
                    layer.msg(obj.data.picture_name + "  正在启用 请禁用之后再删除");
                    return false;
                }
                layer.confirm('确定删除吗？', function (index) {
                    layer.close(index);

                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/picture",
                        data: "method=deletePictureInfo&ids=" + data.id + "&status=1",
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                layer.msg("删除成功");
                                table.reload("listTable");
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.msg("错误");
                        }
                    })
                });

            }
        });
        // 查看单条上传图片详情
        function selectPictureInfo(id) {
            // 加载栏目外链接
            getcategoryList();

            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: false,// 不使用ajax缓存
                url: "${ctx}/picture?method=SelectPictureInfo&id=" + id,
                dataType: "json",//表示后台返回的数据是json对象
                async: true,
                success: function (data) {
                    console.log(data);
                    // 上传图片预览地址
                    $("#u_pid").val(data.rs[0].id);
                    $("#u_category_name").val(data.rs[0].picture_name);
                    $('#demo1').attr('src', data.rs[0].image);
                    $("#showImgIds").val(data.rs[0].img_id);

                    // 栏目外链接
                    var categoryIdTemp = data.rs[0].category_id;
                    if (categoryIdTemp && (categorySourceMap.size() > 0)) {
                        $("#u_categoryPicture").empty();
                        categorySourceMap.each(function (value, key) {
                            console.log(" key " + key + " value " + value);
                            if (value == categoryIdTemp) {
                                $("#u_categoryPicture").append("<option value='" + value + "' selected>" + value + " " + key + " " + "</option>");
                            } else {
                                $("#u_categoryPicture").append("<option value='" + value + "'>" + value + " " + key + "" + "</option>");
                            }
                        });
                    } else{
                        console.log( categoryIdTemp + " categorySourceMap " + categorySourceMap.size());
                    }

                    //(注意：需要重新渲染)
                    form.render('select');
                    form.render('checkbox');

                },
                error: function () {
                    layer.msg('栏目链接查询失败');
                }
            })
        }
        // 得到图片分类
        function getcategoryList() {
            $("#u_categoryPicture").empty();

            // 拉取图片分类数据
            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/picture",
                data: "method=getCategoryPicture",
                dataType: "json",
                success: function (data) {
                    //获取分类来源
                    var array = data.categorySourceList;
                    if (array.length > 0) {
                        for (var obj in array) {
                            $("#u_categoryPicture").append("<option value='" + array[obj].id + "'>" + array[obj].category_name + " [" + array[obj].id + "]" + "</option>");
                            categorySourceMap.put(array[obj].id, array[obj].category_name);
                        }
                    }
                    //(注意：需要重新渲染)
                    form.render('select');
                },
                error: function () {
                    layer.msg("错误");
                }
            });
            form.render('select');
        }

        var fileName = "";
        //多文件列表示例
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: '${ctx}/upload?method=uploadGoodsImg&uploadType=loadPosterImg'
            ,accept: 'file'
            ,multiple: true
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    fileName = "";
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));
                    fileName = file.name;
                    var pictureCodeTemp = $("#pictureNames").val();
                    if (pictureCodeTemp == "") {
                        pictureCode = fileName + ",";
                    } else{
                        pictureCode = $("#pictureNames").val() + fileName + ",";
                    }
                    $("#pictureNames").val(pictureCode);

                    console.log("fileName " + fileName);
                    //单个重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                    });

                    demoListView.append(tr);
                });
            }
            ,done: function(res, index, upload){
                console.log(res);

                var pictureId = res.result.ids;
                console.log(pictureId + ": " + fileName);

                if(res.success == 1){ //上传成功
                    pictureIdCode = pictureId + ":" + fileName + ",";
                    console.log(pictureIdCode);

                    var ImgIdsTemp = $("#ImgIds").val();
                    if (ImgIdsTemp == "") {
                        pictureId = pictureId + ",";
                    }else{
                        pictureId = $("#ImgIds").val()+ pictureId + ",";
                    }
                    $("#ImgIds").val(pictureId);


                    var tr = demoListView.find('tr#upload-'+ index)
                        ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                    tds.eq(3).html(''); //清空操作
                    return delete this.files[index]; //删除文件队列已经上传成功的文件
                }
                this.error(index, upload);
            }
            ,error: function(index, upload){
                var tr = demoListView.find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
        });

        //编辑图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '${ctx}/upload?method=uploadGoodsImg&uploadType=loadPosterImg'
            , size: 1024 //限制文件大小，单位 KB
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                //上传成功
                var imgId = res.result.ids[0];
                // if(idsTemp.length > 0){
                console.log(" showImgIds " + showImgIds + " imgId  " + imgId);
                showImgIds = imgId + ",";
                // }else{
                //     showImgIds = imgId+",";
                // }

                if (showImgIds != "") {
                    $('#showImgIds').val(showImgIds.substring(0, showImgIds.length - 1));
                }
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        })

    });

</script>
<!-- 图片 -->
<script type="text/html" id="imgPath">
    {{# if(d.image ==''){}}
    <%--<img lay-event="edit" src={{d.img_path}} height="50" width="80">--%>
    ---
    {{# }else if(d.image != ''){ }}
    <img src={{d.image}} height="50" width="100">
    {{# } }}
</script>
<%--状态--%>
<script type="text/html" id="statusTemplet">
    {{#  if(d.status === '1'){ }}
    <span><font color="#32cd32">启用</font></span>
    {{#  } else if(d.status === '0'){ }}
    <span><font color="red">停用</font></span>
    {{#  } }}
</script>
<!-- 编辑时间-->
<script type="text/html" id="editTimeTmpl">
    {{# if(d.update_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.update_time.substr(0,2) }}-{{ d.update_time.substr(2,2) }}-{{ d.update_time.substr(4,2) }} {{ d.update_time.substr(6,2) }}:{{ d.update_time.substr(8,2) }}:{{ d.update_time.substr(10,2) }}
    {{# } }}
</script>
<!--创建时间 -->
<script type="text/html" id="createTimeTmpl">
    {{# if(d.create_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.create_time.substr(0,2) }}-{{ d.create_time.substr(2,2) }}-{{ d.create_time.substr(4,2) }} {{ d.create_time.substr(6,2) }}:{{ d.create_time.substr(8,2) }}:{{ d.create_time.substr(10,2) }}
    {{# } }}
</script>
<!-- 操作 -->
<script type="text/html" id="barDemo">

    <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius" lay-event="statusEdit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius" lay-event="statusDelete">删除</a>

</script>

<!-- 内容主体区域 -->
<div class="layui-body">
    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">
        <div class="layui-elem-quote">
            海报图片库
        </div>
        <form class="layui-form layui-form-pane" >
            <div style="background-color: #f2f2f2;padding:5px 0">
                <div class="layui-form-item" style="margin-bottom:5px">
                    <label class="layui-form-label">图片名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="pictureName" id="pictureName" autocomplete="off"
                               class="layui-input">
                    </div>

                    <label class="layui-form-label" style="width: 150px">状态</label>
                    <div class="layui-input-inline">

                        <div class="layui-input-inline" >
                            <select id="status" name="status" lay-filter="statusI">
                                <option value=""></option>
                                <option value="1">启用</option>
                                <option value="0">禁用</option>
                            </select>
                        </div>

                    </div>

                    <label class="layui-form-label" style="width: 120px">创建时间</label>
                    <div class="layui-input-inline" >
                        <input name="edit_time" id="edit_time" placeholder="开始日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <div class="layui-form-mid">-</div>

                    <div class="layui-input-inline" >
                        <input name="editend_time" id="editend_time" placeholder="结束日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <button class="layui-btn layui-btn-sm" style="margin-top: 5px;margin-left: 10px" id="sreachBtn"><i class="layui-icon">&#xe615;</i>搜索</button>
                    <button class="layui-btn layui-btn-sm" style="margin-top: 5px" data-type="reset" ><i class="layui-icon">&#x2746;</i>重置</button>

                </div>

            </div>

        </form>
        <div style="margin-top: 5px">
            <button id="status_open" class="layui-btn layui-btn-sm" style="margin-top: 5px">启用</button>
            <button id="status_shut" class="layui-btn layui-btn-sm" style="margin-top: 5px">停用</button>
            <button id="add_picture" class="layui-btn layui-btn-sm" style="margin-top: 5px">新增</button>
            <button id="status_delete" class="layui-btn layui-btn-sm" style="margin-top: 5px">删除</button>
        </div>

        <!-- 表格显示-->
        <table class="layui-hide" id="test" lay-filter="picuresList"></table>
    </div>


    <!-- 编辑链接 -->
    <div id="updatePictureInfo" style="display: none; ">
        <form class="layui-form layui-form-pane" action="">
            <input type="hidden" id="u_pid" name="u_pid"/>

            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>图片名称: </label>
                <div class="layui-input-block">
                    <input style="width: 188px" class="layui-input" type="text" name="u_category_name" id="u_category_name"autocomplete="off">
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><label style="color: red">*</label>图片分类: </label>
                    <div class="layui-input-inline layui-form">
                        <select id="u_categoryPicture" name="u_categoryPicture" lay-filter="u_categoryFilter">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>

                <h4>&nbsp;&nbsp;&nbsp;上传图片:</h4>
                <hr class="layui-bg-blue">
                <div class="layui-upload" style="margin-left: 150px;">
                    <div class="layui-upload-list">
                        <img class="layui-upload-img" id="demo1">
                        <p id="demoText"></p>
                    </div>
                    <input type="hidden" id="showImgIds" name="showImgIds" value="" lay-verify="required"
                           autocomplete="off">
                    <button type="button" class="layui-btn" id="test1">选择图片</button>
                    <button type="button" class="layui-btn" id="dele" onclick="deleteFun()">删除</button>
                    <script type="application/javascript">
                        function deleteFun() {
                            $("#showImgIds").val("");
                            $('#demo1').attr('src', "");
                        }
                    </script>
                </div>


            </div>

        </form>
    </div>

    <!-- 上传图片 -->
    <div id="AddPictureUpload" style="display: none; padding: 15px;">
        <form class="layui-form layui-form-pane" action="">
            <div class="layui-form-item">
                <label class="layui-form-label"><label style="color: red">*</label>图片分类: </label>
                <div class="layui-input-inline layui-form">
                    <select id="categoryPicture" name="categoryPicture" lay-filter="categoryFilter">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>

            <div class="layui-upload">
                <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
                <div class="layui-upload-list">
                    <table class="layui-table">
                        <thead>
                        <tr><th>文件名</th>
                            <th>大小</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr></thead>
                        <tbody id="demoList"></tbody>
                    </table>
                </div>
                <button type="button" class="layui-btn" id="testListAction">开始上传</button>
            </div>
            <input type="hidden" id="ImgIds" name="ImgIds" value="" lay-verify="required"
                   autocomplete="off">
            <input type="hidden" id="pictureNames" name="pictureNames" value="" lay-verify="required"
                   autocomplete="off">

        </form>
    </div>

</div>
<%@ include file="/common/footer.jsp"%>
