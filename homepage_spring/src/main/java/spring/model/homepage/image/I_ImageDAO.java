package spring.model.homepage.image;

import java.util.List;
import java.util.Map;

import homepage.DAOSTDInter;

public interface I_ImageDAO extends DAOSTDInter {
	public boolean pwCheck(Map map) throws Exception;
	public String getFname(int ino) throws Exception;
	public List imglist(int ino) throws Exception;
}
