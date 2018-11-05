<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: sdmin
  Date: 2018/3/13
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;">订单管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/order/pddOrderList.jsp">拼多多订单</a></dd>
                    <dd><a href="${ctx}/order/orderList.jsp">全部订单</a></dd>
                    <dd><a href="${ctx}/order/ToBePaid.jsp">待支付</a></dd>
                    <dd><a href="${ctx}/order/BeReadyToStockUp.jsp">待备货</a></dd>
                    <dd><a href="${ctx}/order/PendingDelivery.jsp">待发货</a></dd>
                    <dd><a href="${ctx}/order/GoodsToBeReceived.jsp">待提货</a></dd>
                    <dd><a href="${ctx}/order/CarryOutTheGoods.jsp">已提货</a></dd>
                    <dd><a href="${ctx}/order/Completed.jsp">已完成</a></dd>
                    <dd><a href="${ctx}/order/HaveBeenCancelled.jsp">已取消</a></dd>

                    <%--<dd><a href="${ctx}/order/RefundsOrder.jsp">待处理退款</a></dd>
                    <dd><a href="${ctx}/order/HaveBeenCancelled.jsp">退款处理中</a></dd>
                    <dd><a href="${ctx}/order/HaveBeenCancelled.jsp">退款已完成</a></dd>--%>
                </dl>
            </li>

        </ul>
    </div>
</div>