package spring.sts.homepage;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.model.homepage.bbs.BbsDTO;
import spring.model.homepage.bbs.IBbsDAO;
import spring.model.homepage.bbs.IReplyDAO;
import spring.model.homepage.chat.IChat_RoomDAO;
import spring.model.homepage.image.I_ImageDAO;
import spring.model.homepage.image.ImageDTO;
import spring.sts.homepage.utility.Utility;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private IBbsDAO dao;
	
	@Autowired
	private IReplyDAO rdao;
	
	@Autowired
	private I_ImageDAO idao;
	
	@Autowired
	private IChat_RoomDAO cdao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/")
	public String home(Locale locale, Model model,HttpServletRequest request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//==================================================================bbs-start
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
			
			String paging = Utility.paging3_bbs(totalRecord, nowPage, recordPerPage, col, word,request);
			
			int nPage = 1;
			
			request.setAttribute("bbs_paging", paging);
			request.setAttribute("bbs_list", list);
			request.setAttribute("col", col);
			request.setAttribute("word", word);
			request.setAttribute("nowPage", nowPage);
			request.setAttribute("nPage", nPage);
			request.setAttribute("rdao", rdao);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		//================================================================= bbs-END
		//***************************************************************** image-start
		
		String image_col = Utility.checkNull(request.getParameter("image_col"));
		String image_word = Utility.checkNull(request.getParameter("image_word"));
		
		if(image_col.equals("image_total")){
			image_word = "";
		}
		
		int image_nowPage = 1;
		int image_recordPerPage = 5;
		
		if(request.getParameter("image_nowPage")!=null){
			image_nowPage = Integer.parseInt(request.getParameter("image_nowPage"));
		}
		
		int image_sno = ((image_nowPage-1)*image_recordPerPage)+1;
		int image_eno = image_nowPage*image_recordPerPage;
		
		Map image_map = new HashMap();
		image_map.put("col", image_col);
		image_map.put("word", image_word);
		image_map.put("sno", image_sno);
		image_map.put("eno", image_eno);
		
		try {
			List<ImageDTO> image_list = idao.list(map);
			int image_totalRecord = idao.total(map);
			String image_paging = Utility.paging3_image(image_totalRecord, image_nowPage, image_recordPerPage, image_col, image_word, request);
			
			request.setAttribute("image_paging", image_paging);
			request.setAttribute("image_list", image_list);
			request.setAttribute("image_nowPage", image_nowPage);
			request.setAttribute("image_col", image_col);
			request.setAttribute("image_word", image_word);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//***************************************************************** image-END
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ chat-start
		
		String chat_col = Utility.checkNull(request.getParameter("chat_col"));
		String chat_word = Utility.checkNull(request.getParameter("chat_word"));
		
		if(chat_col.equals("chat_total")) {
			chat_word = "";
		}
		
		int chat_cPage = 1;
		int chat_recordPerPage = 5;
		
		if(request.getParameter("chat_cPage") != null) {
			chat_cPage = Integer.parseInt(request.getParameter("chat_cPage"));
		}
		
		int chat_sno = ((chat_cPage-1)*chat_recordPerPage)+1;
		int chat_eno = chat_cPage * chat_recordPerPage;
		
		Map chat_map = new HashMap();
		chat_map.put("sno", chat_sno);
		chat_map.put("eno", chat_eno);
		chat_map.put("col", chat_col);
		chat_map.put("word", chat_word);
		
		try {
			List chat_list = cdao.list(chat_map);
			
			request.setAttribute("chat_cPage", chat_cPage);
			request.setAttribute("chat_col", chat_col);
			request.setAttribute("chat_word", chat_word);
			request.setAttribute("chat_list", chat_list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ chat-End
		
		
		return "/home";
	}
	
}
