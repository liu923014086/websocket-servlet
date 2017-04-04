<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="./layer-v3.0.3/jquery/jquery-1.8.2.min.js"></script>
<script src="./layer-v3.0.3/layer/layer.js"></script>
<link rel="stylesheet" href="//res.layui.com/layui/build/css/layui.css"  media="all">
</head>
<body>
	
	<form action="LoginServlet" class="layui-form" method="post" >
	 <div class="layui-form-item">
	    <label class="layui-form-label">单行输入框</label>
	    <div class="layui-input-block">
	      <input type="text" name="username" lay-verify="username" autocomplete="off" placeholder="请输入登录名" class="layui-input">
	    </div>
	  </div>
	  
	  <button class="layui-btn layui-btn-big layui-btn-normal" onclick="login()">登 录</button>
	</form>
<script type="text/javascript">
	function login(){
		//alert();
	
	}
</script>
</body>
</html>