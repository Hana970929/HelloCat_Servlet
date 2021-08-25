package helloCat_MVC;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hellocat.vo.Action;

public class Join_insert implements Action{

	@SuppressWarnings("null")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		String userPw = request.getParameter("pw");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String nickname = request.getParameter("nickname");

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		Connection conn = null;
		PreparedStatement psmt = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);		
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
			}
		try {							
			String sql = "insert into userdata(id,pw,name,email,phone,nickname)values(?,?,?,?,?,?)";		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			psmt.setString(2, userPw);
			psmt.setString(3, name);
			psmt.setString(4, email);
			psmt.setString(5, phone);
			psmt.setString(6, nickname);
			psmt.executeUpdate();
			
		} 
		
		catch (SQLException e) {e.printStackTrace(); }
		finally {
			try {
				psmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		RequestDispatcher rd = request.getRequestDispatcher("HelloCatServlet");
		rd.forward(request, response);		
	}

}
