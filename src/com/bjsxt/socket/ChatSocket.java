package com.bjsxt.socket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.bjsxt.vo.ContentVo;
import com.bjsxt.vo.Message;
import com.google.gson.Gson;
 
@ServerEndpoint("/chatSocket")
public class ChatSocket{
	
	private String username;
	private static List<Session> sessions = new ArrayList<Session>();
	private  static  Map<String, Session>  map=new HashMap<String, Session>();
	private static List<String> names = new ArrayList<String>();
	
	@OnOpen
	public  void open(Session  session){
		
//		String  queryString = session.getQueryString();
//		username = queryString.split("=")[1];
		
		Map<String, List<String>> requestParameterMap = session.getRequestParameterMap();
		username = requestParameterMap.get("username").get(0);
		
		
		
		this.names.add(username);
		this.sessions.add(session);
		this.map.put(this.username, session);
		
		String msg = "»¶Ó­"+this.username+"½øÈëÁÄÌìÊÒ£¡£¡£¡<br/>";
		
		Message message = new Message();
		message.setWelcome(msg);
		message.setUsernames(this.names);
		
		this.broadcast(this.sessions,message.toJson());
 
	}
	 
	@OnClose
	public  void close(Session session){
 
		this.sessions.remove(session);
		this.names.remove(this.username);
		
		String msg = this.username+"ÍË³öÁÄÌìÊÒ£¡£¡£¡<br/>";
		
		Message message = new Message();
		message.setWelcome(msg);
		message.setUsernames(this.names);
		
		this.broadcast(this.sessions,message.toJson());
		 
	}
	
	private static Gson gson = new Gson();
	
	@OnMessage
	public  void message(Session  session,String json ){
		ContentVo vo = gson.fromJson(json, ContentVo.class);
		Message  message=new Message(); 
		if(vo.getType() == 1){
			// ¹ã²¥
			message.setContent(this.username, vo.getMsg());
			 
			broadcast(sessions, message.toJson());
			
		}else{
			// Èº·¢
			
			String to = vo.getTo();
			String[] username = to.split(",");
			for(int i=0;i<username.length;i++){
				Session to_session = this.map.get(username[i]);
				message.setContent(this.username, "Ë½ÁÄ£º"+vo.getMsg());
				try {
					to_session.getBasicRemote().sendText(message.toJson());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		 
	}

	// ¹ã²¥
	public void broadcast(List<Session>  ss ,String msg ){
		
		for (Iterator iterator = ss.iterator(); iterator.hasNext();) {
			Session session = (Session) iterator.next();
			try {
				session.getBasicRemote().sendText(msg);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	 
}
