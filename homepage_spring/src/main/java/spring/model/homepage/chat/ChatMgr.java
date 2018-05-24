package spring.model.homepage.chat;

import java.sql.Connection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatMgr {
	
	@Autowired
	private Chat_RoomDAO rdao;
	
	@Autowired
	private Chat_MessageDAO mdao;
	
	public void delete(int chat_index) {
		
		try {
			
			mdao.delete(chat_index);
			rdao.delete(chat_index);
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}
		
	}

}
