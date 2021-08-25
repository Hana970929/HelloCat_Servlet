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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardLetterVO;
import com.hellocat.vo.BoardPhotoVO;
import com.hellocat.vo.CommentLetterVO;
@WebServlet("/Board_Main")
public class Board_Main implements Action{

	@SuppressWarnings({ "unchecked", "resource" })
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
		int countComment = 0;
		int bno = 0;
		int pageNo = 1;
		int pageSize = 8;
		int count = 0;
		int count2 = 0;
		int like_count = 0;
		int comment_count = 0;
		if(request.getParameter("page")!=null){
			pageNo = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<BoardLetterVO>listletter = new ArrayList<BoardLetterVO>();
		ArrayList<BoardPhotoVO>listphoto = new ArrayList<BoardPhotoVO>();
		String sql = "select b2.* from (select rownum rnum,b.* from(select * from Board_letter order by hitcount desc)b)b2 where rnum >= ? and rnum <= ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,pageNo*pageSize-(pageSize-1));
			psmt.setInt(2,pageNo*pageSize);
			rs = psmt.executeQuery();
			while(rs.next()){
				bno = rs.getInt("bno");
				String sql2 = "select count(*) from comment_letter where comment_bno = ?";
				PreparedStatement psmt2 = conn.prepareStatement(sql2);
				psmt2.setInt(1, bno);
				ResultSet rs2 = psmt2.executeQuery();
				while(rs2.next()) {
					comment_count = rs2.getInt(1);
				}
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String board_date = rs.getString("board_date");
				String photo = rs.getString("photo");
				int hitcount = rs.getInt("hitcount");
				BoardLetterVO vo = new BoardLetterVO(comment_count,bno,title,content,writer,board_date,photo,hitcount);
				listletter.add(vo);
			}
			sql = "select count(*) from board_letter";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			sql = "select b2.* from (select rownum rnum,b.* from(select * from Board_photo)b)b2 where rnum >= ? and rnum <= ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,pageNo*pageSize-(pageSize-1));
			psmt.setInt(2,pageNo*pageSize);
			rs = psmt.executeQuery();
			while(rs.next()){
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
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String board_date = rs.getString("board_date");
				String photo = rs.getString("photo");
				BoardPhotoVO vo = new BoardPhotoVO(bno,content,writer,photo,board_date,count2,like_count);
				listphoto.add(vo);
			}
			sql = "select count(*) from comment_photo where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			while(rs.next()){
				countComment = rs.getInt(1);
			}
			RequestDispatcher rd = request.getRequestDispatcher("community_main.jsp");
			request.setAttribute("list", listletter);
			request.setAttribute("list2", listphoto);
			request.setAttribute("count", countComment);
			request.setAttribute("comment_count", comment_count);
			rd.forward(request, response);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		finally {
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
