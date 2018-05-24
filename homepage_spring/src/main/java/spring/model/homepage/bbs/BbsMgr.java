package spring.model.homepage.bbs;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BbsMgr {
	@Autowired
	private BbsDAO dao;
	
	@Autowired
	private ReplyDAO rdao;
	
	public void reply(BbsDTO dto) {
			Map map = new HashMap();
			map.put("grpno", dto.getGrpno());
			map.put("ansnum", dto.getAnsnum());
			try {
				dao.upAnsnum(map);
				dao.createReply(dto);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public void delete(int bbsno){
		try {
			rdao.bdelete(bbsno);
			dao.delete(bbsno); //댓글을 포함하고 있는 게시글 삭제
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //댓글들 삭제
	}
}
