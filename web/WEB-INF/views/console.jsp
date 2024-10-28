<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>志愿者管理系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="<%=path %>/resource/layui/css/admin.css" media="all">
</head>
<body>
<a style="color:#1E9FFF;font-size:80px">欢迎来到志愿者管理系统</a>

</body>
<script src="layui/layui.all.js"></script>
<script>

layui.use('element', function(){
  var element = layui.element;
  
});
</html>