
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
    <title>添加活动类别</title>
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
                        <input type="hidden" name="id" id="id" value="${Category.id}">

                        <div class="layui-form-item">
                            <label class="layui-form-label">活动类别名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="cname" id="cname" value="${Category.cname}" lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-inline">
                                <textarea  name="note" id="note" class="layui-textarea" >${Category.note}</textarea>
                            </div>
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

        /*    laydate.render({
            elem: '#classTime'
          });
           laydate.render({
            elem: '#day'
          });  */

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
                url:"updateCategory",
                data:$("#saveForm").serialize(),
                async:false,
                success:function(e){
                    if(e){
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            window.parent.location.href="CategoryList";
                        });

                    }else{
                        layer.msg('修改失败', {
                            icon: 1,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                           // window.parent.location.href="CategoryList";
                        });
                    }
                }
            })
        });

    });



</script>
</body>
</html>