<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>统计</title>
	<link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>
  <!-- 为 ECharts 准备一个定义了宽高的 DOM -->
  <div id="main" style="width: 600px;height:400px;"></div>

  <div id="main2" style="width: 600px;height:400px;"></div>

	<script src="<%=path %>/resource/layui/layui.js"></script>
	<script src="<%=path %>/resource/layui/jquery-1.9.1.min.js"></script>
	<script src="<%=path %>/resource/layui/echarts.js"></script>
	<script type="application/javascript">
	 var myChart = echarts.init(document.getElementById('main'));
	 var myChart2 = echarts.init(document.getElementById('main2'));
	    $(document).ready(function(){
	    	 // 基于准备好的dom，初始化echarts实例
	    	$.ajax({
				cache:true,
				type:"post",
				url:"selectBaomingStatics",
				async:false,
				success:function(e){
					console.log(e);
					if(e){

						  var names = [];
						  var dates = [];

						  for(var i=0;i<e.length;i++){
							    names.push(e[i].names);
			                    dates.push(e[i].counts);
			                }
					      // 指定图表的配置项和数据
					      var option = {
					        title: {
					          text: '志愿活动报名人数统计'
					        },
					        tooltip: {},
					        legend: {
					          data: ['人数']
					        },
					        xAxis: {
					          data: names
					        },
					        yAxis: {},
					        series: [
					          {
					            name: '报名人数',
					            type: 'bar',
					            data: dates
					          }
					        ]
					      };

					      // 使用刚指定的配置项和数据显示图表。
					      myChart.setOption(option);

					}
				}
			})


			$.ajax({
				cache:true,
				type:"post",
				url:"selectActivityStatics",
				async:false,
				success:function(e){
					console.log(e);
					if(e){

						var names = [];
						var dates = [];

						for(var i=0;i<e.length;i++){
							names.push(e[i].names);
							dates.push(e[i].counts);
						}
						// 指定图表的配置项和数据
						var option = {
							title: {
								text: '每日新增志愿活动数量'
							},
							tooltip: {},
							legend: {
								data: ['数量']
							},
							xAxis: {
								data: names
							},
							yAxis: {},
							series: [
								{
									name: '数量',
									type: 'line',
									data: dates
								}
							]
						};

						// 使用刚指定的配置项和数据显示图表。
						myChart2.setOption(option);

					}
				}
			})
		   
		});
	    

	</script>

</body>
</html>