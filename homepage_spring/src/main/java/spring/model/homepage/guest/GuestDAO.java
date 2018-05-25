package spring.model.homepage.guest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GuestDAO implements IGuestDAO{
	
	@Autowired
	SqlSessionTemplate mybatis;
	
	@Override
	public boolean idCheck(Map map){
		boolean flag = false;
		
		int cnt = mybatis.selectOne("guest.idCheck",map);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	@Override
	public Object read(Object gno){
		GuestDTO dto = null;
		
		dto = mybatis.selectOne("guest.read",gno);
		
		return dto;
	}
	
	@Override
	public int total(Map map){
		int total=0;
		
		total = mybatis.selectOne("guest.total",map);
		
		return total;
		
	}
	@Override
	public String getFname(int gno){
		String fname = null;
		
		fname = mybatis.selectOne("guest.getFname",gno);
		
		return fname;
	}
	@Override
	public boolean create(Object dto){
		boolean flag = false;
		
		int cnt = mybatis.insert("guest.create",dto);
		if(cnt > 0)flag=true;
		
		return flag;
		
	}
	
	@Override
	public List<GuestDTO> list(Map map){
		List<GuestDTO> list = new ArrayList<GuestDTO>();
		
		list = mybatis.selectList("guest.list",map);
		
		return list;
	}
	
	@Override
	public boolean update(Object dto){
		boolean flag = false;
		
		int cnt = mybatis.update("guest.update",dto);
		if(cnt>0)flag=true;
		return flag;
		
	}
	
	@Override
	public boolean delete(Object gno){
		boolean flag = false;
		
		int cnt = mybatis.delete("guest.delete",gno);
		if(cnt>0)flag=true;
		
		return flag;
	}

}
