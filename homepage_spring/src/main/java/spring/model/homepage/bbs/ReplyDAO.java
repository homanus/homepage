package spring.model.homepage.bbs;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO implements IReplyDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	@Override
	public boolean create(Object dto) throws Exception {
		boolean flag = false;
		int cnt = mybatis.insert("reply.create",dto);
		if(cnt >0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public Object read(Object rnum) throws Exception {
		
		return mybatis.selectOne("reply.read",rnum);
	}
	
	@Override
	public boolean update(Object dto) throws Exception {
		boolean flag = false;
		int cnt = mybatis.update("reply.update",dto);
		if(cnt > 0 )flag = true;
		
		return flag;
	}
	
	@Override
	public boolean delete(Object rnum) throws Exception {
		boolean flag = false;
		
		int cnt= mybatis.delete("reply.delete",rnum);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	@Override
	public boolean bdelete(int bbsno) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.delete("reply.bdelete",bbsno);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	@Override
	public List list(Map map) throws Exception {
		
		return mybatis.selectList("reply.list",map);
	}
	
	public int total(int bbsno) throws Exception {
		
		return mybatis.selectOne("reply.total",bbsno);
	}

	@Override
	public int total(Map map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
