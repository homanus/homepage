package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;
import utility.UploadSave;

public class MemberDAO {
	
	public String emailcode() {
		String code = "";
		int a[] = new int[6];
		
		for(int i=0; i<6; i++){
			a[i] = (int)(Math.random()*9+1);
			code += a[i];
			//1~9
		}
		return code;
	}
	
	
	public String getGrade(String id){
		String grade="";
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT grade ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				grade = rs.getString("grade");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		return grade;
	}
	
	public boolean loginCheck(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String id = (String)map.get("id");
		String passwd = (String)map.get("passwd");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(id) as cnt ");
		sql.append(" FROM member ");
		sql.append(" where id=? ");
		sql.append(" and passwd=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt("cnt")>0){
					flag = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	public String getFname(String id){
		String fname = "";
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT fname ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				fname = rs.getString("fname");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		return fname;
	}
	
	public int total(Map map){
		int total=0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) as cnt ");
		sql.append(" FROM member ");
		if(word.trim().length()>0){
		sql.append(" WHERE "+col+" like '%'||?||'%' ");}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0){
				pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				total = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		
		return total;
	}
	
	public boolean duplicateEmail(String email){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(email) as cnt ");
		sql.append(" FROM member ");
		sql.append(" WHERE email=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getInt("cnt")>0){
					flag = true;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	
	public boolean duplicateID(String id){
		boolean flag=false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(id) as cnt ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt = rs.getInt("cnt");
				if(cnt>0) flag=true;
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{ 
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	public List<MemberDTO> list(Map map){
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT id, mname, tel, email, zipcode, address1, ");
		sql.append(" 	address2, fname, r ");
		sql.append(" FROM( ");
		sql.append(" 	SELECT id, mname, tel, email, zipcode, address1, ");
		sql.append(" 		address2, fname, rownum r ");
		sql.append(" 	FROM( ");
		sql.append(" 		SELECT id, mname, tel, email, zipcode, address1, ");
		sql.append(" 		address2, fname ");
		sql.append(" 		FROM member ");
		if(word.trim().length()>0){
		sql.append(" 		WHERE "+col+" like '%'||?||'%' ");}
		
		sql.append(" 		ORDER BY mdate desc ");
		sql.append(" 	) ");
		sql.append(" ) ");
		sql.append(" WHERE r>=? AND r<=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if(word.trim().length()>0){
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberDTO dto = new MemberDTO();
				
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setFname(rs.getString("fname"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}

		return list;
	}

	public boolean create(MemberDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO member( ");
		sql.append(" id,passwd,mname,tel,email,zipcode,address1,address2, ");
		sql.append(" job,mdate,fname,grade) ");
		sql.append(" VALUES(?,?,?,?,?,?,?,?, ");
		sql.append(" ?,sysdate,?,'H') ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());
			pstmt.setString(10, dto.getFname());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0){
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public MemberDTO read(String id){
		MemberDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT id,passwd,mname,tel,email,zipcode,address1,address2, ");
		sql.append(" 	job,mdate,fname,grade ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
				dto.setMdate(rs.getString("mdate"));
				dto.setFname(rs.getString("fname"));
				dto.setGrade(rs.getString("grade"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		
		
		return dto;
	}
	
	public boolean update(MemberDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET passwd=?, ");
		sql.append(" 	tel=?, ");
		sql.append(" 	email=?, ");
		sql.append(" 	zipcode=?, ");
		sql.append(" 	address1=?, ");
		sql.append(" 	address2=?, ");
		sql.append(" 	job=?, ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getZipcode());
			pstmt.setString(5, dto.getAddress1());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getJob());
			pstmt.setString(8, dto.getId());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0)flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public boolean updateFile(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		String id= (String)map.get("id");
		String fname=(String)map.get("fname");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET fname = ? ");
		sql.append(" WHERE id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, fname);
			pstmt.setString(2, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0){
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		
		return flag;
	}
	
	public boolean updatePasswd(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		String passwd = (String)map.get("passwd");
		String id = (String)map.get("id");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET passwd=? ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, passwd);
			pstmt.setString(2, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0){
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		return flag;
	}
	
	public boolean updateInfo(MemberDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET	tel		  =?, ");
		sql.append(" 		email 	  =?, ");
		sql.append(" 		zipcode   =?, ");
		sql.append(" 		address1  =?, ");
		sql.append(" 		address2  =?, ");
		sql.append(" 		job		  =?  ");
		sql.append(" WHERE  id		  =?  ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			/*pstmt.setString(1, dto.getPasswd());*/
			pstmt.setString(1, dto.getTel());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getZipcode());
			pstmt.setString(4, dto.getAddress1());
			pstmt.setString(5, dto.getAddress2());
			pstmt.setString(6, dto.getJob());
			pstmt.setString(7, dto.getId());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0){
				flag=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		
		return flag;
	}
	
	
	
	public boolean delete(String id){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
				
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0){
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		
		
		
		return flag;
		
	}
	
	public boolean CheckPW(Map map){
		boolean flag = false;
		
		String id = (String)map.get("id");
		String passwd = (String)map.get("passwd");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(id) as cnt ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? AND passwd=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				/*if(rs.getInt("cnt")>0){
					flag=true;
				}*/
				int cnt = rs.getInt("cnt");
				if(cnt>0){
					flag=true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	
	
	
	
	
	
	
	

}
