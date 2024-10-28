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
    <title>活动类别信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">活动类别信息列表</div>
        <div class="layui-card-body">

            <c:if test="${admin != null }">
                <form action="CategoryList" method="post">
                    <input type="text" placeholder="根据分类名称查询" name="key" id="key" style="height:26px;" />
                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                    <a  id="add" class="layui-btn layui-btn-sm">新增</a>
                </form>

            </c:if>



            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>活动类别名称</th>
                    <th>备注</th>

                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="Category"  >
                    <tr>
                        <td>${Category.cname }</td>
                        <td>${Category.note }</td>
                            <td>
                                <input id ="${Category.id}" value="${Category.id}" type="hidden" class="weui-input"/>
                              <a type="button" class="layui-btn layui-btn-sm layui-btn-normal">修改</a>
                               <c:if test="${admin != null }">
                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                                </c:if>
                            </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/CategoryList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/CategoryList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/CategoryList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="CategoryList?currentPage=${pageInfo.pages}">末页</a></li>
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
                area:['500px','400px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '新增活动类别',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toAddCategory', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });

        $('a.layui-btn-normal').on("click",function(e){
            var id = $(e.currentTarget).parent().find('.weui-input').attr('id');
            layer.open({
                //调整弹框的大小
                area:['500px','400px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '修改活动类别信息',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toUpdateCategory?id='+id, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });
        //open1

           $('a.layui-btn-danger').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                    $.ajax({
                        url:"${pageContext.request.contextPath}/deleteCategory",
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



    });

</script>
</body>
</html>