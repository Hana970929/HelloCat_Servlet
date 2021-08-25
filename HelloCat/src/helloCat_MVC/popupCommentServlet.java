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
import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

@WebServlet("/popupCommentServlet")
public class popupCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = 0;
		if(request.getParameter("bno")!="") {
			bno = Integer.parseInt(request.getParameter("bno"));
		}
		JSONArray arr  = new JSONArray();
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
		String sql = "select * from comment_photo where comment_bno = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,bno);
			rs = psmt.executeQuery();
			while(rs.next()){
				JSONObject data  = new JSONObject();
				String comment_writer = rs.getString("comment_writer");
				String comment_content = rs.getString("comment_content");
				String comment_date = rs.getString("comment_date");
				int comment_cno = rs.getInt("comment_cno");
				data.put("comment_writer", comment_writer);
				data.put("comment_content", comment_content);
				data.put("comment_date", comment_date);
				data.put("comment_cno", comment_cno);
				arr.add(data);
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
		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("arr", arr);
		out.print(obj);		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
