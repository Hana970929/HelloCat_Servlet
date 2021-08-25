package helloCat_MVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardPhotoVO;

public class Photo implements Action{

	@SuppressWarnings("resource")
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
		ArrayList<BoardPhotoVO>listPhoto = new ArrayList<BoardPhotoVO>();
		int pageNo = 1;
		int pageSize = 8;
		int count = 0;
		int like_count = 0;
		int bno = 0;
		int count2 = 0;
		String content = "";
		String writer = "";
		String photo = "";
		String board_date = "";
		String sql = "select b2.* from(select rownum rnum,b.* from(select * from Board_photo order by bno desc)b)b2 where rnum>=1 and rnum<=8";
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				bno = rs.getInt("bno");
				String sql2 = "select count(*) from comment_photo where comment_bno=?";
				PreparedStatement pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, bno);
				ResultSet rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					count2 = rs2.getInt(1);
				}
				String sql3 = "select count(*) from like_content where like_bno = ?";
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
				BoardPhotoVO vo = new BoardPhotoVO(bno,content,writer,photo,board_date,count2,like_count);
				listPhoto.add(vo);		
			}			
			sql = "select count(*) from board_photo";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);			
			}
			int startNo = 0;
			int endNo = 0;
			for(int a = 1;;a+=5){
				if(pageNo>=a&&pageNo<=a+4){
					startNo = a;
					endNo = a+4;
					break;				
				}
			}
			int total = (count/pageSize)+(count%pageSize==0?0:1);
			int nextPage = endNo+1;
			int prePage = startNo-1;
			RequestDispatcher rd = request.getRequestDispatcher("Board_photo.jsp");
			request.setAttribute("list", listPhoto);
			request.setAttribute("startNo", startNo);
			request.setAttribute("endNo", endNo);
			request.setAttribute("total", total);
			request.setAttribute("nextPage", nextPage);
			request.setAttribute("prePage", prePage);
			rd.forward(request, response);
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
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
