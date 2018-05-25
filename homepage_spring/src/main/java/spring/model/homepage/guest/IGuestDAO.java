package spring.model.homepage.guest;

import java.util.Map;

import homepage.DAOSTDInter;

public interface IGuestDAO extends DAOSTDInter {
	public boolean idCheck(Map map) throws Exception;
	public String getFname(int gno) throws Exception;
}
