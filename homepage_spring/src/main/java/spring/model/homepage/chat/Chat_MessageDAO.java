package spring.model.homepage.chat;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Chat_MessageDAO implements IChat_MessageDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	@Override
	public String getTime() {
		String getTime = "";
		try {
			getTime = mybatis.selectOne("chat.getTime");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return getTime;
	}
	
	@Override
	public boolean Canyou_Seethem(Map map) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("chat.Canyou_Seethem", map);
		if(cnt>0) {
			flag = true;
		}
		return flag;
		
	}
	
	
	@Override
	public List Chat_content_read(Map map) throws Exception {

		List list = mybatis.selectList("chat.Chat_content_read", map);
		
		return list;
	}
	
	@Override
	public int insert_check(int chat_index) throws Exception {
		int table_count = 0;
		
		table_count = mybatis.selectOne("chat.table_count", chat_index);
		
		return table_count;
	}
	
	
	@Override
	public String getRealTime() throws Exception {
		String realtime = "";
		
		realtime = mybatis.selectOne("chat.getRealTime");
		
		return realtime;
	}
	
	@Override
	public String getNcikname(String id) throws Exception {
		String nickname = "";
		
		nickname = mybatis.selectOne("chat.getNickname",id);
		
		return nickname;
	}
	
	@Override
	public boolean create(Object dto) throws Exception {
		boolean flag = false;
		int cnt = mybatis.insert("chat.create_content",dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public Object read(Object chat_index) throws Exception {
		Chat_MessageDTO dto = mybatis.selectOne("chat.read_content",chat_index);
		return dto;
	}

	

	@Override
	public List list(Map map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public boolean update(Object dto) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object pk) throws Exception {
		boolean flag = false;
		int cnt = mybatis.delete("chat.delete_message",pk);
		if(cnt>0)flag=true;
		
		return flag;
	}

	@Override
	public int total(Map map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}





}
