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
<title>志愿者管理系统</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
  <link rel="stylesheet" href="<%=path %>/resource/layui/css/admin.css" media="all">
</head>
<body class="layui-layout-body">
  
  <div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <!-- 头部区域 -->
        <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layadmin-flexible" lay-unselect>
            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
            <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li>
         
         
        </ul>
        <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
          
         
          <li class="layui-nav-item" lay-unselect>
            <a href="javascript:;">
            <c:if test="${admin != null }">
                     <cite>欢迎管理员：${admin.nickname}</cite>
			</c:if>
                <c:if test="${organizer != null }">
                     <cite>欢迎志愿发起者：${organizer.realname}</cite>
			</c:if>

            </a>
            <dl class="layui-nav-child">
             
             <%--  <dd><a href="toUpdateUserPwdAct?id=${id}" target="mainFrame">修改密码</a></dd> --%>
               <dd><a href="toLoginOutAct">退出登陆</a></dd>
              <dd layadmin-event="logout" style="text-align: center;"></dd>
            </dl>
          </li>
          
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
          <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
            <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
        </ul>
      </div>
      
      <!-- 侧边菜单 -->
      <div class="layui-side layui-side-menu">
        <div class="layui-side-scroll">
          <div class="layui-logo" lay-href="home/console.html">
            <span>志愿者管理系统</span>
          </div>
          
          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
            <li data-name="home" class="layui-nav-item layui-nav-itemed">
              <a href="javascript:;" lay-tips="主页" lay-direction="2">
                <i class="layui-icon layui-icon-home"></i>
                <cite>主页</cite>
              </a>
              <dl class="layui-nav-child">
                <dd data-name="console" class="layui-this">
                  <a href="toConsoleAct"  target="mainFrame">控制台</a>
                </dd>
                
              </dl>
            </li>
           
            
             <c:if test="${admin != null }">
              <li data-name="" class="layui-nav-item">
              <a href="javascript:;" lay-tips="设置" lay-direction="2">
                <i class="layui-icon layui-icon-user"></i>
                <cite>用户管理</cite>
              </a>
              <dl class="layui-nav-child">
                 <dd class="layui-nav-itemed">
                  <a href="UserList" target="mainFrame">用户列表</a>
                </dd>
              </dl>
            </li>
                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>志愿发起者管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="OrganizerList" target="mainFrame">志愿发起者信息列表</a>
                         </dd>
                     </dl>
                 </li>


                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>公告管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="BoardList" target="mainFrame">公告信息列表</a>
                         </dd>
                     </dl>
                 </li>


                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>活动类别管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="CategoryList" target="mainFrame">活动类别信息列表</a>
                         </dd>
                     </dl>
                 </li>
                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>志愿活动管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="ActivityList" target="mainFrame">志愿活动列表</a>
                         </dd>
                     </dl>
                 </li>
                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>志愿活动报名管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="BaomingList" target="mainFrame">志愿活动报名信息列表</a>
                         </dd>
                     </dl>
                 </li>
                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>数据统计</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="toEcharts" target="mainFrame">志愿活动统计</a>
                         </dd>
                     </dl>
                 </li>

             </c:if>
            
             <c:if test="${organizer != null }">
              <li data-name="" class="layui-nav-item">
              <a href="javascript:;" lay-tips="设置" lay-direction="2">
                <i class="layui-icon layui-icon-user"></i>
                <cite>个人信息管理</cite>
              </a>
              <dl class="layui-nav-child">
                  <dd class="layui-nav-itemed">
                      <a href="OrganizerList" target="mainFrame">查看个人信息</a>
                  </dd>
              </dl>
            </li>


                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>志愿活动管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="ActivityList" target="mainFrame">志愿活动列表</a>
                         </dd>
                     </dl>
                 </li>

                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>志愿活动报名管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="BaomingList" target="mainFrame">我的活动报名列表</a>
                         </dd>
                     </dl>
                 </li>


                 <li data-name="" class="layui-nav-item">
                     <a href="javascript:;" lay-tips="设置" lay-direction="2">
                         <i class="layui-icon layui-icon-notice"></i>
                         <cite>公告信息管理</cite>
                     </a>
                     <dl class="layui-nav-child">
                         <dd class="layui-nav-itemed">
                             <a href="BoardList" target="mainFrame">公告列表</a>
                         </dd>
                     </dl>
                 </li>
			</c:if>



          </ul>
        </div>
      </div>

      <!-- 页面标签 -->
      <div class="layadmin-pagetabs" id="LAY_app_tabs">
         <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div> 
        <div class="layui-icon layadmin-tabs-control layui-icon-down">
          <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
            <li class="layui-nav-item" lay-unselect>
              <a href="javascript:;"></a>
              
            </li>
          </ul>
        </div>
        <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
          <ul class="layui-tab-title" id="LAY_app_tabsheader">
            <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
          </ul>
        </div>
      </div>
      
      
      <!-- 主体内容 -->
      <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show">
          <iframe src="toConsoleAct" id="mainFrame" name="mainFrame" style="width:100%;height:100%;"  frameborder="0" class="mainFrame"></iframe>
        </div>
      </div>
      
      <!-- 辅助元素，一般用于移动设备下遮罩 -->
      <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
  </div>

<script src="<%=path %>/resource/layui/layui.js"></script>
<script>

layui.use('element', function(){
  var element = layui.element;
  
});
</script>
</body>
</html>