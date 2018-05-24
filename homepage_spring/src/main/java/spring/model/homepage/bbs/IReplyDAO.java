package spring.model.homepage.bbs;

import homepage.DAOSTDInter;

public interface IReplyDAO extends DAOSTDInter {
	public boolean bdelete(int bbsno) throws Exception;
}
