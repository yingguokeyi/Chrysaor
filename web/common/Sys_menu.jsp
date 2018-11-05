<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="">系统设置</a>
                <dl class="layui-nav-child">
                    <dd id="dd1"><a href="${ctx}/System_settings/staff_management.jsp?menuIndex=1">员工列表</a></dd>
                    <dd id="dd2"><a href="${ctx}/System_settings/staff_add.jsp?menuIndex=2">添加员工</a></dd>
                    <dd id="dd3"><a href="${ctx}/System_settings/role_management.jsp?menuIndex=3">角色管理列表</a></dd>
                    <dd id="dd4"><a href="${ctx}/System_settings/role_add.jsp?menuIndex=4">添加角色</a></dd>
                    <dd id="dd5"><a href="${ctx}/System_settings/section_management.jsp?menuIndex=5">部门管理列表</a></dd>
                    <dd id="dd6"><a href="${ctx}/System_settings/section_add.jsp?menuIndex=6">添加部门</a></dd>
                    <dd id="dd7"><a href="${ctx}/System_settings/operation_log.jsp?menuIndex=7">操作日志</a></dd>
                    <dd id="dd8"><a href="${ctx}/System_settings/person_settings.jsp?menuIndex=8">个人设置</a></dd>
                    <dd id="dd9"><a href="${ctx}/System_settings/message_Management.jsp?menuIndex=9">消息管理</a></dd>
                </dl>
            </li>
            <!--
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
            -->
        </ul>
    </div>
</div>