<%@ page language="java"  contentType="text/html; charset=UTF-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html style="background-color: #e2e2e2;">
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="{{ lay.base.keywords }}">
    <meta name="description" content="{{ lay.base.description }}">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>志愿活动列表</title>
    <link rel="stylesheet" href="<%=path %>/resource/res/layui/css/layui.css">
    <link rel="stylesheet" href="<%=path %>/resource/res/css/global.css">
    <style>
        .header{border-bottom: 1px solid #404553; border-right: 1px solid #404553;}
    </style>
</head>
<body class="fly-full">

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

<div class="fly-case-header">
   <p class="fly-case-year" style="margin-top: 70px">志愿活动列表</p>
    <p>审核通过的志愿活动才可以展示噢</p>

</div>

<div class="fly-main" style="overflow: hidden;">

    <div class="fly-tab-border fly-case-tab">
    <%--<span>
      <a href="" class="tab-this">2017年度</a>
      <a href="">2016年度</a>
    </span>--%>
    </div>
    <div class="layui-tab layui-tab-brief">
        <ul class="layui-tab-title">
            <li class="layui-this"><a href="toIndex">志愿活动列表</a></li>
            <%--<li><a href="">按点赞排行</a></li>--%>
        </ul>
    </div>

    <ul class="fly-case-list">
        <c:forEach items="${activityList}" var="data" >
        <li data-id="123">
            <a class="fly-case-img" href="toActivityDetail?aid=${data.id}"  >
                <img src="/images/${data.img}" >
                <cite class="layui-btn layui-btn-primary layui-btn-small">查看详情</cite>
            </a>
            <h2><a href="toActivityDetail?aid=${data.id}" >${data.title}</a></h2>
            <p class="fly-case-desc">${data.note}</p>
            <div class="fly-case-info">
                <a href="toActivityDetail?aid=${data.id}" class="fly-case-user" ><img src="<%=path%>/upload/${data.img}"></a>
                <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">${data.title}</span> </p>
                <p style="font-size: 12px;color: #666;">${data.cname}</p>
                <input id ="${data.id}" value="${data.id}" type="hidden" class="weui-input"/>
                <a class="layui-btn  layui-btn-sm layui-btn-primary  baoming"  type="button"  >报名</a>
                <!-- <button class="layui-btn  fly-case-active" data-type="praise">已赞</button> -->
            </div>
        </li>
        </c:forEach>
    </ul>

    <!-- <blockquote class="layui-elem-quote layui-quote-nm">暂无数据</blockquote> -->

<%--
    <div style="text-align: center;">
        <div class="laypage-main">
            <span class="laypage-curr">1</span>
            <a href="">2</a><a href="">3</a>
            <a href="">4</a>
            <a href="">5</a>
            <span>…</span>
            <a href="" class="laypage-last" title="尾页">尾页</a>
            <a href="" class="laypage-next">下一页</a>
        </div>
    </div>
--%>

</div>

<div class="fly-footer">
    <p><a href="toLoginOutAct" >登录后台</a></p>

</div>

<script src="<%=path %>/resource/res/layui/layui.js"></script>
<script>
    layui.cache.page = 'case';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '<%=path %>/resource/res/images/avatar/00.jpg'
        ,experience: 83
        ,sex: '男'
    };
    layui.config({
        version: "3.0.0"
        ,base: '<%=path %>/resource/res/mods/' //这里实际使用时，建议改成绝对路径
    }).extend({
        fly: 'index'
    }).use('fly');
</script>

<script>

    layui.use(['layer','form','jquery'], function () {//调用layui组件
        var form = layui.form;
        var layer=layui.layer;
        $=layui.jquery;
        form.render();

        $('a.baoming').click(function(e)
        {
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

            layer.confirm("确定要报名吗", { title: "报名确认" }, function (index) {

                $.ajax({
                    url:"addBaoming",
                    data:{"aid": id},
                    type:"post",
                    success:function (data) {

                        if(data == 'a'){
                            layer.msg("您已报名此志愿活动，不能重复报名",{icon:5,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'b'){
                            layer.msg("报名成功，待管理员审核",{icon:6,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'c'){
                            layer.msg("志愿者活动时间有冲突，请重新选择",{icon:5,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'd'){
                            layer.msg("报名失败，游客不能进行报名，请到个人中心申请成为志愿者后再试！",{icon:5,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'e'){
                            layer.msg("报名失败，请登录后再试",{icon:5,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'f'){
                            layer.msg("报名失败，超过报名人数",{icon:5,offset:"auto",time:2000});//提示框
                        }
                        if(data == 'g'){
                            layer.msg("报名失败，活动已开始，不能报名",{icon:5,offset:"auto",time:2000});//提示框
                        }
                    }
                });
                return false;
            });

        })

    });

</script>

</body>
</html>