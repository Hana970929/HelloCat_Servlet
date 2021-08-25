package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hellocat.vo.Action;

public class Insert_like implements Action{

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		String userPw = request.getParameter("pw");
		int bno = 0;
		if(request.getParameter("bno")!="") {
			bno = Integer.parseInt(request.getParameter("bno"));			
		}
		HttpSession session = request.getSession();
		String ID = (String)session.getAttribute("user_id");
		String writer = "";
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
		JSONObject data = new JSONObject();
		JSONArray arr = new JSONArray();
		String like_id = "";
		try {
			
			String sql = "insert into like_content(like_id,like_bno) values(?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, ID);
			psmt.setInt(2, bno);
			psmt.executeUpdate();
			
			
			sql = "select count(*) from like_content where like_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs =  psmt.executeQuery();
			if(rs.next()){
				int like_count = rs.getInt(1);
				data.put("like_count", like_count);
				data.put("like_bno", bno);
			}	
		} catch(SQLIntegrityConstraintViolationException e) {
			int like_count_d = 0;
			driver = "oracle.jdbc.driver.OracleDriver";
			url = "jdbc:oracle:thin:@localhost:1521:xe";
			id = "hellocat";
			pw = "1234";
			conn = null;
			try{
				Class.forName(driver);
				conn = DriverManager.getConnection(url,id,pw);		
			}catch(ClassNotFoundException e2){
				e.printStackTrace();
			}catch(SQLException e2){
				e.printStackTrace();
				}
			try {
				String sql = "select count(*) from like_content where like_bno = ? and like_id = ?";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, bno);
				psmt.setString(2, ID);
				rs = psmt.executeQuery();
				 while(rs.next()) {
					like_count_d = rs.getInt(1);				 
				 }
				 if(like_count_d>=1){
					 sql = "delete from like_content where like_bno = ? and like_id = ?";
					 psmt = conn.prepareStatement(sql);
					 psmt.setInt(1, bno);
					 psmt.setString(2, ID);
					 psmt.executeUpdate();
				 }
				sql = "select count(*) from like_content where like_bno = ?";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, bno);
				rs =  psmt.executeQuery();
				if(rs.next()){
					int like_count = rs.getInt(1);
					data.put("like_count", like_count);
					data.put("like_bno", bno);
				}

			} catch (SQLException e2) {
					e.printStackTrace();
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
