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
    <title>登入</title>
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

<div class="layui-container fly-marginTop">
    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title">
                <li class="layui-this">登入</li>
                <li><a href="toIndexRegister">注册</a></li>
            </ul>
            <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                <div class="layui-tab-item layui-show">
                    <div class="layui-form layui-form-pane">
                        <form method="post" id="loginForm"  >
                            <div class="layui-form-item">
                                <label for="username" class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="username" name="username" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="password" class="layui-form-label">密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="password" name="password" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="type" class="layui-form-label">角色</label>
                                <div class="layui-input-inline">
                                    <select name="type" id="type" class="form-control" style="margin-left:105px;width:200px;">
                                         <option value="1">游客</option>
                                         <option value="2">志愿者</option>

                                    </select>
                                </div>

                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" lay-filter="*" type="button" id="btnLogin">立即登录</button>
                                <span style="padding-left:20px;">
                </span>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="fly-footer">
    <p><a href="toLoginOutAct" >登录后台</a></p>

</div>

<script src="<%=path %>/resource/res/layui/layui.js"></script>
<script>
    layui.use(['layer', 'form','jquery'], function(){
        var form = layui.form,
            layer = layui.layer,
            $= layui.jquery;
        form.render();//这句一定要加，占坑

        $('#btnLogin').click(function(){
            var username = $.trim($('#username').val());
            var password = $.trim($("#password").val());
            var type = $.trim($("#type").val());
            if(username == ''){
                layer.msg('用戶名不能为空',function() {time:2000});
                return false;
            }
            if(password == ''){
                layer.msg('密码不能为空',function() {time:2000});
                return false;
            }

            $.ajax({
                type: "post", // post或get
                url: "login", // 提交路径
                data: {
                    username: username,
                    password: password,
                    type:type,
                },
                // dataType: "json", // 指定后台传来的数据是json格式
                success: function(data) {

                    if (data == "ok") {
                        layer.msg('登陆成功！', {icon: 6});
                        // 延迟跳转
                        window.setTimeout("window.location='toMain'",900);
                    } else if(data == 'toIndex'){
                        layer.msg('登陆成功！', {icon: 6});
                        window.setTimeout("window.location='toIndex'",900);

                    }else {
                        layer.msg('账号或密码错误！', {icon: 5});


                    }

                },

                error: function(err) {}

            })
        })


        setTimeout(function(){ $("#userNameErr").html("")},3000);
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
        version: "3.0.0"
        ,base: '<%=path %>/resource/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');
</script>

</body>
</html>