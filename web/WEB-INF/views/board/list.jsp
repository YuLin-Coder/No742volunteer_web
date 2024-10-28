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
    <title>公告信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">公告信息列表</div>
        <div class="layui-card-body">
                <form action="BoardList" method="post">
                    <input type="text" placeholder="根据公告主题查询" name="key" id="key" style="height:26px;" />
                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                    <c:if test="${admin !=null }">
                    <a  id="add" class="layui-btn layui-btn-sm">新增</a>
                    </c:if>
                </form>
            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>公告主题</th>
                    <th>发布时间</th>
                    <th>照片</th>
                    <c:if test="${admin !=null }">
                    <th>操作</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="Board"  >
                    <tr>
                        <td>${Board.title }</td>
                        <td>${Board.fbsj }</td>
                        <td>
                            <img src="/images/${Board.img}" style="width: 50px;height: 50px;">
                        </td>
                        <c:if test="${admin !=null }">
                            <td>
                                <input id ="${Board.id}" value="${Board.id}" type="hidden" class="weui-input"/>
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-normal">修改</a>
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/BoardList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/BoardList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/BoardList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="BoardList?currentPage=${pageInfo.pages}">末页</a></li>
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
                area:['1000px','800px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '新增公告',
                //刚才定义的弹窗页面
                content: 'toAddBoard', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

        $('a.layui-btn-normal').on("click",function(e){
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');
            layer.open({
                //调整弹框的大小
                area:['1000px','800px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '修改公告信息',
                //刚才定义的弹窗页面
                content: 'toUpdateBoard?id='+id, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

         $('a.layui-btn-danger').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                    $.ajax({
                        url:"${pageContext.request.contextPath}/deleteBoard",
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




    });

</script>
</body>
</html>