package spring.sts.homepage.etc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EtcController {
	
	@RequestMapping("/etc/m_Psychological_testing")
	public String m_Psychological_testing() {
		return "/etc/m_Psychological_testing";
	}
}
