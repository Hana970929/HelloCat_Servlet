package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hellocat.vo.BoardPhotoVO;

@WebServlet("/infinity")
public class Infinity extends HttpServlet {
	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		int page = Integer.parseInt(request.getParameter("page")); 
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
		ArrayList<BoardPhotoVO>listPhoto = new ArrayList<BoardPhotoVO>();
		int pageNo = page;
		int pageSize = 8;
		int bno = 0;
		String content = "";
		String writer = "";
		String photo = "";
		String board_date = "";
		JSONArray listJson = new JSONArray();
		int like_count = 0;
		
		String sql = "select b2.* from(select rownum rnum,b.* from(select * from Board_photo)b)b2 where rnum>=? and rnum<=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, (pageNo*pageSize)-(pageSize-1));
			psmt.setInt(2, pageNo*pageSize);
			rs = psmt.executeQuery();
			while(rs.next()) {
				JSONObject data = new JSONObject();
				bno = rs.getInt("bno");
				String sql2 = "select count(*) from comment_photo where comment_bno=?";
				PreparedStatement pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, bno);
				ResultSet rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					int count = rs2.getInt(1);
					data.put("count_comment", count);
				}
				String sql3 = "select count(*) from like_content where like_bno=?";
				PreparedStatement psmt2 = conn.prepareStatement(sql3);
				psmt2.setInt(1, bno);
				ResultSet rs3 = psmt2.executeQuery();
				if(rs3.next()){
					like_count = rs3.getInt(1);
				}
				content = rs.getString("content");
				writer = rs.getString("writer");
				photo = rs.getString("photo");
				board_date = rs.getString("board_date");
				data.put("bno",bno);
				data.put("content",content);
				data.put("writer",writer);
				data.put("photo",photo);
				data.put("like_count", like_count);
				listJson.add(data);				
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
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		obj.put("list",listJson);
		out.print(obj);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
