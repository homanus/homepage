package spring.sts.homepage.image;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.homepage.image.ImageDAO;
import spring.model.homepage.image.ImageDTO;
import spring.sts.homepage.utility.Utility;

@Controller
public class ImageController {
	
	@Autowired
	private ImageDAO dao;
	
	@RequestMapping("/image/create")
	public String create(HttpServletRequest request) {
		return "/image/create";
	}
	
	@RequestMapping("/image/createProc")
	public String createProc(HttpServletRequest request,ImageDTO dto) {
		String basePath = request.getRealPath("/storage_image");
		
		String fname = Utility.saveFileSpring30(dto.getFnameMF(), basePath);
		dto.setFname(fname);
		
		try {
			dao.create(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			Utility.deleteFile(basePath, dto.getFname());
		}
		
		return "redirect:/image/list";
	}
	
	@RequestMapping("/image/list")
	public String list(HttpServletRequest request) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")){
			word = "";
		}
		
		int nowPage = 1;
		int recordPerPage = 5;
		
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage*recordPerPage;
		
		Map map = new HashMap();
		map.put( "col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		


		List<ImageDTO> list;
		try {
			list = dao.list(map);
			int totalRecord = dao.total(map);
			String paging = Utility.paging3_image(totalRecord, nowPage, recordPerPage, col, word, request);
			
			request.setAttribute("paging", paging);
			request.setAttribute("list", list);
			request.setAttribute("nowPage", nowPage);
			request.setAttribute("col", col);
			request.setAttribute("word", word);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/image/list";
	}
	
	
	@RequestMapping("/image/read")
	public String read(HttpServletRequest request, int ino) {
		try {
			ImageDTO dto = (ImageDTO)dao.read(ino);
			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
			
			List list = dao.imglist(dto.getIno());
			
			request.setAttribute("dto", dto);
			request.setAttribute("list", list);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/image/read";
	}
	
	@RequestMapping("/image/update")
	public String update(HttpServletRequest request, int ino) {
		try {
			ImageDTO dto = (ImageDTO)dao.read(ino);
			request.setAttribute("dto", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "/image/update";
	}
	
	@RequestMapping("/image/updateProc")
	public String updateProc(ImageDTO dto, HttpServletRequest request,
			String oldfile,Model model,int ino, String passwd) {
		
		String basePath = request.getRealPath("/storage_image");
		int size = (int)dto.getFnameMF().getSize();
		
		String fname = oldfile;
		if(size > 0) {
			Utility.deleteFile(basePath, oldfile);
			fname = Utility.saveFileSpring30(dto.getFnameMF(), basePath);
		}
		
		dto.setFname(fname);
		
		try {
			Map map = new HashMap();
			map.put("ino", ino);
			map.put("passwd", passwd);
			if(dao.pwCheck(map)) {
				dao.update(dto);
				model.addAttribute("col",request.getParameter("col"));
				model.addAttribute("word",request.getParameter("word"));
				model.addAttribute("nowPage",request.getParameter("nowPage"));
			}else {
				return "/image/passwdError";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/image/list";
	}
	
	@RequestMapping("/image/delete")
	public String delete() {
		return "/image/delete";
	}
	
	@RequestMapping("/image/passwdError")
	public String passwdError() {
		return "/image/passwdError";
	}
	
	@RequestMapping("/image/deleteProc")
	public String deleteProc(int ino, String passwd,
			HttpServletRequest request,Model model,
			String fname) {
		Map map = new HashMap();
		map.put("ino", ino);
		map.put("passwd", passwd);
		
		try {
			if(dao.pwCheck(map)) {
				dao.delete(ino);
				String basePath = request.getRealPath("/storage_image");
				Utility.deleteFile(basePath, fname);
				model.addAttribute("nowPage",request.getParameter("nowPage"));
				model.addAttribute("col",request.getParameter("col"));
				model.addAttribute("word",request.getParameter("word"));
				return "redirect:/image/list";
			}else {
				return "/image/passwdError";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "/image/error";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
