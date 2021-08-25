package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hellocat.vo.Action;

public class Login_check implements Action{

	@SuppressWarnings("resource")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userId = request.getParameter("id");
		String userPw = request.getParameter("pw");
		String dbId = "";
		String dbPw = "";
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
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			String sql = "select * from userdata where id = ?";
			try {
				psmt = conn.prepareStatement(sql);
				psmt.setString(1,userId);
				rs = psmt.executeQuery();
				while(rs.next()) {
					dbId = rs.getString("id");						
				}
				if(dbId!=null){
					sql = "select pw from userdata where id = ?";
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, userId);
					rs = psmt.executeQuery();
					while(rs.next()) {
						dbPw = rs.getString(1);
					}
					if(userPw.equals(dbPw)) {
						session.setAttribute("user_id", userId);
						out.println("<script>alert('안녕하세요! "+userId+"님'); location.href = 'HCController?command=Board_Main'</script>");
						//request.setAttribute("id", userId);
					}else {
						out.println("<script>alert('비밀번호를 확인해주세요'); location.href = 'Login.jsp'</script>");
					}
				}else {
					out.println("<script>alert('아이디를 입력해주세요'); location.href = 'Login.jsp'</script>");
				}
				
			} catch (SQLException e) {		
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					psmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			
			

		
	}

}
