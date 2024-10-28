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
    <title>志愿活动报名信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">志愿活动信息列表</div>
        <div class="layui-card-body">
                <form action="BaomingList" method="post">
                    <input type="text" placeholder="根据报名人姓名" name="key" id="key" style="height:26px;" />
                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                </form>
            <table class="layui-table">
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
                <c:forEach items="${pageInfo.list}" var="data"  >
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

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/BaomingList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/BaomingList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/BaomingList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="BaomingList?currentPage=${pageInfo.pages}">末页</a></li>
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
</body>
</html>