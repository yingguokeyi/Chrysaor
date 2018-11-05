<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String menuIndex = request.getParameter("menuIndex");
%>

<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">

            <%--<li class="layui-nav-item layui-nav-itemed">--%>
                <%--<a class="" href="javascript:;">商品管理</a>--%>
                <%--<dl class="layui-nav-child">--%>
                    <%--<dd id="dd1"><a href="${ctx}/goods/goodsSourceList.jsp?menuIndex=1">商品来源</a></dd>--%>
                    <%--<dd id="dd2"><a href="${ctx}/goods/goodsList.jsp?menuIndex=2">商品管理</a></dd>--%>
                    <%--<dd id="dd3"><a href="${ctx}/goods/goodsAdd_A.jsp?menuIndex=3">添加商品</a></dd>--%>
                    <%--<dd id="dd4"><a href="${ctx}/goods/goodsTrash.jsp?menuIndex=4">商品回收站</a></dd>--%>
                    <%--<dd id="dd5"><a href="${ctx}/goods/goodsCategoryList.jsp?manType=topCate&menuIndex=5">商品分类管理</a></dd>--%>
                    <%--&lt;%&ndash;<dd><a href="${ctx}/goods/goodsCategoryAdd.jsp">添加商品分类</a></dd>&ndash;%&gt;--%>
                    <%--<dd id="dd6"><a href="${ctx}/goods/goodsTypeList.jsp?menuIndex=6">商品类型管理</a></dd>--%>
                    <%--<dd id="dd7"><a href="${ctx}/goods/goodsTypeAdd.jsp?menuIndex=7" >添加商品类型</a></dd>--%>
                    <%--<dd id="dd8"><a href="${ctx}/goods/goodsBrandList.jsp?menuIndex=8">品牌管理</a></dd>--%>
                    <%--<dd id="dd9"><a href="${ctx}/goods/supplierList.jsp?menuIndex=9">供应商管理</a></dd>--%>
                    <%--<dd id="dd10"><a href="${ctx}/goods/planList.jsp?menuIndex=10">首页推荐管理</a></dd>--%>
                    <%--<dd id="dd11"><a href="${ctx}/goods/quantityUnitList.jsp?menuIndex=11">单位数量管理</a></dd>--%>
                    <%--<dd id="dd12"><a href="${ctx}/goods/areaList.jsp?menuIndex=12">地区管理</a></dd>--%>
                    <%--&lt;%&ndash;<dd id="dd11"><a href="${ctx}/goods/demo1.jsp?menuIndex=11">测试测试</a></dd>&ndash;%&gt;--%>

                    <%--&lt;%&ndash;<dd><a href="${ctx}/goods/index">自提点列表</a></dd>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<dd><a href="${ctx}/goods/index">添加自提点</a></dd>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<dd><a href="${ctx}/goods/areaList.jsp">地区管理</a></dd>&ndash;%&gt;--%>
                <%--</dl>--%>
            <%--</li>--%>
            <%--<li class="layui-nav-item layui-nav-itemed">--%>
                <%--<a class="" href="javascript:;">拼多多商品管理</a>--%>
                <%--<dl class="layui-nav-child">--%>
                    <%--<dd id="dd13"><a href="${ctx}/goods/pddGoodsList.jsp">拼多多商品管理</a></dd>--%>
                <%--</dl>--%>
            <%--</li>--%>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">会员管理</a>
                    <dl class="layui-nav-child">
                        <dd id="dd8"><a href="${ctx}/member/member_manage.jsp?menuIndex=8">会员查询</a></dd>
                    </dl>
                </li>
        </ul>
    </div>
</div>

<script>
    var menuIndex = <%=menuIndex%>;
    $('#dd' + menuIndex).addClass("layui-this");
</script>

