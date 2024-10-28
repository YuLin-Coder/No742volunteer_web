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
        <li class="layui-nav-item layui-this">
            <a href="toMyInfo">
                <i class="layui-icon">&#xe620;</i>
                个人信息
            </a>
        </li>
        <li class="layui-nav-item">
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


    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title" id="LAY_mine">
                <li class="layui-this" lay-id="info">我的资料</li>
                <li lay-id="avatar">头像</li>
            </ul>
            <div class="layui-tab-content" style="padding: 20px 0;">
                <div class="layui-form layui-form-pane layui-tab-item layui-show">
                    <form method="post" id="saveForm">
                        <input type="hidden" id="id" name="id" value="${users.id}" >

                        <div class="layui-form-item">
                            <label for="realname" class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="realname" name="realname" value="${users.realname}" required lay-verify="email" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="nickname" class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="nickname" name="nickname" value="${users.nickname}" required lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="pwd" class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input type="password" id="pwd" name="pwd"  value="${users.pwd}" required lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="phone" class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" name="phone" value="${users.phone}" required lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="birthday" class="layui-form-label">出生日期</label>
                            <div class="layui-input-inline">
                                <input type="text" id="birthday" name="birthday"  value="${users.birthday}" required lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="sex" class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <select name="sex" id="sex" class="form-control" style="margin-left:105px;width:200px;">
                                    <option value="男"  <c:if test="${users.sex =='男' }">selected </c:if>>男</option>
                                    <option value="女" <c:if test="${users.sex =='女' }">selected </c:if>>女</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="roles" class="layui-form-label">角色</label>
                            <div class="layui-input-inline">
                                <c:if test="${users.role =='1' }">
                                <input type="text" id="roles" name="roles"  value="游客" readonly required lay-verify="required" autocomplete="off" class="layui-input">
                                </c:if>
                                <c:if test="${users.role =='2' }">
                                    <input type="text" id="roles" name="roles"  value="志愿者" readonly required lay-verify="required" autocomplete="off" class="layui-input">
                                </c:if>
                              </div>
                        </div>
                        <div class="layui-form-item">
                            <button class="layui-btn" key="set-mine" lay-filter="*" type="button" id="save">确认修改</button>

                            <c:if test="${user !=null && user.role=='1'}">
                                    <button class="layui-btn layui-btn-normal" key="set-mine" lay-filter="*" type="button" id="apply">申请成为志愿者</button>
                            </c:if>
                        </div>
                    </form>
                </div>

                <div class="layui-form layui-form-pane layui-tab-item">
                    <input type="hidden" id="utx" class="utx">
                    <div class="layui-form-item">
                        <div class="avatar-add">
                            <button type="button" class="layui-btn" id="test1">
                                <i class="layui-icon">&#xe67c;</i>上传头像
                            </button>
                            <img src="/images/${users.tx}" class="layui-upload-img" id="demo1">
                            <p id="demoText"></p>
                        </div>
                    </div>
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
        /*   laydate.render({
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

                var fileupload = $(".utx");
                fileupload.attr("value",res.data.src);
                console.log(fileupload.attr("value"));
                $.ajax({
                    cache:true,
                    type:"post",
                    url:"updateUserTx",
                    data:{"utx":res.data.src},
                    async:false,
                    success:function(e){
                        if(e){
                            layer.msg('修改成功', {
                                icon: 6,
                                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                document.location.reload();//当前页面
                            });

                        }else{
                            layer.msg('修改失败', {
                                icon: 5,
                                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                            });
                        }
                    }
                })
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
                url:"updateUserInfo",
                data:$("#saveForm").serialize(),
                async:false,
                success:function(e){
                    if(e){
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            document.location.reload();//当前页面
                        });

                    }else{
                        layer.msg('修改失败', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        });
                    }
                }
            })
        });

        $("#apply").click(function(){
            //执行添加的操作ajax
            $.ajax({
                cache:true,
                type:"post",
                url:"applyUser",
                data:$("#saveForm").serialize(),
                async:false,
                success:function(e){
                    if(e){
                        layer.msg('申请成功，待管理员审核', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            document.location.reload();//当前页面
                        });

                    }else{
                        layer.msg('申请失败', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        });
                    }
                }
            })
        });

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