<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录</title>
    <link type="text/css" rel="stylesheet" href="<%=path %>/resource/login/css/login.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css"/>
    <link href="<%=path %>/resource/login/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=path %>/resource/login/js/jquery-1.11.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var height=$(document).height();
            $('.main').css('height',height);
        })
    </script>
</head>

<body>
<div class="main">
    <div class="main0">
        <div class="main_left">
            <img src="<%=path %>/resource/login/images/login-image-3.png" class="theimg"/>
            <img src="<%=path %>/resource/login/images/login-image-2.png" class="secimg"/>
            <img src="<%=path %>/resource/login/images/login-image-1.png" class="firimg"/>
        </div>
        <div class="main_right">
            <div class="main_r_up">
                <img src="<%=path %>/resource/login/images/user.png" />
                <div class="pp">登录</div>
            </div>
            <form id="loginForm"  method="post">
                <div class="sub"><p>我是志愿者？<a href="toIndex"><span class="blue">前往主页面</span></a></p></div>
                <div class="txt">
                    <span style="letter-spacing:8px;">用户名:</span>
                    <input name="username" id="username" type="text" class="txtphone" placeholder="请输入注册手机号或用户名"/>
                    <br>
                    <span id="userNameErr" style="color:red" >${msg}</span>
                </div>
                <div class="txt">
                    <span style="letter-spacing:4px;">登录密码:</span>
                    <input name="password" id="password" type="password" class="txtphone" placeholder="请输入登录密码"/>
                </div>
                <div class="txt">
                    <span style=" float:left;letter-spacing:8px;">角色:</span>
                    <select name="type" id="type" class="form-control" style="margin-left:105px;width:200px;">
                        <option value="0">管理员</option>
                       <%-- <option value="1">游客</option>
                        <option value="2">志愿者</option>--%>
                        <option value="3">志愿发起者</option>
                    </select>
                </div>
                <button style="margin-left:105px;letter-spacing:22px; width:250px;margin-top:20px;"
                        class="btn btn-info" id="btnLogin"  type="button" >登录</button>

            </form>
        </div>
    </div>
</div>

<script src="<%=path %>/resource/component/layui/layui.js"></script>
<script src="<%=path %>/resource/component/pear/pear.js"></script>
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
</body>
</html>
