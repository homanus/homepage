package spring.sts.homepage.utility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import spring.model.homepage.bbs.ReplyDAO;


public class Utility {
	
	public static int rcount(int bbsno, ReplyDAO rdao) throws Exception {
		
		return rdao.total(bbsno);
	}
	
	public static void deleteFile(String basePath, String oldfile) {
		// TODO Auto-generated method stub
		File file = new File(basePath,oldfile);
		
		if(file.exists()) {
			file.delete();
		}
		
	}
	
	/** 
     * 파일업로드 처리(model1,mvc) 
     * @param fileItem 
     * @param upDir 
     * @return 
     */ 
    public static String saveFileSpring30(MultipartFile multipartFile, String basePath) { 
        // input form's parameter name 
        String fileName = ""; 
        // original file name 
        String originalFileName = multipartFile.getOriginalFilename(); 
        // file content type 
        String contentType = multipartFile.getContentType(); 
        // file size 
        long fileSize = multipartFile.getSize(); 
         
        System.out.println("fileSize: " + fileSize); 
        System.out.println("originalFileName: " + originalFileName); 
         
        InputStream inputStream = null; 
        OutputStream outputStream = null; 
 
        try { 
            if( fileSize > 0 ) { // 파일이 존재한다면 
                // 인풋 스트림을 얻는다. 
                inputStream = multipartFile.getInputStream(); 
 
                File oldfile = new File(basePath, originalFileName); 
             
                if ( oldfile.exists()){ 
                    for(int k=0; true; k++){ 
                        //파일명 중복을 피하기 위한 일련 번호를 생성하여 
                        //파일명으로 조합 
                        oldfile = new File(basePath,"("+k+")"+originalFileName); 
                     
                        //조합된 파일명이 존재하지 않는다면, 일련번호가 
                        //붙은 파일명 다시 생성 
                        if(!oldfile.exists()){ //존재하지 않는 경우 
                            fileName = "("+k+")"+originalFileName; 
                            break; 
                        } 
                    } 
                }else{ 
                    fileName = originalFileName; 
                } 
                //make server full path to save 
                String serverFullPath = basePath + "\\" + fileName; 
                 
                System.out.println("fileName: " + fileName); 
                System.out.println("serverFullPath: " + serverFullPath); 
                 
                outputStream = new FileOutputStream( serverFullPath ); 
  
                // 버퍼를 만든다. 
                int readBytes = 0; 
                byte[] buffer = new byte[8192]; 
 
                while((readBytes = inputStream.read(buffer, 0, 8192)) != -1 ) { 
                    outputStream.write( buffer, 0, readBytes ); 
                } 
                outputStream.close(); 
                inputStream.close(); 
                         
            } 
 
        } catch(Exception e) { 
            e.printStackTrace();   
        }finally{ 
             
        } 
         
        return fileName; 
    } 

	public static String getCodeValue(String job){
		String value = "";
		Map<String,String> codes = new HashMap();
		codes.put("A01", "회사원");
		codes.put("A02", "전산관련직");
		codes.put("A03", "연구전문직");
		codes.put("A04", "학생");
		codes.put("A05", "일반자영업");
		codes.put("A06", "공무원");
		codes.put("A07", "의료인");
		codes.put("A08", "법조인");
		codes.put("A09", "종교/언론/예술인");
		codes.put("A010", "기타");
			
		value = codes.get(job);
		
		
		return value;
	}
	
	
	public static boolean compareDay(String wdate) {
		boolean flag = false;
		List<String> list = getDay();
		if(wdate.equals(list.get(0))
			||(wdate.equals(list.get(1)))
			||(wdate.equals(list.get(2))))
		{flag = true;}
		
		return flag;
	}
	
	
	public static List<String> getDay(){
		List<String> list = new ArrayList<String>();
		
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		for(int j=0; j<3; j++) {
			list.add(sd.format(cal.getTime()));
			cal.add(Calendar.DATE, -1);
		}
		
		return list;
	}
	
	
	
	
	
	
	/**
	 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
	 * 18 19 20 [다음]
	 * 
	 * @param totalRecord
	 *            전체 레코드수
	 * @param nowPage
	 *            현재 페이지
	 * @param recordPerPage
	 *            페이지당 레코드 수
	 * @param col
	 *            검색 컬럼
	 * @param word
	 *            검색어
	 * @return 페이징 생성 문자열
	 */
	public static String paging3(int totalRecord, int nowPage, int recordPerPage, String col, String word) {
		int pagePerBlock = 10; // 블럭당 페이지 수
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage)); // 전체 페이지
		//전체 페이지, 즉 레코드 /10을 해서 몇 페이지가 나올지 결정
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		//10개씩 잘라서 보여주기 위해서, 10개 미만일 경우도 페이지로 만들어주기 위해 올림.
		int nowGrp = (int) (Math.ceil((double) nowPage / pagePerBlock)); // 현재 그룹
		//현재 보고 있는 페이지를 보여주기 위한 것
		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작
		//1-1 0*10=0, +1 = 1 즉, 첫번째 보여줄 페이지는 1페이지라는 것
		//2-1 1*10=10, +1 = 11 즉, 11~이라는 페이지를 보여줄 것이라는 소리.
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료
		//1그룹이면 10을 곱해서 10까지만 보여줌.
		//2그룹이면 10을 곱해서 20까지만 보여줌,
		//결과적으로 1~10, 11~20 을 보여줄 거라는 말.

		StringBuffer str = new StringBuffer();
		//css적용하기 위한 구문들
		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("  .span_box_1{");
		str.append("    text-align: center;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("  .span_box_2{");
		str.append("    text-align: center;");
		str.append("    background-color: #668db4;");
		str.append("    color: #FFFFFF;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		// str.append("현재 페이지: " + nowPage + " / " + totalPage + " ");

		int _nowPage = (nowGrp - 1) * pagePerBlock; // 10개 이전 페이지로 이동
		if (nowGrp >= 2) {
			str.append("<span class='span_box_1'><A href='./list?col=" + col + "&word=" + word + "&nowPage="
					+ _nowPage + "'>이전</A></span>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}

			if (nowPage == i) {
				str.append("<span class='span_box_2'>" + i + "</span>");
			} else {
				str.append("<span class='span_box_1'><A href='./list?col=" + col + "&word=" + word + "&nowPage=" + i
						+ "'>" + i + "</A></span>");
			}
		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 10개 다음 페이지로 이동
		if (nowGrp < totalGrp) {
			str.append("<span class='span_box_1'><A href='./list?col=" + col + "&word=" + word + "&nowPage="
					+ _nowPage + "'>다음</A></span>");
		}
		str.append("</DIV>");

		return str.toString();
	}

	/**
	 * 숫자 형태의 페이징, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17 18 19 20
	 * [다음]
	 * 
	 * @param totalRecord
	 *            전체 레코드수
	 * @param nowPage
	 *            현재 페이지
	 * @param recordPerPage
	 *            페이지당 출력할 레코드 수
	 * @param col
	 *            검색 컬럼
	 * @param word
	 *            검색어
	 * @return 페이징 생성 문자열
	 */
	public static String paging(int totalRecord, int nowPage, int recordPerPage, String col, String word) {
		int pagePerBlock = 5; // 블럭당 페이지 수
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage));// 전체 페이지
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		int nowGrp = (int) (Math.ceil((double) nowPage / pagePerBlock)); // 현재 그룹
		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료

		StringBuffer str = new StringBuffer();

		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append(
				"  #paging A:hover{text-decoration:underline; background-color: #ffffff; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		str.append("현재 페이지: " + nowPage + " / " + totalPage + "  ");

		int _nowPage = (nowGrp - 1) * pagePerBlock; // 10개 이전 페이지로 이동
		if (nowGrp >= 2) {
			str.append("[<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + _nowPage + "'>이전</A>]");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}

			if (nowPage == i) { // 현재 페이지이면 강조 효과
				str.append("<span style='font-size: 1.2em; font-weight: bold;'>" + i + "</span> ");
			} else {
				str.append("<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + i + "'>" + i + "</A> ");
			}

		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 10개 다음 페이지로 이동
		if (nowGrp < totalGrp) {
			str.append("[<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + _nowPage + "'>다음</A>]");
		}
		str.append("</DIV>");

		return str.toString();
	}
	
	
	
	
	
	
	
	
	public static String checkNull(String a) {
		if(a==null) {
			a="";
		}
		return a.trim();
	}

	public static String paging2(int totalRecord, int nPage, int recordPerPage, String url, int bbsno, int nowPage,
			String col, String word) {
		
		int pagePerBlock = 5; // 블럭당 페이지 수
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage)); // 전체 페이지
		//전체 페이지, 즉 레코드 /10을 해서 몇 페이지가 나올지 결정
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		//10개씩 잘라서 보여주기 위해서, 10개 미만일 경우도 페이지로 만들어주기 위해 올림.
		int nowGrp = (int) (Math.ceil((double) nPage / pagePerBlock)); // 현재 그룹
		//현재 보고 있는 페이지를 보여주기 위한 것
		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작
		//1-1 0*10=0, +1 = 1 즉, 첫번째 보여줄 페이지는 1페이지라는 것
		//2-1 1*10=10, +1 = 11 즉, 11~이라는 페이지를 보여줄 것이라는 소리.
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료
		//1그룹이면 10을 곱해서 10까지만 보여줌.
		//2그룹이면 10을 곱해서 20까지만 보여줌,
		//결과적으로 1~10, 11~20 을 보여줄 거라는 말.

		StringBuffer str = new StringBuffer();
		//css적용하기 위한 구문들
		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("  .span_box_1{");
		str.append("    text-align: center;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("  .span_box_2{");
		str.append("    text-align: center;");
		str.append("    background-color: #668db4;");
		str.append("    color: #FFFFFF;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		// str.append("현재 페이지: " + nowPage + " / " + totalPage + " ");

		int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동
		if (nowGrp >= 2) {
			str.append("<span class='span_box_1'><A href='"+url+"?bbsno=" + bbsno + "&nPage="+_nowPage+"&col=" + col + "&word=" + word + "&nowPage="
					+ nowPage +"'>이전</A></span>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}

			if (nPage == i) {
				str.append("<span class='span_box_2'>" + i + "</span>");
			} else {
				str.append("<span class='span_box_1'><A href='"+url+"?bbsno=" + bbsno + "&nPage=" + i + "&col=" + col + "&word=" + word + "&nowPage=" + nowPage
						+ "'>" + i + "</A></span>");
			}
		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 10개 다음 페이지로 이동
		if (nowGrp < totalGrp) {
			str.append("<span class='span_box_1'><A href='"+url+"?bbsno=" + bbsno + "&nPage=" + _nowPage + "&col=" + col + "&word=" + word + "&nowPage="
					+ nowPage + "'>다음</A></span>");
		}
		str.append("</DIV>");

		return str.toString();
	}
	
	
	//채팅 방 페이징을 위한 페이징
		public static String cpaging(int totalRecord, int cPage, int recordPerPage, String col, String word) {
			int pagePerBlock = 5; // 블럭당 페이지 수
			int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage)); // 전체 페이지
			int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
			int nowGrp = (int) (Math.ceil((double) cPage / pagePerBlock)); // 현재 그룹
			int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작
			int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료

			StringBuffer str = new StringBuffer();

			str.append("<style type='text/css'>");
			str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
			str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
			str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}");
			str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
			str.append("  .span_box_1{");
			str.append("    text-align: center;");
			str.append("    font-size: 1em;");
			str.append("    border: 1px;");
			str.append("    border-style: solid;");
			str.append("    border-color: #cccccc;");
			str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
			str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
			str.append("  }");
			str.append("  .span_box_2{");
			str.append("    text-align: center;");
			str.append("    background-color: #668db4;");
			str.append("    color: #FFFFFF;");
			str.append("    font-size: 1em;");
			str.append("    border: 1px;");
			str.append("    border-style: solid;");
			str.append("    border-color: #cccccc;");
			str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
			str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
			str.append("  }");
			str.append("</style>");
			str.append("<DIV id='paging'>");
//			str.append("현재 페이지: " + cPage + " / " + totalPage + " ");

			int _nowPage = (nowGrp - 1) * pagePerBlock; // 10개 이전 페이지로 이동
			if (nowGrp >= 2) {
				str.append("<span class='span_box_1'><A href='./list.do?col=" + col + "&word=" + word + "&cPage="
						+ _nowPage + "'>이전</A></span>");
			}
			// -----------------------

			for (int i = startPage; i <= endPage; i++) { // 페이지 번호 색깔
				if (i > totalPage) {
					break;
				}

				if (cPage == i) {
					str.append("<span class='span_box_2'>" + i + "</span>"); // 현재 페이지에대한 색 자기페이지라서 링크안걸리고
				} else {
					str.append("<span class='span_box_1'><A href='./list.do?col=" + col + "&word=" + word + "&cPage=" + i
							+ "'>" + i + "</A></span>"); // 내페이지를 제외한 다른 곳
				}
			}

			_nowPage = (nowGrp * pagePerBlock) + 1; // 10개 다음 페이지로 이동
			if (nowGrp < totalGrp) {
				str.append("<span class='span_box_1'><A href='./list.do?col=" + col + "&word=" + word + "&cPage="
						+ _nowPage + "'>다음</A></span>");
			}
			str.append("</DIV>");

			return str.toString();
		}

}
