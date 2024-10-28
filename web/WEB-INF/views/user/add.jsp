
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
    <title>添加用户</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>


<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <form  id= "saveForm" method="post" class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="realname" id="realname" lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="nickname"  id="nickname"  lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">登录密码</label>
                            <div class="layui-input-inline">
                                <input type="text" name="pwd"  id="pwd"  lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <select name="sex" id="sex" >
                                        <option value="男">男</option>
                                        <option value="女">女</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" id="phone"  lay-verify="required" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">出生日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="birthday" id="birthday"  lay-verify="required" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">角色</label>
                            <div class="layui-input-inline">
                                <select name="role" id="role" >
                                    <option value="1">游客</option>
                                    <option value="2">志愿者</option>
                                </select>
                            </div>
                        </div>

                        <input type="hidden" name="tx" class="tx">
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-input-inline">
                                <img class="layui-upload-img" style="width:200px;height:100px;" id="demo1">
                                <button type="button" class="layui-btn layui-btn-sm " id="test1">+</button>
                            </div>
                                <p id="demoText"></p>
                        </div>

                        <br>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <!--   <button class="layui-btn" lay-filter="update" lay-submit="">确认修改</button>          -->
                                <button class="layui-btn" type="button" id="save">提交</button>
                                <button class="layui-btn" type="submit" id="close">关闭</button>
                            </div>
                        </div>


                    </form>
                </div>


            </div>
        </div>
    </div>
</div>
</div>




<script src="<%=path %>/resource/layui/layui.js"></script>
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
                        layer.msg('新增成功', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.location.reload();//刷新父页面，注意一定要在关闭当前iframe层之前执行刷新
                            parent.layer.close(index); //再执行关闭
                        });

                    }else{
                        layer.msg('手机号重复,新增失败，请重新填写手机号', {
                            icon: 1,
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