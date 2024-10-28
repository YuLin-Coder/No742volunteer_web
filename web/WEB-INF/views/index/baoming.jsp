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
    <title>个人信息</title>
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

<div class="layui-container fly-marginTop fly-user-main">
    <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
        <li class="layui-nav-item ">
            <a href="toMyInfo">
                <i class="layui-icon">&#xe620;</i>
                个人信息
            </a>
        </li>
        <li class="layui-nav-item layui-this">
            <a href="toBaoming">
                <i class="layui-icon">&#xe611;</i>
                我的报名
            </a>
        </li>
    </ul>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

                <table class="layui-table" style="margin-left: 200px;">
                    <thead>
                    <tr style="background-color:#d0d0d0;">
                        <th>报名人</th>
                        <th>报名时间</th>
                        <th>报名状态</th>
                        <th>志愿活动主题</th>
                        <th>活动开始时间</th>
                        <th>活动结束时间</th>
                        <th>活动状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="data"  >
                        <tr>
                            <td>${data.uname }</td>
                            <td>${data.createtime }</td>
                            <td><c:if test="${data.status == '1' }">报名中 </c:if>
                                <c:if test="${data.status == '2' }">报名成功 </c:if>
                                <c:if test="${data.status == '0' }">报名失败 </c:if>
                            </td>
                            <td>${data.activity.title }</td>
                            <td>${data.activity.start_time }</td>
                            <td>${data.activity.end_time }</td>
                            <td>
                                <c:if test="${data.activity.status2 == '1' }">已开始 </c:if>
                                <c:if test="${data.activity.status2 == '2' }">已结束 </c:if>
                            </td>
                            <td>
                                <input id ="${data.id}" value="${data.id}" type="hidden" class="weui-input"/>
                                <c:if test="${data.status == '1'  && admin != null }">
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn agree">通过</a>
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-warm refused">拒绝</a>
                                </c:if>
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                            </td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

</div>
</div>

<div class="fly-footer">
    <p><a href="toLoginOutAct" >登录后台</a></p>

</div>


<script src="<%=path %>/resource/res/layui/layui.js"></script>
<script>

    layui.use(['layer','form','jquery'], function () {//调用layui组件
        var form = layui.form;
        var layer=layui.layer;
        $=layui.jquery;
        form.render();

        $('a.layui-btn-danger').click(function(e)
        {
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

            layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                $.ajax({
                    url:"deleteBaoming",
                    data:{"id": id},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data) {
                            layer.msg('删除成功！',{icon:6,offset:"auto",time:2000}, function(){
                                document.location.reload();//当前页面
                            });//提示框
                        }else{
                            layer.msg('删除失败！',{icon:5,offset:"auto",time:2000});//提示框
                            //window.parent.location.href="${pageContext.request.contextPath}/SubjectList";
                            document.location.reload();//当前页面
                        }
                    }
                });
                return false;
            });

        })

        $('a.agree').click(function(e)
        {
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

            layer.confirm("确认要通过吗", { title: "通过确认" }, function (index) {

                $.ajax({
                    url:"updateBaomingStatus",
                    data:{"id": id,"status":"2"},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data) {
                            layer.msg('操作成功！',{icon:6,offset:"auto",time:2000}, function(){
                                document.location.reload();//当前页面
                            });//提示框
                        }else{
                            layer.msg('操作失败！',{icon:5,offset:"auto",time:2000});//提示框
                            //window.parent.location.href="${pageContext.request.contextPath}/SubjectList";
                            document.location.reload();//当前页面
                        }
                    }
                });
                return false;
            });

        })

        $('a.refused').click(function(e)
        {
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

            layer.confirm("确认要拒绝吗", { title: "拒绝确认" }, function (index) {

                $.ajax({
                    url:"updateBaomingStatus",
                    data:{"id": id,"status":"0"},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data) {
                            layer.msg('操作成功！',{icon:6,offset:"auto",time:2000}, function(){
                                document.location.reload();//当前页面
                            });//提示框
                        }else{
                            layer.msg('操作失败！',{icon:5,offset:"auto",time:2000});//提示框
                            //window.parent.location.href="${pageContext.request.contextPath}/SubjectList";
                            document.location.reload();//当前页面
                        }
                    }
                });
                return false;
            });

        })
    });

</script>
<script>
    layui.cache.page = 'user';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '<%=path %>/resource/res/images/avatar/00.jpg'
        ,experience: 83
        ,sex: '男'
    };
    layui.config({
        version: "2.0.0"
        ,base: '<%=path %>/resource/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');
</script>

</body>
</html>