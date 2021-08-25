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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardLetterVO;
import com.hellocat.vo.BoardPhotoVO;

public class ClickInfinite implements Action{

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);		
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
			}
		int page = 0;
		if(request.getParameter("page")!="") {
			page = Integer.parseInt(request.getParameter("page"));
		}
		JSONArray list = new JSONArray();
		int pageNo = page;
		int pageSize = 4;
		if(request.getParameter("page")!=null){
			pageNo = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<BoardLetterVO>listletter = new ArrayList<BoardLetterVO>();
		ArrayList<BoardPhotoVO>listphoto = new ArrayList<BoardPhotoVO>();
		String sql = "select b2.* from (select rownum rnum,b.* from(select * from Board_letter order by hitcount desc)b)b2 where rnum >= ? and rnum <= ?";
		try{
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,pageNo*pageSize-(pageSize-1));
			psmt.setInt(2,pageNo*pageSize);
			rs = psmt.executeQuery();
			while(rs.next()){
				JSONObject data = new JSONObject();
				int bno = rs.getInt("bno");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String board_date = rs.getString("board_date");
				String photo = rs.getString("photo");
				int hitcount = rs.getInt("hitcount");
				data.put("bno", bno);
				data.put("title", title);
				data.put("content", content);
				data.put("writer", writer);
				data.put("board_date", board_date);
				data.put("photo", photo);
				data.put("hitcount", hitcount);
				list.add(data);
			}
		}catch (SQLException e) {
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
			JSONObject obj = new JSONObject();
			obj.put("list", list);
			out.print(obj);
	}
}
