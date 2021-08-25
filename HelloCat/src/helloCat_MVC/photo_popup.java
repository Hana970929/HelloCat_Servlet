package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;


@WebServlet("/photo_popup")
public class photo_popup extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@SuppressWarnings({ "unchecked", "resource" })
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		JSONObject data = new JSONObject();
		int bno2 = 0;
		int like_count = 0;
			if(request.getParameter("bno") != "") {				
				bno2 = Integer.parseInt(request.getParameter("bno"));
			}
		String sql = "select * from Board_photo where bno = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno2);
			rs = psmt.executeQuery();
			while(rs.next()){
				String photo = rs.getString("photo");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String board_date = rs.getString("board_date");
				int bno = rs.getInt("bno");
				String sql2 = "select count(*) from like_content where like_bno = ?";
				PreparedStatement psmt2 = conn.prepareStatement(sql2);
				psmt2.setInt(1, bno);
				ResultSet rs2 = psmt2.executeQuery();
				if(rs2.next()){
					like_count = rs2.getInt(1);
					data.put("like_count", like_count);
				}
				rs2.close();
				psmt2.close();
				data.put("photo", photo);	
				data.put("bno", bno);	
				data.put("content", content);	
				data.put("writer", writer);
				data.put("board_date", board_date);
				}
			sql = "select count(*) from comment_photo where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno2);
			rs = psmt.executeQuery();
			while(rs.next()){
				int countComment  = rs.getInt(1);
				data.put("count", countComment);
			}
			rs.close();
			psmt.close();
			conn.close();
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			JSONObject obj = new JSONObject();
			obj.put("data", data);
			out.print(obj);
		
		
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
