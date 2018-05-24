package spring.model.homepage.bbs;

import java.util.Map;

import homepage.DAOSTDInter;

public interface IBbsDAO extends DAOSTDInter {
	public String getFname(int bbsno) throws Exception;
	public boolean checkRefnum(int bbsno) throws Exception;
	public void upviewcnt(int bbsno) throws Exception;
	public boolean passcheck(Map map) throws Exception;
	public BbsDTO readReply(int bbsno) throws Exception;
	public boolean createReply(BbsDTO dto) throws Exception;
	public void upAnsnum(Map map) throws Exception;

}
