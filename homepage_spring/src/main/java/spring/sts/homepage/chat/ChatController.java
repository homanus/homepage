package spring.sts.homepage.chat;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import spring.model.homepage.chat.ChatMgr;
import spring.model.homepage.chat.Chat_MessageDTO;
import spring.model.homepage.chat.Chat_RoomDTO;
import spring.model.homepage.chat.IChat_MessageDAO;
import spring.model.homepage.chat.IChat_RoomDAO;
import spring.model.homepage.member.IMemberDAO;
import spring.model.homepage.member.MemberDTO;
import spring.sts.homepage.utility.Utility;



@Controller
public class ChatController{
	
	@Autowired
	private IChat_RoomDAO rdao;
	
	@Autowired
	private ChatMgr mgr;
	
	@Autowired
	private IMemberDAO dao;
	
	@Autowired
	private IChat_MessageDAO mdao;
	
	@ResponseBody
	@RequestMapping("/chat/loginList")
	public ModelAndView loginList(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		try {
			if(request.getSession().getAttribute("id") != null) {
				String realId = (String)request.getSession().getAttribute("id");
				String nickname = mdao.getNcikname(realId);
				String getTime = mdao.getTime();
				
				modelAndView.addObject("nickname",nickname);
				modelAndView.addObject("getTime",getTime);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	
	@RequestMapping("/chat/delete")
	public String delete(HttpServletRequest request) throws Exception {
		
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		
		mgr.delete(chat_index);
		
		return "redirect:/chat/list";
	}
	
	@ResponseBody
	@RequestMapping("/chat/deleteProc")
	public ModelAndView deleteProc(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		String user_id = (String)request.getSession().getAttribute("id");
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		Map map = new HashMap();
		map.put("id", user_id);
		map.put("chat_index", chat_index);
		boolean flag = rdao.chat_room_Check(map);
		
		if(request.getSession().getAttribute("grade").equals("A")) {
			flag = true;
		}
		
		modelAndView.addObject("flag",flag);
		
		return modelAndView;
	}

	@RequestMapping("/chat/chatCreate")
	public String chatCreate(HttpServletRequest request) throws Exception {
		
		String id = (String)request.getSession().getAttribute("id");
		MemberDTO dto = dao.read(id);
		String chat_nickname = dto.getMname();
		request.setAttribute("chat_nickname", chat_nickname);
		
		return "/chat/chatCreate";
	}
	
	@RequestMapping("/chat/chatCreateProc")
	public String chatCreateProc(Chat_RoomDTO dto, HttpServletRequest request) throws Exception {
		
		if(rdao.create(dto)) {
			return "redirect:/chat/list";
		}else {
			return "/chat/error";
		}
		
	}
	
	@RequestMapping("/chat/list")
	public String chatList(HttpServletRequest request) throws Exception {
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")) {
			word = "";
		}
		
		int cPage = 1;
		int recordPerPage = 5;
		
		if(request.getParameter("cPage") != null) {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}
		
		int sno = ((cPage-1)*recordPerPage)+1;
		int eno = cPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("col", col);
		map.put("word", word);
		
		List list = rdao.list(map);

		int totalRecord = rdao.total(map);
		String paging = Utility.cpaging(totalRecord, cPage, recordPerPage, col, word, request);
		
		request.setAttribute("cPage", cPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		
		return "/chat/list";
	}
	
	@RequestMapping("/chat/chatRead")
	public String chatRead(HttpServletRequest request) throws Exception {
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		
		Chat_RoomDTO dto = (Chat_RoomDTO) rdao.read(chat_index);
		
		if(request.getSession().getAttribute("id") != null) {
			String realId = (String)request.getSession().getAttribute("id");
			String nickname = mdao.getNcikname(realId);
			request.setAttribute("nickname", nickname);
			request.setAttribute("realid", realId);
		}
		
		request.setAttribute("dto", dto);
		request.setAttribute("col", request.getParameter("col"));
		request.setAttribute("word", request.getParameter("word"));
		request.setAttribute("nowPage", request.getParameter("nowPage"));
		
		return "/chat/chatRead";
	}
	
	@ResponseBody
	@RequestMapping("/chat/chat_write")
	public ModelAndView chat_write(HttpServletRequest request) {
		String nickname = request.getParameter("nickname");
		String msg = request.getParameter("msg");
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		try {
			URLDecoder.decode(nickname, "UTF-8");
			URLDecoder.decode(msg, "UTF-8");
			
			Chat_MessageDTO dto = new Chat_MessageDTO();
			dto.setChat_index(chat_index);
			dto.setChat_content(msg);
			dto.setNickname(nickname);
			
			mdao.create(dto);
			modelAndView.addObject("nickname",nickname);
			modelAndView.addObject("msg",msg);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping("/chat/chat_time")
	public ModelAndView getTime(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		try {
			String realtime = mdao.getRealTime();

			modelAndView.addObject("realtime",realtime);
		}catch(Exception e){
			e.printStackTrace();
		}
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping("/chat/chat_check")
	public ModelAndView chat_check(HttpServletRequest request) {
		int table_cnt = Integer.parseInt(request.getParameter("table_cnt"));
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		boolean flag = false;
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		try {
			
			int count = mdao.insert_check(chat_index);
			if(table_cnt != count) {
				flag = true;
				modelAndView.addObject("flag",flag);
				modelAndView.addObject("count", count);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping("/chat/chat_show")
	public ModelAndView chat_show(HttpServletRequest request) {
		
		int chat_index = Integer.parseInt(request.getParameter("chat_index"));
		String finalDate = request.getParameter("finalDate");
		
		Map map = new HashMap(); 
		map.put("chat_index", chat_index);
		map.put("finalDate", finalDate);
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		try {
			boolean cflag = mdao.Canyou_Seethem(map);
			if(cflag) {
				
			List list = mdao.Chat_content_read(map);
			int size = list.size();
			
			if(request.getParameter("realid") != null) {
				String realId = request.getParameter("realid");
				String nickname = mdao.getNcikname(realId);
				String getTime = mdao.getTime();
				
				modelAndView.addObject("nickname",nickname);
				modelAndView.addObject("getTime",getTime);
			}
			
			modelAndView.addObject("size",size);
			modelAndView.addObject("cflag",cflag);
			modelAndView.addObject("list",list);
			
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return modelAndView;
		
	}
	
	@ResponseBody
	@RequestMapping("/chat/room_check")
	public ModelAndView room_check(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		
		String id = (String)request.getSession().getAttribute("id");
		
		boolean room_flag = rdao.crate_room_check(id);
		
		modelAndView.addObject("room_flag",room_flag);
		
		return modelAndView;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
