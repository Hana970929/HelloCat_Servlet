package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hellocat.vo.Action;

public class Insert_photo_comment implements Action{

	//@SuppressWarnings("unchecked")
	@SuppressWarnings({ "unchecked", "resource" })
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ID = (String)session.getAttribute("user_id");
		int bno = 0;
		if(request.getParameter("bno")!="") {
			bno = Integer.parseInt(request.getParameter("bno"));			
		}
		String content2 = request.getParameter("content");
		String content = URLDecoder.decode(content2, "UTF-8");

		String[]conTent = content.split("=");
		String content1 = conTent[1];
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
		JSONArray arr = new JSONArray();
		String like_id = "";
		try {
			String sql = "insert into comment_photo(comment_writer,comment_bno,comment_content,comment_cno) values(?,?,?,SEQ_PHOTO_CNO.nextval)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, ID);
			psmt.setInt(2, bno);
			psmt.setString(3, content1);
			psmt.executeUpdate();

			sql = "select * from comment_photo where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs =  psmt.executeQuery();
			while(rs.next()){
				String comment_writer = rs.getString("comment_writer");
				String comment_content = rs.getString("comment_content");
				int comment_cno = rs.getInt("comment_cno");
				String comment_date = rs.getString("comment_date");
				data.put("comment_writer", comment_writer);
				data.put("comment_content", comment_content);
				data.put("comment_cno", comment_cno);
				data.put("comment_date", comment_date);
			}
			sql = "select count(*) from comment_photo where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int count = rs.getInt(1);
				data.put("count", count);
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
			obj.put("data", data);
			out.print(obj);
		
	}


}
