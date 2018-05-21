package member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MemberTest {

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		
		//duplicateID(dao);
		//duplicateEmail(dao);
		//create(dao);
		//list(dao);
		//total(dao);
		//read(dao);
		//update(dao);
		//getFname(dao);
		//delete(dao);
		//loginCheck(dao);
		getGrade(dao);
	}

	private static void getGrade(MemberDAO dao) {
		p("등급:"+dao.getGrade("hoho"));
		
	}

	private static void loginCheck(MemberDAO dao) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", "hoho");
		map.put("passwd", "11");
		
		if(dao.loginCheck(map)){
			p("로그인 됨");
		}else{
			p("로그인 실패");
		}
		
	}

	private static void delete(MemberDAO dao) {
		if(dao.delete("123")){
			p("성공");
		}else{
			p("실패");
		}	
	}

	private static void getFname(MemberDAO dao) {
		
		p(dao.getFname("gdsf"));
		
	}

	private static void update(MemberDAO dao) {
		MemberDTO dto = dao.read("op");
		
		dto.setTel("0000000");
		dto.setZipcode("00000");
		dto.setAddress1("00000000");
		dto.setAddress2("0000000");
		
		boolean flag = dao.updateInfo(dto);
		if(flag){
			p("성공");
		}else{
			p("실패");
		}
		
	}

	private static void read(MemberDAO dao) {
		MemberDTO dto = dao.read("한글");
		p(dto);
		
	}

	private static void total(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word","한글");
		
		p("레코드 개수:"+dao.total(map));
		
	}

	private static void list(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word","");
		map.put("sno", 1);
		map.put("eno", 5);
		
		List<MemberDTO> list = dao.list(map);
		
		for(int i=0; i<list.size(); i++){
			MemberDTO dto = list.get(i);
			p(dto);
			p("----------------");
		}
		
	}

	private static void p(MemberDTO dto) {
		p("아이디:"+dto.getId());
		p("이름:"+dto.getMname());
		p("연락처:"+dto.getTel());
		p("메일:"+dto.getEmail());
		p("우편번호:"+dto.getZipcode());
		p("주소:"+dto.getAddress1());
		p("상세주소::"+dto.getAddress2());
		p("직업:"+dto.getJob());
		p("파일:"+dto.getFname());
		p("가입날짜:"+dto.getMdate());
		p("등급:"+dto.getGrade());
		
		
	}

	private static void create(MemberDAO dao) {
		MemberDTO dto = new MemberDTO();
		dto.setId("test");
		dto.setPasswd("test");
		dto.setMname("123");
		dto.setEmail("123@da");
		dto.setTel("123");
		dto.setFname("123");
		dto.setJob("A01");
		dto.setAddress1("123");
		dto.setAddress2("123");
		dto.setZipcode("123");
		
		if(dao.create(dto)){
			p("성공");
		}else{
			p("실패");
		}
		
	}

	private static void duplicateEmail(MemberDAO dao) {
		String email="email1@mail.co";
		if(dao.duplicateEmail(email)){
			p("중복");
		}else{
			p("사용가능");
		}
		
	}

	private static void duplicateID(MemberDAO dao) {
		String id="user";
		
		if(dao.duplicateID(id)){
			p("중복된 아이디임");
		}else{
			p("사용가능");
		}
		
	}

	private static void p(String string) {
		System.out.println(string);
		
	}
}
