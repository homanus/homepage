package spring.sts.homepage.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	
	@RequestMapping("/bbs/read")
	public String read(HttpServletRequest request, Model model) {
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		
		try {
			dao.upviewcnt(bbsno);
			BbsDTO dto = (BbsDTO) dao.read(bbsno);
			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
			request.setAttribute("dto", dto);
			
			/**댓글 관련**/
			String url = "read";
			int nPage = 1;
			int recordPerPage = 5;
			if(request.getParameter("nPage")!=null) {
				nPage = Integer.parseInt(request.getParameter("nPage"));
			}
			
			
			int sno = ((nPage-1)*recordPerPage)+1;
			int eno = (nPage*recordPerPage);
			
			Map map = new HashMap();
			map.put("sno", sno);
			map.put("eno", eno);
			map.put("bbsno", bbsno);
			
			List rlist = rdao.list(map);
			
			int total = rdao.total(bbsno);
			String col = request.getParameter("col");
			String word = request.getParameter("word");
			int nowPage = Integer.parseInt(request.getParameter("nowPage"));
			
			String paging = Utility.paging2(total, nPage, recordPerPage, url, bbsno, nowPage, col, word);
			
			
			model.addAttribute("rlist",rlist);
			model.addAttribute("paging",paging);
			model.addAttribute("nPage",nPage);
			
			return "/bbs/read";
		}catch(Exception e){
			e.printStackTrace();
			return "error";
		}
		
	}
	
	@RequestMapping("/bbs/update")
	public String update(int bbsno,HttpServletRequest request) {
		
		try {
			BbsDTO dto = (BbsDTO) dao.read(bbsno);
			request.setAttribute("dto", dto);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/bbs/update";
	}
	
	@RequestMapping("/bbs/updateProc")
	public String updateProc(BbsDTO dto, String oldfile, HttpServletRequest request, Model model) {
		String basePath = request.getRealPath("/storage_bbs");
		String filename = Utility.saveFileSpring30(dto.getFilenameMF(), basePath);
		
		int filesize = (int) dto.getFilenameMF().getSize();
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		Map map = new HashMap();
		map.put("passwd", dto.getPasswd());
		map.put("bbsno", dto.getBbsno());
		
		try {
			boolean pflag = dao.passcheck(map);
		
			if(pflag) {
				if(dao.update(dto)) {
					if(filesize > 0)
						Utility.deleteFile(basePath, oldfile);
					model.addAttribute("col",request.getParameter("col"));
					model.addAttribute("word",request.getParameter("word"));
					model.addAttribute("nowPage",request.getParameter("nowPage"));
					return "redirect:/bbs/read?bbsno="+dto.getBbsno();
				}else {
					return "/bbs/error";
				}
			}else {
				return "/bbs/passwdError";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "/bbs/error";
		}
	}
	
	@RequestMapping("/bbs/delete")
	public String delete(HttpServletRequest request) {
			int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		try {
			boolean flag = dao.checkRefnum(bbsno);
			request.setAttribute("flag", flag);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/bbs/delete";
	}
	
	@RequestMapping("/bbs/deleteProc")
	public String deleteProc(BbsDTO dto,String oldfile,Model model,HttpServletRequest request) {
		
		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());
		
		try {
			boolean pflag = dao.passcheck(map);
		
			if(pflag) {
				//flag = dao.delete(dto.getBbsno());
					mgr.delete(dto.getBbsno());
				
					String basePath = request.getRealPath("/storage_bbs");
					Utility.deleteFile(basePath, oldfile);
				
					model.addAttribute("col",request.getParameter("col"));
					model.addAttribute("word",request.getParameter("word"));
					model.addAttribute("nowPage",request.getParameter("nowPage"));
					
					return "redirect:/bbs/list";
			}else {
				return "/bbs/passwdError";
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return "/error/error";
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
