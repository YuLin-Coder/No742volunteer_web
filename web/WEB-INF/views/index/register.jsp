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
    <title>注册</title>
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
                <li><a href="toIndexLogin">登入</a></li>
                <li class="layui-this">注册</li>
            </ul>
            <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                <div class="layui-tab-item layui-show">
                    <div class="layui-form layui-form-pane">
                        <form method="post" id= "saveForm">
                            <div class="layui-form-item">
                                <label for="realname" class="layui-form-label">姓名</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="realname" name="realname" required lay-verify="email" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="nickname" class="layui-form-label">昵称</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="nickname" name="nickname" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="pwd" class="layui-form-label">密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="pwd" name="pwd" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="phone" class="layui-form-label">手机号</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="phone" name="phone" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="birthday" class="layui-form-label">出生日期</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="birthday" name="birthday" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="sex" class="layui-form-label">性别</label>
                                <div class="layui-input-inline">
                                    <select name="sex" id="sex" class="form-control" style="margin-left:105px;width:200px;">
                                        <option value="男">男</option>
                                        <option value="女">女</option>
                                    </select>
                                </div>
                            </div>
                            <input type="hidden" name="tx" class="tx">
                            <div class="layui-form-item">
                                <label for="sex" class="layui-form-label">角色</label>
                                <div class="layui-input-inline">
                                    <select name="role" id="role" >
                                        <option value="1">游客</option>
                                        <option value="2">志愿者</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="sex" class="layui-form-label">图片</label>
                                <div class="layui-input-inline">
                                    <img class="layui-upload-img" style="width:200px;height:100px;" id="demo1">
                                    <button type="button" class="layui-btn layui-btn-sm " id="test1">+</button>
                                </div>
                                <p id="demoText"></p>
                            </div>

                            <div class="layui-form-item">
                                <button class="layui-btn" lay-filter="*" type="button" id="save">立即注册</button>
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

<script>

    layui.use([ 'form','jquery','layer','laydate','upload' ], function() {
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            $= layui.jquery;
        form.render();//这句一定要加，占坑

        laydate.render({
            elem: '#birthday'
        });
        /* laydate.render({
      elem: '#day'
    });  */


        var uploadInst = upload.render({
            elem: '#test1'
            ,url: 'upload'
            ,accept:'images'
            ,size:50000
            ,before: function(obj){

                obj.preview(function(index, file, result){

                    $('#demo1').attr('src', result);
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                var demoText = $('#demoText');
                demoText.html('<span style="color: #4cae4c;">上传成功</span>');

                var fileupload = $(".tx");
                fileupload.attr("value",res.data.src);
                console.log(fileupload.attr("value"));
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

        $(document).on('click', '#close',
            function() {

                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.location.reload();//刷新父页面，注意一定要在关闭当前iframe层之前执行刷新
                parent.layer.close(index); //再执行关闭

            });

        $("#save").click(function(){
            //执行添加的操作ajax
            $.ajax({
                cache:true,
                type:"post",
                url:"addUser",
                data:$("#saveForm").serialize(),
                async:false,
                success:function(e){
                    if(e){
                        layer.msg('注册成功', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.location.reload();//刷新父页面，注意一定要在关闭当前iframe层之前执行刷新
                            parent.layer.close(index); //再执行关闭
                        });

                    }else{
                        layer.msg('手机号重复,注册失败，请重新填写手机号', {
                            icon: 5,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            // window.parent.location.href="UserList";
                        });
                    }
                }
            })
        });

    });



</script>
</body>
</html>