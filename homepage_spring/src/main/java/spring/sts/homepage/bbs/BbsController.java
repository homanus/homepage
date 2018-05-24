package spring.sts.homepage.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.model.homepage.bbs.BbsDTO;
import spring.model.homepage.bbs.BbsMgr;
import spring.model.homepage.bbs.IBbsDAO;
import spring.model.homepage.bbs.ReplyDAO;
import spring.sts.homepage.utility.Utility;

@Controller
public class BbsController {
	
	@Autowired
	private IBbsDAO dao;
	
	@Autowired
	private BbsMgr mgr;
	
	@Autowired
	private ReplyDAO rdao;
	
	@RequestMapping("/bbs/create")
	public String createForm() {
		return "/bbs/create";
	}
	
	@RequestMapping("/bbs/createProc")
	public String createProc(HttpServletRequest request,BbsDTO dto) {
		
		String basePath = request.getRealPath("/storage_bbs");
		
		
		int filesize = (int)dto.getFilenameMF().getSize();
		
		String filename = Utility.saveFileSpring30(dto.getFilenameMF(), basePath);
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		try {
			dao.create(dto);
			return "redirect:/bbs/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "/error";
		}
	}
	
	@RequestMapping("/bbs/list")
	public String list(HttpServletRequest request) {
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")) {
			word = "";
		}
		
		int nowPage = 1;
		int recordPerPage = 5;
		
		if(request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("col", col);
		map.put("word", word);
		
		
		try {
			
			List<BbsDTO> list = dao.list(map);
			int totalRecord = dao.total(map);
			
			String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
			
			int nPage = 1;
			
			request.setAttribute("paging", paging);
			request.setAttribute("list", list);
			request.setAttribute("col", col);
			request.setAttribute("word", word);
			request.setAttribute("nowPage", nowPage);
			request.setAttribute("nPage", nPage);
			request.setAttribute("rdao", rdao);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "/bbs/list";
	}
}
