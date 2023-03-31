package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn = util.DatabaseUtil.getConnection();
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public int login(String userID, String userPW) {
		String sql = "SELECT USERPW FROM USER_BBS WHERE USERID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userID);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPW)) {
					return 1;
				} else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -2;
	}
	
	public int join(UserDTO user) {
		String sql = "INSERT INTO USER_BBS VALUES(?,?,?,?,0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getUserID());
			ps.setString(3, user.getUserPW());
			ps.setString(4, user.getUserEmail());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getuserName(String userID) {
		String sql = "SELECT USERNAME FROM USER_BBS WHERE USERID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userID);
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

}
