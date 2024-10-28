<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>通知公告</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="<%=path %>/resource/res/layui/css/layui.css">
    <link rel="stylesheet" href="<%=path %>/resource/res/css/global.css">
</head>
<body>

<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" href="toIndex" >
            <h1 style="color:white;"> 志愿者管理系统</h1>
        </a>
        <ul class="layui-nav fly-nav layui-this  layui-hide-xs">
            <li class="layui-nav-item">
                <a href="toIndex"><i class="iconfont icon-jiaoliu"></i>主页面</a>
            </li>
            <li class="layui-nav-item ">
                <a href="toBoard"><i class="iconfont icon-iconmingxinganli"></i>通知公告</a>
            </li>

            <c:if test="${user !=null}">
                <li class="layui-nav-item">
                    <a href="toMyInfo" ><i class="iconfont icon-ui"></i>个人信息</a>
                </li>
                <li class="layui-nav-item">
                    <a href="outIndex" ><i class="iconfont icon-renzheng"></i>退出登录</a>
                </li>

            </c:if>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <!-- 未登入的状态 -->
            <c:if test="${user !=null && user.role=='1'}">
                <li class="layui-nav-item">
                    欢迎游客：${user.realname}
                </li>

            </c:if>

            <c:if test="${user !=null && user.role=='2'}">
                <li class="layui-nav-item">
                    欢迎志愿者：${user.realname}
                </li>
            </c:if>

            <c:if test="${user == null}">
                <li class="layui-nav-item">
                    <a href="toIndexLogin" >去登录注册</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
            <li class="layui-hide-xs"><a href="toBoard">通知公告列表</a></li>
        </ul>

      <%--  <div class="fly-column-right layui-hide-xs">
            <span class="fly-search"><i class="layui-icon"></i></span>
        </div>--%>

    </div>
</div>


<div class="layui-container" >
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="fly-panel" style="margin-bottom: 0;">

                <ul class="fly-list">
                    <c:forEach items="${boardList}" var="data"  >
                    <li>
                        <a href="toBoardDetail?bid=${data.id}" class="fly-avatar">
                            <img src="<%=path%>/upload/${data.img}">
                        </a>
                        <h2>
                            <a href="toBoardDetail?bid=${data.id}">${data.title}</a>
                        </h2>
                        <div class="fly-list-info">
                            <a href="toBoardDetail?bid=${data.id}" link>
                                <cite>发布时间：${data.fbsj}</cite>
                            </a>
                        </div>

                    </li>
                    </c:forEach>
                </ul>

            </div>
        </div>
        <div class="layui-col-md4">
            <dl class="fly-panel fly-list-one">
                <dt class="fly-panel-title">通知公告</dt>
                <c:forEach items="${boardList}" var="data"  >
                    <dd>
                        <a href="toBoardDetail?bid=${data.id}">${data.title}</a>
                    </dd>
                </c:forEach>

                <!-- 无数据时 -->
                <!--
                <div class="fly-none">没有相关数据</div>
                -->
            </dl>
        </div>
    </div>
</div>

<div class="fly-footer">
    <p><a href="toLoginOutAct" >登录后台</a></p>

</div>

<script src="<%=path %>/resource/res/layui/layui.js"></script>
<script>
    layui.cache.page = 'jie';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '<%=path %>/resource/res/images/avatar/00.jpg'
        ,experience: 83
        ,sex: '男'
    };
    layui.config({
        version: "3.0.0"
        ,base: '<%=path %>/resource/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');
</script>

</body>
</html>