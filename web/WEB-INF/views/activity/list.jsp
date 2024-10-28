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
    <title>志愿活动信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">志愿活动信息列表</div>
        <div class="layui-card-body">
                <form action="ActivityList" method="post">
                    <input type="text" placeholder="根据志愿活动主题查询" name="key" id="key" style="height:26px;" />
                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                    <c:if test="${organizer != null }">
                       <a id="add" class="layui-btn layui-btn-sm">新增</a>
                    </c:if>
                </form>
            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>志愿活动主题</th>
                    <th>类别</th>
                    <th>发布人</th>
                    <th>发布时间</th>
                    <th>总人数</th>
                    <th>已报名人数</th>
                    <th>活动开始时间</th>
                    <th>活动结束时间</th>
                    <th>活动状态</th>
                    <th>招募状态</th>
                    <th>照片</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="Activity"  >
                    <tr>
                        <td>${Activity.title }</td>
                        <td>${Activity.cname }</td>
                        <td>${Activity.oname }</td>
                        <td>${Activity.fbrq }</td>
                        <td>${Activity.total }</td>
                        <td>${Activity.yzmcount }</td>
                        <td>${Activity.start_time }</td>
                        <td>${Activity.end_time }</td>
                        <td>
                            <c:if test="${Activity.status1 == '1' }">审核中 </c:if>
                            <c:if test="${Activity.status1 == '2' }">审核通过 </c:if>
                            <c:if test="${Activity.status1 == '0' }">审核失败 </c:if>
                        </td>
                        <td>
                            <c:if test="${Activity.status2 == '1' }">已开始 </c:if>
                            <c:if test="${Activity.status2 == '2' }">已结束 </c:if>
                        </td>
                        <td>
                            <img src="/images/${Activity.img}" style="width: 50px;height: 50px;">
                        </td>

                            <td>
                                <input id ="${Activity.id}" value="${Activity.id}" type="hidden" class="weui-input"/>
                                <c:if test="${Activity.status1 == '1' && admin != null }">
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn agree">通过</a>
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-warm refused">拒绝</a>
                                </c:if>

                                <c:if test="${Activity.status2 == '1' && Activity.status1 == '2' }">
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn stop">结束招募</a>
                                </c:if>

                                <a type="button" class="layui-btn layui-btn-sm layui-btn-normal">修改</a>
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                            </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/ActivityList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/ActivityList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/ActivityList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="ActivityList?currentPage=${pageInfo.pages}">末页</a></li>
                    <li style="margin-left:10px;margin-top:6px;">共<i class="blue">${pageInfo.total }</i>条记录，当前显示第<i class="blue">${pageInfo.pageNum }</i>页,&nbsp;
                        总<i class="blue">${pageInfo.pages }</i>页
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<script  charset="utf-8" src="<%=path %>/resource/layui/layui.js"></script>
<script>

    layui.use(['layer','form','jquery'], function () {//调用layui组件
        var form = layui.form;
        var layer=layui.layer;
        $=layui.jquery;
        form.render();


        $('#add').on("click",function(e){
            layer.open({
                //调整弹框的大小
                area:['1000px','850px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '新增志愿活动',
                //刚才定义的弹窗页面
                content: 'toAddActivity', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

        $('a.layui-btn-normal').on("click",function(e){
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');
            layer.open({
                //调整弹框的大小
                area:['1000px','850px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '修改志愿活动信息',
                //刚才定义的弹窗页面
                content: 'toUpdateActivity?id='+id, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

         $('a.layui-btn-danger').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                    $.ajax({
                        url:"${pageContext.request.contextPath}/deleteActivity",
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
                        url:"updateActivityStatus",
                        data:{"id": id,"status1":"2"},
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
                        url:"updateActivityStatus",
                        data:{"id": id,"status1":"0"},
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

         $('a.stop').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要停止招募吗", { title: "停止确认" }, function (index) {

                    $.ajax({
                        url:"stopActivity",
                        data:{"id": id,"status2":"2"},
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