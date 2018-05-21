package spring.model.homepage.member;

public class MemberTest {
	
	

	public static void main(String[] args) {
		
		MemberDAO dao = new MemberDAO();
		
		try {
//		read(dao);
//		create(dao);
//		updatePasswd(dao);
//		updateInfo(dao);
//		delete(dao);
//		duplicateId(dao);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	private static void duplicateId(MemberDAO dao) throws Exception {
		String id="4124124";
		if(dao.duplicateId(id)) {
			p("중복된 아이디");
		}else {
			p("사용 가능한 아이디");
		}
		
	}

	private static void delete(MemberDAO dao) throws Exception {
		String id = "123";
		if(dao.delete(id)) {
			p("성공");
		}else {
			p("실패");
		}
		
	}

	private static void updateInfo(MemberDAO dao) throws Exception {
		MemberDTO dto = new MemberDTO();
		dto.setMname("이름변경");
		dto.setTel("11111");
		dto.setEmail("123@123");
		dto.setFname("사진변경");
		dto.setFilesize(44);
		dto.setZipcode(55555);
		dto.setAddress1("주소변경지");
		dto.setAddress2("주소변경시2");
		dto.setJob("직업텟");
		dto.setId("test");
		
		if(dao.update(dto)) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void updatePasswd(MemberDAO dao) throws Exception {
		MemberDTO dto = new MemberDTO();
		dto.setId("test");
		dto.setPasswd("1234");
		
		if(dao.updatePasswd(dto)) {
			p("성공");
		}else {
			p("실패");
		}
		
	}

	private static void create(MemberDAO dao) throws Exception {

		MemberDTO dto = new MemberDTO();
		dto.setId("123");
		dto.setPasswd("1234");
		dto.setTel("12-21-132");
		dto.setMname("테스트이름");
		dto.setEmail("테스트이메일@에");
		dto.setZipcode(12345);
		dto.setAddress1("주소1");
		dto.setAddress2("주소2");
		dto.setTel("테스트텔");
		dto.setJob("테스트직업");
		dto.setMdate("11=-11-1");
		dto.setFname("파일이름");
		dto.setFilesize(24);
		
		try {
			if(dao.create(dto)) {
				p("성공");
			}else {
				p("실패");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	private static void read(MemberDAO dao) throws Exception {
		MemberDTO dto = dao.read("test");
		p(dto);
	}

	private static void p(MemberDTO dto) {
		p("아이디:"+dto.getId());
		p("비밀번호:"+dto.getPasswd());
		p("이름:"+dto.getMname());
		p("전봐번호:"+dto.getTel());
		p("이메일:"+dto.getEmail());
		p("우편번호:"+dto.getZipcode());
		p("주소1:"+dto.getAddress1());
		p("주소2:"+dto.getAddress2());
		p("직업:"+dto.getJob());
		p("날짜:"+dto.getMdate());
		p("파일이름:"+dto.getFname());
		p("등급:"+dto.getGrade());
		
	}

	private static void p(String string) {
		System.out.println(string);
	}

}
