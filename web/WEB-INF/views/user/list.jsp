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
    <title>用户信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">用户信息列表</div>
        <div class="layui-card-body">

            <c:if test="${admin != null }">
                <form action="UserList" method="post" class="layui-form">
                    <div class="layui-input-inline">
                        <input type="text" placeholder="根据真实姓名查询" name="key" id="key"  class="layui-input"/>

                    </div>
                    <div class="layui-input-inline">
                    <select name="role" id="role" >
                        <option value="">请选择角色</option>
                        <option value="1">游客</option>
                        <option value="2">志愿者</option>
                    </select>

                    </div>

                    <input type="submit" class="layui-btn layui-btn-sm layui-btn-normal" value="查询" />
                    <a  id="add" class="layui-btn layui-btn-sm">新增</a>
                </form>

            </c:if>



            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>姓名</th>
                    <th>昵称</th>
                    <th>性别</th>
                    <th>手机号</th>
                    <th>密码</th>
                    <th>角色</th>
                    <th>出生日期</th>
                    <th>注册时间</th>
                    <th>状态</th>
                    <th>头像</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="user"  >
                    <tr>
                        <td>${user.realname }</td>
                        <td>${user.nickname }</td>
                        <td>${user.sex }</td>
                        <td>${user.phone }</td>
                        <td>${user.pwd }</td>
                        <td>
                            <c:if test="${user.role =='1' }">游客</c:if>
                            <c:if test="${user.role =='2' }">志愿者</c:if>
                        </td>
                        <td>${user.birthday }</td>
                        <td>${user.registe_time }</td>
                        <td>
                            <c:if test="${user.status == '1' }">
                                 <a style="color:green">已认证</a>
                            </c:if>
                            <c:if test="${user.status == '0' }">
                                <a style="color:red">认证失败</a>
                            </c:if>
                            <c:if test="${user.status == '2' }">
                                <a style="color:blue">认证中</a>
                            </c:if>
                        </td>
                        <td>
                            <img src="/images/${user.tx}" style="width: 50px;height: 50px;">
                        </td>

                            <td>
                                <input id ="${user.id}" value="${user.id}" type="hidden" class="weui-input"/>
                           <c:if test="${admin != null }">
                                <c:if test="${user.status == '2' }">
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-normal agree">同意</a>
                                    <a type="button" class="layui-btn layui-btn-sm layui-btn-danger refused">拒绝</a>
                                </c:if>

                           <a type="button" class="layui-btn layui-btn-sm layui-btn-normal update">修改</a>

                                <a type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                                </c:if>
                            </td>




                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm" href="${pageContext.request.contextPath}/UserList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm" href="${pageContext.request.contextPath}/UserList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-danger layui-btn-sm " href="${pageContext.request.contextPath}/UserList?currentPage=${pageInfo.pageNum+1}"> 下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a  class="layui-btn layui-btn-primary layui-btn-sm" href="UserList?currentPage=${pageInfo.pages}">末页</a></li>
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
                title: '新增用户',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toAddUser', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

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
                title: '修改用户信息',
                //刚才定义的弹窗页面
                content: '${pageContext.request.contextPath}/toUpdateUser?id='+id, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });
        //open1

       $('a.layui-btn-danger').click(function(e)
            {
                var id = $(e.currentTarget).parent().find('.weui-input').attr('id');

                layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {

                    $.ajax({
                        url:"deleteUser",
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
                    url:"updateUserState",
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
                    url:"updateUserState",
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