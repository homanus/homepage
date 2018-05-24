package spring.model.homepage.bbs;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BbsDAO implements IBbsDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	@Override
	public boolean create(Object dto) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.insert("bbs.create",dto);
		
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public List list(Map map) throws Exception {
		
		List list = mybatis.selectList("bbs.list",map);
		
		return list;
	}

	@Override
	public Object read(Object pk) throws Exception {

		BbsDTO dto = mybatis.selectOne("bbs.read",pk);
		
		return dto;
	}

	@Override
	public boolean update(Object dto) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.update("bbs.update",dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean delete(Object pk) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.delete("bbs.delete",pk);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public int total(Map map) throws Exception {
		int total = 0;
		total = mybatis.selectOne("bbs.total",map);
		
		return total;
	}

	@Override
	public String getFname(int bbsno) {
		String fname = null;
		
		fname = mybatis.selectOne("bbs.getFname",bbsno);
		
		return fname;
	}

	@Override
	public boolean checkRefnum(int bbsno) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("bbs.checkRefnum", bbsno);
		
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public void upviewcnt(int bbsno) {
		mybatis.update("bbs.upViewcnt",bbsno);
	}

	@Override
	public boolean passcheck(Map map) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("bbs.passcheck", map);
		if(cnt > 0)flag = true;

		return flag;
	}

	@Override
	public BbsDTO readReply(int bbsno) {
		BbsDTO dto = null;
		
		dto = mybatis.selectOne("bbs.readReply", bbsno);
		
		return dto;
	}

	@Override
	public boolean createReply(BbsDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.update("bbs.createReply",dto);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public void upAnsnum(Map map) {
		mybatis.update("bbs.upAnsnum",map);
	}

}
