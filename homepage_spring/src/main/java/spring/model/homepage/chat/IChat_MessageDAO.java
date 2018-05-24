package spring.model.homepage.chat;

import java.util.List;
import java.util.Map;

import homepage.DAOSTDInter;


public interface IChat_MessageDAO extends DAOSTDInter {
	
	public String getRealTime() throws Exception;

	String getNcikname(String id) throws Exception;

	public int insert_check(int chat_index) throws Exception;

	public List Chat_content_read(Map map) throws Exception;

	public boolean Canyou_Seethem(Map map) throws Exception;
	
	public String getTime() throws Exception;
}
