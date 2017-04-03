<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"  src="jquery-1.4.4.min.js"></script>

<script type="text/javascript">
 
	var isRefresh = performance.navigation.type; // 0跳转  1刷新
	
	var username = "${sessionScope.username}";
	var  ws;  
	var url="ws://localhost:8080/websocket_chat/chatSocket?username="+username; 
	window.onload=function(){ 
		
		if ('WebSocket' in window) {
            ws = new WebSocket(url);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(url);
        } else {
            alert('WebSocket is not supported by this browser.');
            return;
        }
		 
		ws.onmessage = function(event){ 
			eval("var msg="+event.data+";"); 
			console.info(msg.usernames);
			if(undefined!=msg.welcome){
				$("#content").append(msg.welcome);
			} 
			if(undefined!=msg.usernames){
				$("#userList").html("");
				
				$(msg.usernames).each(function(){
					if(this != username){
						$("#userList").append(this+"<input name=checkbox type=checkbox value='"+this+"'/>"+"<br/>")
					}else{
						$("#userList").append(this+"<br/>")
					}
					
				})
			} 
			if(undefined!=content){
				$("#content").append(msg.content);
			} 
		}
	}


	function  subSend(){
		/* var value= $("#msg").val();
		ws.send(value);
		$("#msg").val("") */  
		
		var ss = $("#userList :checked");
		var val = $("#msg").val();
		var obj = null;
		if(ss.size() == 0){
			obj={
				msg:val,
				type:1   // 1是广播 2是单聊
			}
		}else{
			var users = "";
			var obj=document.getElementsByName("checkbox");  // 选择所有name="'checkbox'"的对象，返回数组 
			for(var i=0;i<obj.length;i++){
				if(obj[i].checked){
					users += obj[i].value+",";
				}
			}
			 
			obj={
				to:users,
				msg:val,
				type:2
			} 
		}
		var str = JSON.stringify(obj);
		ws.send(str); 
		$("#msg").val("");
		 
	}
	 
</script>
</head>
<body>

	<h3>欢迎 ${sessionScope.username } 使用本系统！！<button onclick="subClose();">退出聊天</button></h3>
	

	<div  id="content"  style="
		border: 1px solid black; width: 400px; height: 300px;
		float: left;
	"  ></div>
	<div  id="userList"  style="
		border: 1px solid black; width: 100px; height: 300px;
		float:left;
	"  ></div>

	<div  style="clear: both;" >
		<input id="msg"  /><button  onclick="subSend();"  >send</button>
	</div>


</body>
</html>