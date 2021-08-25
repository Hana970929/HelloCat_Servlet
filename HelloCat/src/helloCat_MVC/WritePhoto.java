package helloCat_MVC;

import java.io.IOException;
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

public class WritePhoto implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)session.getAttribute("user_id");
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
		String contents = request.getParameter("contents");
		String photo_contents = request.getParameter("bpp");
		
		String sql = "insert into board_photo(bno,photo,writer,content)values(seq_photo.nextval,?,?,?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, photo_contents);
			psmt.setString(2, ID);
			psmt.setString(3, contents);
			psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				psmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		RequestDispatcher rd = request.getRequestDispatcher("WritePhoto_action.jsp");
		rd.forward(request, response);
	}

}
