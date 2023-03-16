package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String USERID, String USERPASSWORD) {
		String SQL = "SELECT USERPASSWORD FROM TEST WHERE USERID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, USERID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(USERPASSWORD)) {
					return 1; //로그인 성공
				} else {
					return 0; //로그인 실패
				}
			}
			return -1; //아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO TEST VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUSERID());
			pstmt.setString(2, user.getUSERPASSWORD());
			pstmt.setString(3, user.getUSERNAME());
			pstmt.setString(4, user.getUSERGENDER());
			pstmt.setString(5, user.getUSEREMAIL());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
 }
