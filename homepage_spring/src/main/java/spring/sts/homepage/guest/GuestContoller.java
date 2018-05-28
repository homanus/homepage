package spring.sts.homepage.guest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.homepage.guest.GuestDAO;
import spring.model.homepage.guest.GuestDTO;
import spring.sts.homepage.utility.Utility;

@Controller
public class GuestContoller {
	
	@Autowired
	private GuestDAO dao;
	
	@RequestMapping("/guest/updateProc")
	public String update(GuestDTO dto,HttpServletRequest request,String oldfile,Model model) {
		
		int size = (int)dto.getFnameMF().getSize();
		String basePath = request.getRealPath("/storage_guest");
		String fname = oldfile;
		if(size > 0) {
			fname = Utility.saveFileSpring30(dto.getFnameMF(), basePath);
			Utility.deleteFile(basePath, oldfile);
		}
		dto.setFname(fname);
		boolean flag = dao.update(dto);
		
		if(flag) {
			model.addAttribute("flag",flag);
			model.addAttribute("col",request.getParameter("col"));
			model.addAttribute("word",request.getParameter("word"));
			model.addAttribute("nowPage",request.getParameter("nowPage"));
			return "redirect:/guest/list";
		}else {
			return"error";
		}
	}
	
	@RequestMapping("/guest/update")
	public String update(HttpServletRequest request) {
		
		int gno = Integer.parseInt(request.getParameter("gno"));
		GuestDTO dto = (GuestDTO) dao.read(gno);
		
		HttpSession session = request.getSession();
		
		Map map = new HashMap();
		map.put("id", session.getAttribute("id"));
		map.put("gno", dto.getGno());
		
		boolean flag = dao.idCheck(map);

		String oldfile = dto.getFname();
		
		request.setAttribute("flag", flag);
		request.setAttribute("oldfile", oldfile);
		request.setAttribute("dto", dto);
		
		return "/guest/update";
	}
	
	@RequestMapping("/guest/deleteProc")
	public String delete(int gno,Model model,HttpServletRequest request) {
		String fname = dao.getFname(gno);
		String basePath = request.getRealPath("/storage_guest");
		boolean flag = dao.delete(gno);
		if(flag) {
			if(fname!=null && !fname.equals("default.jpg")) {
				Utility.deleteFile(basePath, fname);
			}
			model.addAttribute("col",request.getParameter("col"));
			model.addAttribute("word",request.getParameter("word"));
			model.addAttribute("nowPage",request.getParameter("nowPage"));
			model.addAttribute("flag",flag);
			return "/guest/deleteProc";
		}else {
			return "error";
		}
		
	}
	
	@RequestMapping("/guest/delete")
	public String delete(HttpServletRequest request,HttpSession session) {
		
		int gno = Integer.parseInt(request.getParameter("gno"));
		
		Map map = new HashMap();
		map.put("id", session.getAttribute("id"));
		map.put("gno", gno);
		
		boolean flag = dao.idCheck(map);
		
		request.setAttribute("flag", flag);
		
		return "/guest/deleteForm";
	}
	
	@RequestMapping("/guest/create")
	public String create(GuestDTO dto,Model model,HttpServletRequest request) {
		
		String basePath = request.getRealPath("/storage_guest");
		
		String filename = "default.jpg";
		
		int size=(int)dto.getFnameMF().getSize();
		if(size>0) {
			filename = Utility.saveFileSpring30(dto.getFnameMF(), basePath);
		}
		
		dto.setFname(filename);
		
		if(dao.create(dto)) {
			model.addAttribute("col",request.getParameter("col"));
			model.addAttribute("word",request.getParameter("word"));
			model.addAttribute("nowPage",request.getParameter("nowPage"));
			return "redirect:/guest/list";
		}else {
			return "error";
		}
	}
	
	@RequestMapping("/guest/list")
	public String list(HttpServletRequest request) {
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")) {
			word = "";
		}
		
		int nowPage = 1;
		int recordPerPage = 3;
		
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
		
		String id = (String)request.getSession().getAttribute("id");
		
		List list = dao.list(map);
		int totalRecord = dao.total(map);
		
		String paging = Utility.paging3_guest(totalRecord, nowPage, recordPerPage, col, word,request);
		
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("id", id);
		request.setAttribute("paging", paging);
		
		return "/guest/list";
	}
}
