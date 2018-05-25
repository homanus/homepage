package spring.sts.homepage.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import spring.model.homepage.member.IMemberDAO;
import spring.model.homepage.member.MemberDTO;
import spring.model.homepage.member.SMTPAuthenticatior;
import spring.sts.homepage.utility.Utility;

@Controller
public class MemberController {
	
	@Autowired
	private IMemberDAO dao;
	
	@RequestMapping("/member/agreement")
	public String agreement() {
		return "/member/agreement";
	}
	
	@RequestMapping("/member/createForm")
	public String createForm() {
		return "/member/create";
	}
	
	@RequestMapping("/member/createProc")
	public String createProc(MemberDTO dto,HttpServletRequest request,Model model) throws Exception {
		String basePath = request.getRealPath("/storage_member");
		System.out.println("호출");
		String fname = "";
		
		int size = (int)dto.getFilenameMF().getSize();
			if(size>0) {
				fname = Utility.saveFileSpring30(dto.getFilenameMF(), basePath);
			}else {
				fname = "member.jpg";
			}
		dto.setFname(fname);
		dto.setFilesize(size);
		
		if(dao.create(dto)) {
			return "redirect:/";
		}else {
			return "error";
		}
	}

	@RequestMapping("/member/email_form")
	public String email_form() {
		
		return "/member/email_form";
	}
	
	@RequestMapping("/member/email_proc")
	public String email_proc(HttpServletRequest request) throws Exception {
		
		String email = request.getParameter("email");
		boolean flag = dao.duplicateEmail(email);
		String code = dao.emailcode();
		
		request.setAttribute("flag", flag);
		request.setAttribute("code", code);
		
		return "/member/email_proc";
		
	}
	
	@RequestMapping("/member/sendMail")
	public ModelAndView sendMail(Model model, HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		boolean sendFlag = false;
		
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		// 입력값 받음
		 
		Properties p = new Properties(); // 정보를 담을 객체
		 
		p.put("mail.smtp.host","smtp.gmail.com"); // 구글 SMTP
		 
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		// SMTP 서버에 접속하기 위한 정보들
		 
		try{
		    Authenticator auth = new SMTPAuthenticatior();
		    Session ses = Session.getInstance(p, auth);
		     
		    ses.setDebug(true);
		     
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		    msg.setSubject(subject); // 제목
		     
		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr); // 보내는 사람
		     
		    Address toAddr = new InternetAddress(to);
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
		     
		    Transport.send(msg); // 전송
		    
		    sendFlag = true;
		    
		} catch(Exception e){
			
			//flag 값에 따라 jsp페이지에서 보여줄 화면 및 실행 될 스크립트 함수가 달라진다.
			
		    e.printStackTrace();
		    
		}
		
		modelAndView.addObject("sendFlag",sendFlag);
		return modelAndView;
	}
	
	@RequestMapping("/member/email_proc_send")
	public ModelAndView email_proc_send(HttpServletRequest request) {
		
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		modelAndView.addObject("from",from);
		modelAndView.addObject("to",to);
		modelAndView.addObject("subject",subject);
		modelAndView.addObject("content",content);
		
		return modelAndView;
	}
	
	@RequestMapping("/member/id_form")
	public String id_form() {
		
		return "/member/id_form";
	}
	
	@RequestMapping("/member/id_proc_check")
	public ModelAndView id_proc_check(HttpServletRequest request,Model model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		String id = request.getParameter("id");
		
		boolean flag = false;
		
		flag = dao.duplicateId(id);
		
		modelAndView.addObject("flag",flag);
		modelAndView.addObject("id",id);
		
		return modelAndView;
	}
	
	@RequestMapping("/member/loginForm")
	public String loginForm(HttpServletRequest request) {
		String c_id = "";     // ID 저장 여부를 저장하는 변수, Y
		String c_id_val = ""; // ID 값
		 
		Cookie[] cookies = request.getCookies(); 
		Cookie cookie=null; 
		 
		if (cookies != null){ 
		 for (int i = 0; i < cookies.length; i++) { 
		   cookie = cookies[i]; 
		 
		   if (cookie.getName().equals("c_id")){ 
		     c_id = cookie.getValue();     // Y 
		   }else if(cookie.getName().equals("c_id_val")){ 
		     c_id_val = cookie.getValue(); // user1... 
		   } 
		 } 
		}
		request.setAttribute("c_id", c_id);
		request.setAttribute("c_id_val", c_id_val);
		return "/member/loginForm";
	}
	 
	@RequestMapping("/member/loginProc")
	public String loginProc(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		String bbsno = request.getParameter("bbsno");
		String nPage = request.getParameter("nPage");
		String nowPage = request.getParameter("nowPage");
		String col = request.getParameter("col");
		String word = request.getParameter("word");
		String rflag = request.getParameter("rflag");

		Map map = new HashMap();
		map.put("id", id);
		map.put("passwd", passwd);

		boolean flag = dao.loginCheck(map);
		String grade=null;
		String url = "/member/passwdError";
		
		
		HttpSession session = request.getSession();

		if(flag){//flag start
			grade = dao.getGrade(id);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);
			
			Cookie cookie = null; 
		       
		    String c_id = request.getParameter("c_id"); // Y, 아이디 저장 여부 
		       
		    if (c_id != null){  // 처음에는 값이 없음으로 null 체크로 처리
		      cookie = new Cookie("c_id", "Y");    // 아이디 저장 여부 쿠키 
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록 
		   
		      cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키  
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록  
		         
		    }else{ 
		      cookie = new Cookie("c_id", "");     // 쿠키 삭제 
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		         
		      cookie = new Cookie("c_id_val", ""); // 쿠키 삭제 
		      cookie.setMaxAge(0);
		      response.addCookie(cookie);
		    }//else END
		    
		    url = "redirect:/";
		    
		    if(rflag != null && !rflag.equals("")) {
		    	model.addAttribute("bbsno",bbsno);
		    	model.addAttribute("nPage",nPage);
		    	model.addAttribute("col",col);
		    	model.addAttribute("word",word);
		    	model.addAttribute("nowPage",nowPage);
		    	url = "redirect:"+rflag;
		    }//if rflag END
		    
		}//flag END
		
		return url;
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping("/member/passwordCheck")
	public String passwordCheck() {
		
		return "/member/passwordCheck";
	}
	
	@RequestMapping("/member/read")
	public String read(HttpServletRequest request,HttpSession session) throws Exception {
		String id = request.getParameter("id");
		if(id == null) {
			id = (String)session.getAttribute("id");
		}
		
		MemberDTO dto = dao.read(id);
		
		request.setAttribute("id", id);
		request.setAttribute("dto", dto);
		
		return "/member/read";
	}
	
	@RequestMapping("/admin/list")
	public String list(HttpServletRequest request) throws Exception {
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")) {
			word = "";
		}
		
		int nowPage = 1;
		int recordPerPage = 3;
		
		if(request.getParameter("nowPage")!=null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		List<MemberDTO> list = dao.list(map);
		
		int totalRecord = dao.total(map);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		
		request.setAttribute("paging", paging);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("list", list);
		
		return "/member/list";
	}
	
	@RequestMapping("/member/deleteForm")
	public String deleteForm(HttpServletRequest request) throws Exception {
		
		String id = request.getParameter("id");
		
		if(id == null) {
			id=(String)request.getSession().getAttribute("id");
		}
		String fname = dao.getFname(id);
		
		request.setAttribute("id", id);
		request.setAttribute("fname", fname);
		
		return "/member/delete";
	}
	
	@RequestMapping("/member/deleteProc")
	public String deleteProc(HttpServletRequest request) throws Exception {
		
		String userid = request.getParameter("id");
		String fname = request.getParameter("fname");
		
		String sid = (String)request.getSession().getAttribute("id");
		String grade = (String) request.getSession().getAttribute("grade");
		
		boolean flag = dao.delete(userid);
		String basePath = request.getRealPath("/storage_member");
		
		if(flag) {
			if(fname != null && !fname.equals("member.jpg")) {
				Utility.deleteFile(basePath, fname);
			}
			if(sid != null && !grade.equals("A")) {
				request.getSession().invalidate();
				
				return "redirect:/";
			}
			
			request.setAttribute("col", request.getParameter("col"));
			request.setAttribute("word", request.getParameter("word"));
			request.setAttribute("nowPage", request.getParameter("nowPage"));
			return "redirect:/admin/list";
		}else {
			return "error";
		}
		
	}

	@RequestMapping("/member/updateInfoForm")
	public String updateInfoForm(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		
		if(id == null) {
			id = (String)request.getSession().getAttribute("id");
		}
		
		MemberDTO dto = dao.read(id);
		
		request.setAttribute("dto", dto);
		request.setAttribute("oldfile", dto.getFname());
		request.setAttribute("id", id);
		
		return "/member/updateInfoForm";
	}
	
	@RequestMapping("/member/updateInfoProc")
	public String updateInfoProc(Model model, HttpServletRequest request, MemberDTO dto) throws Exception {
		
		System.out.println("10:"+dto.getMname());//null
		
		int size = (int)dto.getFilenameMF().getSize();
		
		
		String basePath = request.getRealPath("/storage_member");
		String fname = "";
		String oldfile = request.getParameter("oldfile");
			if(size>0) {
				Utility.deleteFile(basePath, oldfile);
				fname = Utility.saveFileSpring30(dto.getFilenameMF(), basePath);
				dto.setFname(fname);
				dto.setFilesize(size);
			}
		
		
		boolean flag = dao.update(dto);
		
		if(flag) {
			model.addAttribute("id",dto.getId());
			model.addAttribute("col",request.getParameter("col"));
			model.addAttribute("word",request.getParameter("word"));
			model.addAttribute("nowPage",request.getParameter("nowPage"));
			return "redirect:/member/read";
		}else {
			return "error";
		}
		
	}
	
	@RequestMapping("/member/updatePasswdForm")
	public String updatePasswd(HttpServletRequest request) throws Exception {
		String passwd = request.getParameter("passwd1");
		String id = request.getParameter("id");
		
		Map map = new HashMap();
		map.put("passwd", passwd);
		map.put("id", id);
		
		boolean flag = dao.CheckPW(map);
		request.setAttribute("flag", flag);
		
		return "/member/updatePasswdForm";
	}
	
	//proc만 하면 끝
	@RequestMapping("/member/updatePasswdProc")
	public String updatePasswdProc(Model model, HttpServletRequest request) throws Exception{
		String passwd = request.getParameter("passwd");
		String id = request.getParameter("id");
		if(id == null) {
			id = (String)request.getSession().getAttribute("id");
		}
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		dto.setPasswd(passwd);
		
		if(dao.updatePasswd(dto)) {
			model.addAttribute("id",id);
			model.addAttribute("col",request.getParameter("col"));
			model.addAttribute("word",request.getParameter("word"));
			model.addAttribute("nowPage",request.getParameter("nowPage"));
			return "redirect:/member/read";
		}else {
			return "error";
		}
	}
	
}


