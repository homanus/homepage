package spring.model.homepage.image;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ImageDAO implements I_ImageDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	

	@Override
	public boolean create(Object dto) throws Exception {
		boolean flag = false;
		int cnt = mybatis.insert("image.create",dto);
		if(cnt>0) flag = true;
		
		return flag;
	}

	@Override
	public List list(Map map) throws Exception {
		List list = mybatis.selectList("image.list",map);
		return list;
	}

	@Override
	public Object read(Object pk) throws Exception {

		ImageDTO dto = mybatis.selectOne("image.read",pk);
		return dto;
	}

	@Override
	public boolean update(Object dto) throws Exception {
		boolean flag = false;
		
		int cnt = mybatis.update("image.update",dto);
		if(cnt>0)flag = true;
		
		return flag;
	}

	@Override
	public boolean delete(Object pk) throws Exception {
		boolean flag = false;
		int cnt = mybatis.delete("image.delete",pk);
		if(cnt>0) flag = true;
		return flag;
	}

	@Override
	public int total(Map map) throws Exception {
		int total = 0;
		total = mybatis.selectOne("image.total",map);
		return total;
	}



	@Override
	public boolean pwCheck(Map map) throws Exception {
		boolean flag = false;
		int cnt = mybatis.selectOne("image.pwCheck",map);
		if(cnt>0)flag = true;
		
		return flag;
	}



	@Override
	public String getFname(int ino) throws Exception {
		String fname = "";
		
		fname = mybatis.selectOne("image.getFname",ino);
		
		return fname;
	}



	@Override
	public List imglist(int ino) throws Exception {
		List list = new ArrayList();
		
		Map map = mybatis.selectOne("image.imglist",ino);
		
		java.math.BigDecimal pre_ino2 = (BigDecimal) map.get("PRE_INO2");
		java.math.BigDecimal pre_ino1 = (BigDecimal) map.get("PRE_INO1");
		java.math.BigDecimal ino1 = (BigDecimal) map.get("INO");
		java.math.BigDecimal nex_ino1 = (BigDecimal) map.get("NEX_INO1");
		java.math.BigDecimal nex_ino2 = (BigDecimal) map.get("NEX_INO2");
		
		java.math.BigDecimal noArr[] = {
				pre_ino2,
				pre_ino1,
				ino1,
				nex_ino1,
				nex_ino2
				};
		String files[] = {
				(String)map.get("PRE_FILE2"),
				(String)map.get("PRE_FILE1"),
				(String)map.get("FNAME"),
				(String)map.get("NEX_FILE1"),
				(String)map.get("NEX_FILE2")
				};
		
		list.add(files);
		list.add(noArr);
		
		return list;
		
		
	}

}
