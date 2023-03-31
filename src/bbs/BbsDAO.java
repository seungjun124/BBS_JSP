package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	public String getDate() {
		String sql = "SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return "";
	}
	
	public int getNext() {
		String sql = "SELECT BBSNUMBER FROM BBS_DB ORDER BY BBSNUMBER DESC";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "INSERT INTO BBS_DB VALUES(?,?,?,?,?,1)";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, getNext());
			ps.setString(2, bbsTitle);
			ps.setString(3, userID);
			ps.setString(4, bbsContent);
			ps.setString(5, getDate());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public ArrayList<BbsDTO> getList(int pageNumber) {
		String sql = "SELECT * FROM (SELECT * FROM BBS_DB WHERE BBSNUMBER < ? AND BBSACTIVE = 1 ORDER BY BBSNUMBER DESC) WHERE ROWNUM <= 11";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = ps.executeQuery();
			while(rs.next()) {
				BbsDTO bbsDTO = new BbsDTO();
				bbsDTO.setBbsNumber(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsContent(rs.getString(4));
				bbsDTO.setBbsDate(rs.getString(5));
				bbsDTO.setBbsActive(rs.getInt(6));
				list.add(bbsDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM BBS_DB WHERE BBSNUMBER <= ? AND BBSACTIVE = 1";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return false;
	}
	
	public BbsDTO getBbs(int bbsNumber) {
		String sql = "SELECT * FROM BBS_DB WHERE BBSNUMBER = ?";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbsNumber);
			rs = ps.executeQuery();
			if(rs.next()) {
				BbsDTO bbsDTO = new BbsDTO();
				bbsDTO.setBbsNumber(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsContent(rs.getString(4));
				bbsDTO.setBbsDate(rs.getString(5));
				bbsDTO.setBbsActive(rs.getInt(6));
				return bbsDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return null;
	}
	
	public int update(int bbsNumber, String bbsTitle, String bbsContent) {
		String sql = "UPDATE BBS_DB SET BBSTITLE = ? ,BBSCONTENT = ? WHERE BBSNUMBER = ?";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bbsTitle);
			ps.setString(2, bbsContent);
			ps.setInt(3, bbsNumber);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int delete(int bbsNumber) {
		String sql = "UPDATE BBS_DB SET BBSACTIVE = 0 WHERE BBSNUMBER = ?";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbsNumber);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
}
