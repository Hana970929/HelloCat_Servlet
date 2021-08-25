package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.hellocat.vo.Action;

public class PhoneCheck implements Action{

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone = request.getParameter("phone");
		String dbId = "";
		String dbEmail = "";
		int loginCheckP= 0;

		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);		
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
			}
		response.setContentType("text/html; charset=utf-8");
			try {			
					String sql = "select count(*) from userdata where phone = ?";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, phone);
					rs = psmt.executeQuery();
					while(rs.next()){
						loginCheckP = rs.getInt(1);
					}
			}catch (SQLException e) {
			}finally {
				try {
					rs.close();
					psmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			JSONObject obj = new JSONObject();
			obj.put("loginCheckP",loginCheckP);
			out.print(obj);
		
	}

}
