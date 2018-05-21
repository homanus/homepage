package guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class GuestDAO {
	
	public boolean idCheck(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String id = (String)map.get("id");
		int gno = (Integer)map.get("gno");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) as cnt ");
		sql.append(" from guest ");
		sql.append(" where id=? AND gno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, gno);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getInt("cnt")>0)
					flag = true;
				if(id.equals("dehet"))
					flag=true;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	public GuestDTO read(int gno){
		GuestDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select gno,fname,gname,content,gdate ");
		sql.append(" from guest ");
		sql.append(" where gno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, gno);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new GuestDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setFname(rs.getString("fname"));
				dto.setGname(rs.getString("gname"));
				dto.setContent(rs.getString("content"));
				dto.setGdate(rs.getString("gdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}

	public int total(Map map){
		int total=0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) as cnt ");
		sql.append(" FROM guest ");
		if(word.trim().length()>0){
		sql.append(" WHERE "+col+" like '%'||?||'%' ");}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0){
			pstmt.setString(1, word);}
			
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
	
	public String getFname(int gno){
		String fname = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT fname ");
		sql.append(" FROM guest ");
		sql.append(" WHERE gno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, gno);
			
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
	
	public boolean create(GuestDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO guest( ");
		sql.append(" gno,fname,gname,content,gdate,id) ");
		sql.append(" VALUES((SELECT NVL(MAX(gno),0)+1 as gno from guest), ");
		sql.append(" ?,?,?,sysdate,?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getFname());
			pstmt.setString(2, dto.getGname());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getId());
			
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
	
	public List<GuestDTO> list(Map map){
		GuestDTO dto = null;
		List<GuestDTO> list = new ArrayList<GuestDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT gno,fname,gname,content,gdate,r ");
		sql.append(" FROM( ");
		sql.append(" 	SELECT gno,fname,gname,content,gdate, rownum r ");
		sql.append(" 	FROM( ");
		sql.append(" 		SELECT gno,fname,gname,content,gdate ");
		sql.append(" 		FROM guest ");
		if(word.trim().length()>0){
			sql.append(" WHERE "+col+" like '%'||?||'%' ");
		}
		sql.append(" 		ORDER BY gdate DESC ");
		sql.append(" 	) ");
		sql.append(" ) ");
		sql.append(" WHERE r>=? and r<=? ");
		
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
				dto = new GuestDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setFname(rs.getString("fname"));
				dto.setGname(rs.getString("gname"));
				dto.setContent(rs.getString("content"));
				dto.setGdate(rs.getString("gdate"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public boolean update(GuestDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE guest    ");
		sql.append(" SET fname	=?,  ");
		sql.append(" 	 gname	=?,  ");
		sql.append("  	 content=?  ");
		sql.append(" WHERE   gno=?   ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getFname());
			pstmt.setString(2, dto.getGname());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getGno());
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
	
	public boolean delete(int gno){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE guest ");
		sql.append(" WHERE gno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, gno);
			
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

}
