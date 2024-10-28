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
    <title>志愿发起者信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">志愿发起者信息列表</div>
        <div class="layui-card-body">

            <c:if test="${admin != null }">
                <form action="OrganizerList" method="post" class="layui-form">
                    <div class="layui-input-inline">
                        <input type="text" placeholder="根据真实姓名查询" name="key" id="key"  class="layui-input"/>
                    </div>
                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                    <a  id="add" class="layui-btn layui-btn-sm">新增</a>
                </form>

            </c:if>



            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>姓名</th>
                    <th>手机号</th>
                    <th>密码</th>
                    <th>所属单位</th>
                    <th>注册时间</th>
                    <th>状态</th>
                    <th>头像</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="Organizer"  >
                    <tr>
                        <td>${Organizer.realname }</td>
                        <td>${Organizer.phone }</td>
                        <td>${Organizer.pwd }</td>
                        <td>${Organizer.type }</td>
                        <td>${Organizer.registe_time }</td>
                        <td>
                            <c:if test="${Organizer.status == '1' }">
                                 <a style="color:green">已认证</a>
                            </c:if>
                            <c:if test="${Organizer.status == '0' }">
                                <a style="color:red">认证失败</a>
                            </c:if>
                            <c:if test="${Organizer.status == '2' }">
                                <a style="color:blue">认证中</a>
                            </c:if>
                        </td>
                        <td>
                            <img src="/images/${Organizer.tx}" style="width: 50px;height: 50px;">
                        </td>

                            <td>
                                <input id ="${Organizer.id}" value="${Organizer.id}" type="hidden" class="weui-input"/>
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-normal update">修改</a>
                           <c:if test="${admin != null }">
                                <c:if test="${Organizer.status == '2' }">
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-normal agree">同意</a>
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-danger refused">拒绝</a>
                                </c:if>



                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                                </c:if>
                            </td>




                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/OrganizerList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/OrganizerList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/OrganizerList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="OrganizerList?currentPage=${pageInfo.pages}">末页</a></li>
                    <li style="margin-left:10px;margin-top:6px;">共<i class="blue">${pageInfo.total }</i>条记录，当前显示第<i class="blue">${pageInfo.pageNum }</i>页,&nbsp;
                        总<i class="blue">${pageInfo.pages }</i>页
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<script src="<%=path %>/resource/layui/layui.js"></script>
<script>

    layui.use(['layer','form','jquery'], function () {//调用layui组件
        var form = layui.form;
        var layer=layui.layer;
        $=layui.jquery;
        form.render();


        $('#add').on("click",function(e){
            layer.open({
                //调整弹框的大小
                area:['500px','700px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '新增志愿发起者',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toAddOrganizer', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

        $('a.update').on("click",function(e){
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');
            layer.open({
                //调整弹框的大小
                area:['500px','700px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '修改志愿发起者信息',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toUpdateOrganizer?id='+id, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });
        //open1

       $('a.layui-btn-danger').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                    $.ajax({
                        url:"deleteOrganizer",
                        data:{"id": id},
                        type:"post",
                        dataType:"json",
                        success:function (data) {
                            if (data) {
                                layer.msg('删除成功！',{icon:5,offset:"auto",time:2000});//提示框
                                document.location.reload();//当前页面
                            }else{
                                layer.msg('删除失败！',{icon:6,offset:"auto",time:2000});//提示框
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

            layer.confirm("确定要拒绝吗", { title: "拒绝确认" }, function (index) {

                $.ajax({
                    url:"updateOrganizerState",
                    data:{"id": id,"status":"0"},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data) {
                            layer.msg('操作成功！',{icon:1,offset:"auto",time:2000}, function(){
                                document.location.reload();//当前页面
                            });//提示框

                        }else{
                            layer.msg('操作失败！',{icon:5,offset:"auto",time:2000});//提示框

                        }
                    }
                });
                return false;
            });

        })
        $('a.agree').click(function(e)
        {
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

            layer.confirm("确定要同意吗", { title: "同意确认" }, function (index) {

                $.ajax({
                    url:"updateOrganizerState",
                    data:{"id": id,"status":"1"},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data) {
                            layer.msg('操作成功！',{icon:1,offset:"auto",time:2000}, function(){
                                document.location.reload();//当前页面
                            });//提示框

                        }else{
                            layer.msg('操作失败！',{icon:5,offset:"auto",time:2000});//提示框

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