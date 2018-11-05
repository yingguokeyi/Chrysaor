<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/common.jsp" %>
<%@ include file="/picture/picture_menu.jsp" %>

<script>
    var locationPage;
    //JavaScript代码区域
    layui.use(['element', 'laydate', 'table'], function () {
        var table = layui.table;

        table.render({
            elem: '#pictureTable'
            , url: '${pageContext.request.contextPath}/picture?method=getPictureCategoryInfo'
            //,width: 1900
            , height: 580
            , cols: [[
                {field: 'id', width: 150, title: '编号', align: 'center', fixed: 'left', sort: true}
                , {field: 'category_name', width: 150, title: '分类名称', align: 'center'}
                , {field: 'uploader', width: 250, title: '上传人', align: 'center'}
                , {field: 'update_time', width: 300, title: '编辑时间', align: 'center', templet: "#editTimeTmpl"}
                , {field: 'create_time', width: 300, title: '创建时间', align: 'center', templet: "#createTimeTmpl"}
                , {fixed: 'right', title: '操作', width: 550, align: 'center', toolbar: "#barDemo"}
            ]]
            , id: 'listTable'
            , response: {
                statusName: 'success'
                , statusCode: 1
                , msgName: 'errorMessage'
                , countName: 'total'
                , dataName: 'rs'
            }
        });
        var insertCategory;
        $("#insert").on('click', function () {

            insertCategory = layer.open({
                type: 1
                , title: '新增图片分类'
                , id: 'insertPicture'
                , area: ['600px', '600px']
                , content: $('#PictureAdd')
                , btn: ['新增', '取消']
                , btnAlign: 'c' //按钮居中
                , shade: 0 //不显示遮罩
                , yes: function (data) {
                    var categoryName = $("#category_name").val();
                    insertPicture(categoryName);

                }
                , btn2: function () {
                    layer.closeAll();
                }
            });

        });

        // 新增图片分类
        function insertPicture(categoryName) {

            var flag = isDuplicate(categoryName);
            console.log("  ---------------  "+flag)
            if (flag == 1) {
                layer.msg(" 该分类已经存在! ");
                return false;
            }

            if (categoryName == "") {
                layer.msg('请输入图片分类名称');
                return false;
            }
            categoryName = categoryName.trim();

            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/picture?method=insertPictureCategory",
                data: {
                    "categoryName": categoryName
                },
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    layer.msg('新增成功', {time: 1000}, function () {
                        layer.close(insertCategory);
                        table.reload("listTable");
                    });

                },
                error: function () {
                    layer.msg("错误");
                }
            });
            return false;
        }

        function isDuplicate(categoryName) {
            var res = 0;
            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/picture?method=isDulplicate",
                data: {
                    "categoryName": categoryName
                },
                dataType: "json",
                success: function (data) {
                    console.log(data.rs[0].success);
                    if (data.rs[0].num != 0) {
                        layer.msg(" 该分类已经存在! ");
                        res = 1;
                    }
                },
                error: function () {
                    layer.msg("错误");
                }
            });
            return res;
        }

        table.on('tool(pictureList)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                console.log("id  "+obj.data.id);
                var id = obj.data.id;
                $.ajax({
                    type: "get",
                    async: false, // 同步请求
                    cache: true,// 不使用ajax缓存
                    contentType: "application/json",
                    url: "${ctx}/picture?method=selectPictureCategoryInfo",
                    data: {
                        "id": id
                    },
                    dataType: "json",
                    success: function (data) {
                        var pictureCategory = data.rs[0].category_name;
                        var categoryId = data.rs[0].id;
                        console.log("     pictureCategory  "+pictureCategory + categoryId);
                        $("#u_category_name").val(pictureCategory);
                        $("#u_categoryId").val(categoryId);
                    },
                    error: function () {
                        layer.msg("错误");
                    }
                });
                var updatePictureInfo = layer.open({
                    type: 1
                    , title: '编辑图片分类'
                    , id: 'pictureEditOpen'
                    , area: ['600px', '600px']
                    , content: $('#PictureEdit')
                    , btn: ['保存', '取消']
                    , btnAlign: 'c' //按钮居中
                    , shade: 0 //不显示遮罩
                    , yes: function (data) {
                        var pictureCategory = $("#u_category_name").val().trim();
                        $.ajax({
                            type: "get",
                            async: false, // 同步请求
                            cache: true,// 不使用ajax缓存
                            contentType: "application/json",
                            url: "${ctx}/picture?method=updatePictureCategoryInfo",
                            data: {
                                "id": id,
                                "categoryName":pictureCategory
                            },
                            dataType: "json",
                            success: function (data) {
                                    layer.close(updatePictureInfo);
                                    table.reload("listTable");
                            },
                            error: function () {
                                layer.msg("错误");
                            }
                        });
                    }
                    , btn2: function () {
                        layer.closeAll();
                    }
                    , success: function () {

                    }
                });

            }
            else if (obj.event === 'delete') {
                console.log(obj.data.id);
                var id = obj.data.id;

                layer.confirm('确定删除吗？', function (index) {
                    layer.close(index);

                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/picture?method=isCheckPictureCategory",
                        data: {
                            "id": id
                        },
                        dataType: "json",
                        success: function (data) {
                            console.log(data);
                            if (data.rs[0].num == 1) {
                                layer.msg(" 该分类正在使用中 不能删除 ");
                                return false;
                            } else{
                                deletePictureCategory(id);
                            }
                        },
                        error: function () {
                            layer.msg("错误");
                        }
                    });

                });

            }
        });

        function deletePictureCategory(id) {
            $.ajax({
                type: "get",
                async: false, // 同步请求
                cache: true,// 不使用ajax缓存
                contentType: "application/json",
                url: "${ctx}/picture",
                data: "method=deletePictureCategory&id=" + id,
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
        }
    });


</script>
<!-- 操作 -->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius" lay-event="delete">删除</a>
</script>
<!-- 编辑时间 -->
<script type="text/html" id="editTimeTmpl">
    {{# if(d.update_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.update_time.substr(0,2) }}-{{ d.update_time.substr(2,2) }}-{{ d.update_time.substr(4,2) }} {{ d.update_time.substr(6,2) }}:{{ d.update_time.substr(8,2) }}:{{ d.update_time.substr(10,2) }}
    {{# } }}
</script>
<!-- 创建时间 -->
<script type="text/html" id="createTimeTmpl">
    {{# if(d.create_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.create_time.substr(0,2) }}-{{ d.create_time.substr(2,2) }}-{{ d.create_time.substr(4,2) }} {{ d.create_time.substr(6,2) }}:{{ d.create_time.substr(8,2) }}:{{ d.create_time.substr(10,2) }}
    {{# } }}
</script>
<!-- 内容主体区域 -->
<div class="layui-body">
    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">
        <div class="layui-elem-quote">
            图片库分类
        </div>
        <form class="layui-form layui-form-pane">
            <div style="background-color: #f2f2f2;padding:5px 0">
                <div class="layui-form-item" style="margin-bottom:5px">

                </div>

                <div class="layui-form-item" style="margin-bottom: 0">

                </div>
            </div>
        </form>
        <div style="margin-top: 5px">
            <button id="insert" class="layui-btn layui-btn-sm" style="margin-top: 5px">新增图片分类</button>
        </div>
        <!-- 表格显示-->
        <table class="layui-hide" id="pictureTable" lay-filter="pictureList"></table>
    </div>

    <!-- 编辑页面 -->
    <div id="PictureEdit" style="display: none; padding: 15px;">
        <form class="layui-form layui-form-pane">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 150px">图片分类名称</label>
                <div class="layui-input-block">
                    <input style="width: 350px" class="layui-input" type="text" name="u_category_name" id="u_category_name"
                           lay-verify="title" autocomplete="off">
                    <input type="hidden" id="u_categoryId" name="u_categoryId">
                </div>
            </div>

        </form>
    </div>

    <!-- 新增页面 -->
    <div id="PictureAdd" style="display: none; padding: 15px;">
        <form class="layui-form layui-form-pane">
            <div class="layui-form-item">

                <label class="layui-form-label" style="width: 150px">图片分类名称</label>
                <div class="layui-input-block">
                    <input style="width: 350px" class="layui-input" type="text" name="category_name" id="category_name"
                           lay-verify="title" autocomplete="off">
                </div>

            </div>


        </form>
    </div>

</div>
<%@ include file="/common/footer.jsp" %>