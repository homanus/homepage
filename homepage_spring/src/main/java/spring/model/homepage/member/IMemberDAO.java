package spring.model.homepage.member;

import java.util.List;
import java.util.Map;

import homepage.DAOSTDInter;


public interface IMemberDAO extends DAOSTDInter {
	public String emailcode() throws Exception;
	public boolean updatePasswd(MemberDTO dto)  throws Exception;
	public boolean update(Object dto) throws Exception;
	public boolean updateGrade_S(Map map) throws Exception;
	public boolean updateGrade_V(Map map) throws Exception;
	public MemberDTO read(Object id) throws Exception;
	public boolean delete(Object id) throws Exception;
	public String Find_Id(String email) throws Exception;
	public List<MemberDTO> list(Map map) throws Exception;
	public boolean loginCheck(Map map) throws Exception;
	public int total(Map map) throws Exception;
	public boolean duplicateId(String id) throws Exception;
	public boolean duplicateEmail(String email) throws Exception;
	public String getFname(String id) throws Exception;
	public boolean CheckPW(Map map) throws Exception;
	public String getGrade(String id) throws Exception;
	
}
