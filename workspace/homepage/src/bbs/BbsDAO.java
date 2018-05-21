package bbs;

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

public class BbsDAO {
	
	public String getFname(int bbsno){
		String fname = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select filename from bbs ");
		sql.append(" where bbsno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				fname = rs.getString("filename");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		return fname;
	}
	
	public boolean checkRefnum(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(refnum) as cnt ");
		sql.append(" FROM bbs ");
		sql.append(" where refnum = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt("cnt")>0) {
					flag = true;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		
		return flag;
	}
	
	public int total(Map map) {
		int total=0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) as cnt FROM bbs ");
		if(word.trim().length()>0) {
			sql.append(" WHERE "+col+" like '%'||?||'%' ");
		}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0){
				pstmt.setString(1, word);
				}  
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total=rs.getInt("cnt");
				//"COUNT(*)"도 가능, 1도 가능
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return total;
		
		
	}

	public List<BbsDTO> list(Map map){
		BbsDTO dto = null;
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, viewcnt, to_char(sysdate,'yyyy-mm-dd')wdate, ");
		sql.append(" 	indent,filename, r ");
		sql.append(" FROM( ");
		sql.append(" 	SELECT bbsno, wname, title, viewcnt, to_char(sysdate,'yyyy-mm-dd')wdate, ");
		sql.append(" 	indent,filename, rownum r ");
		sql.append(" 	FROM( ");
		sql.append(" 		SELECT bbsno, wname, title, viewcnt, to_char(sysdate,'yyyy-mm-dd')wdate, ");
		sql.append(" 		indent, filename  ");
		sql.append(" 		FROM bbs ");
		
		if(word.trim().length()>0) {
		sql.append(" WHERE "+col+" like '%'||?||'%' ");		}
		
		sql.append(" order by grpno desc,ansnum ");
		sql.append(" 	) ");
		sql.append(" ) ");
		sql.append(" WHERE r >= ? and r <= ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			int i=0;
			
			if(word.trim().length()>0) {
				pstmt.setString(++i, word);}
			
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setIndent(rs.getInt("indent"));
				dto.setFilename(rs.getString("filename"));
				
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
	
	public boolean create(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO bbs(bbsno, wname, title, ");
		sql.append(" content, passwd,wdate,grpno,filename,filesize) ");
		sql.append(" VALUES( ");
		sql.append(" (SELECT NVL(MAX(bbsno),0)+1 as bbsno from bbs) ");
		sql.append(" ,?,?,?,?,sysdate, ");
		sql.append(" (SELECT NVL(MAX(grpno),0)+1 as grpno from bbs) ");
		sql.append(" ,?,?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1,dto.getWname() );
			pstmt.setString(2,dto.getTitle() );
			pstmt.setString(3,dto.getContent() );
			pstmt.setString(4,dto.getPasswd() );
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				flag = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		
		return flag;
	}
	
	public BbsDTO read(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno,wname,title,content, ");
		sql.append(" viewcnt,wdate,filename,filesize ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				//dto.setPasswd(rs.getString("passwd"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
				//dto.setGrpno(rs.getInt("grpno"));
				//dto.setIndent(rs.getInt("indent"));
				//dto.setAnsnum(rs.getInt("ansnum"));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public boolean update(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs ");
		sql.append(" SET wname=?,title=?,content=? ");
		if(dto.getFilesize()>0){
		sql.append(" ,filename=?,filesize=?  ");
		}
		sql.append(" WHERE bbsno= ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			
			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFilesize()>0){
			pstmt.setString(++i, dto.getFilename());
			pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getBbsno());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) {
				flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		
		
		return flag;
	}
	
	public boolean delete(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM bbs ");
		sql.append(" WHERE bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {flag=true;}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public void upviewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs ");
		sql.append(" SET viewcnt = viewcnt+1 ");
		sql.append(" WHERE bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
	}
	
	public boolean passcheck(Map map) {
		boolean flag = false;
		
		int bbsno = (Integer)map.get("bbsno");
		String passwd = (String)map.get("passwd");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(bbsno) as cnt ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno=? AND passwd=? ");
		
		try {
			pstmt =con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				int cnt = rs.getInt("cnt");
				//int cnt = rs.getInt(1); 맵의 인덱스값
				if(cnt>0)flag = true;
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
		
	}
	
	public BbsDTO readReply(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" bbsno, grpno, indent, ansnum, title ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno = ?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setTitle(rs.getString("title"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public boolean createReply(BbsDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO bbs ");
		sql.append(" (bbsno, wname, title, content, passwd,wdate,grpno,indent,ansnum,refnum,filename,filesize) ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno),0) + 1 as bbsno FROM bbs) ");
		sql.append(" ,?,?,?,?,SYSDATE,?,?,?,?,?,?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
		//	pstmt.setString(5, dto.getWdate());
			//이렇게 값을 줘버리면 그냥 문자열 값이 저장되므로 sysdate를 통해
			//현재의 시간등을 보여줄 수 있도록 한다.
			pstmt.setInt(5, dto.getGrpno());//부모의 grpno
			pstmt.setInt(6, dto.getIndent()+1);//부모의 indent이므로 +1
			pstmt.setInt(7, dto.getAnsnum()+1);//마찬가지로 부모의 것이므로 +1
			pstmt.setInt(8, dto.getBbsno());//부모의 글번호
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {flag=true;}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		return flag;
	}
	
	public void upAnsnum(Map map) {
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer) map.get("ansnum");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs ");
		sql.append(" set ansnum = ansnum  + 1");
		sql.append(" where grpno = ? ");
		sql.append(" and ansnum > ?");
		
			
			
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		
		
	}

}
