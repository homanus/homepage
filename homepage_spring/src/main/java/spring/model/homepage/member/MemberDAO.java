package spring.model.homepage.member;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAO implements IMemberDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public String emailcode() throws Exception {
		String code = "";
		int a[] = new int[6];
		
		for(int i=0; i<6; i++){
			a[i] = (int)(Math.random()*9+1);
			code += a[i];
			//1~9
		}
		return code;
	}
	
	public boolean create(Object dto) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.insert("member.create",dto); 
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean updatePasswd(MemberDTO dto)  throws Exception{
		boolean flag = false;
		
		int cnt = mybatis.update("member.updatePasswd",dto);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean update(Object dto) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.update("member.update",dto);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean updateGrade_S(Map map) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.update("member.updateGrade_S",map);
		
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean updateGrade_V(Map map) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.update("member.updateGrade_V",map);
		
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	public MemberDTO read(Object id) throws Exception {
		MemberDTO dto = mybatis.selectOne("member.read",id);
		
		return dto;
	}
	
	public boolean delete(Object id) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.delete("member.delete",id);
		
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	public String Find_Id(String email) throws Exception {
		String id = "";
		
		id = mybatis.selectOne("member.Fine_Id",email);
		
		return id;
	}
	
	public List<MemberDTO> list(Map map) throws Exception {
		List<MemberDTO> list = mybatis.selectList("member.list",map);
		
		return list;
	}
	
	public boolean loginCheck(Map map) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("member.loginCheck",map);
		
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public int total(Map map) throws Exception {
		int total = mybatis.selectOne("member.total",map);
		
		return total;
	}
	
	public boolean duplicateId(String id) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("member.duplicateId",id);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public boolean duplicateEmail(String email) throws Exception {
		boolean flag= false;
		
		int cnt = mybatis.selectOne("member.duplicateEmail",email);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public String getFname(String id) throws Exception {
		String fname = "";
		
		fname = mybatis.selectOne("member.getFname",id);
		
		return fname;
	}
	
	public boolean CheckPW(Map map) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("member.CheckPW",map);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public String getGrade(String id) throws Exception {
		
		return mybatis.selectOne("member.getGrade",id);
	}





}
