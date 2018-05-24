package spring.model.homepage.chat;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Chat_RoomDAO implements IChat_RoomDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	@Override
	public boolean crate_room_check(String id) {
		boolean flag = false;
		int cnt = mybatis.selectOne("chat.crate_room_check",id);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public boolean chat_room_Check(Map map) {
		boolean flag = false;
		int cnt = mybatis.selectOne("chat.chat_room_Check",map);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public boolean create(Object dto) {
		boolean flag = false;
		int cnt = mybatis.insert("chat.create",dto);
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public Object read(Object chat_index) {
		Chat_RoomDTO dto = mybatis.selectOne("chat.read",chat_index);
		
		return dto;
	}
	
	@Override
	public boolean update(Object dto) {
		boolean flag = false;
		int cnt = mybatis.update("chat.update",dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public boolean delete(Object chat_index) throws Exception {
		boolean flag = false;
		int cnt = mybatis.delete("chat.delete",chat_index);
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public List list(Map map) throws Exception{
		
		List<Chat_RoomDTO> list = mybatis.selectList("chat.list",map);
		
		return list;
	}

	@Override
	public int total(Map map) throws Exception {
		int total = 0;
		
		total = mybatis.selectOne("chat.total",map);
		
		return total;
	}

}
