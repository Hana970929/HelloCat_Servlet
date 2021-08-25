package helloCat_MVC;

import java.io.IOException;
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

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardLetterVO;
import com.hellocat.vo.CommentLetterVO;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class ShowLetter implements Action{

	@SuppressWarnings("resource")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		ArrayList<BoardLetterVO>listBoard = new ArrayList<BoardLetterVO>();
		ArrayList<CommentLetterVO>listComment = new ArrayList<CommentLetterVO>();
		int bno = Integer.parseInt(request.getParameter("bno"));
		String title ="";
		String writer = "";
		String photo = "";
		String content = "";
		String board_date = "";
		int hitcount = 0;
		int comment_count = 0;
		String sql = "select * from Board_letter where bno = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			while(rs.next()) {
				title = rs.getString("title");
				writer = rs.getString("writer");
				photo = rs.getString("photo");
				content = rs.getString("content");
				board_date = rs.getString("board_date");
				hitcount = rs.getInt("hitcount");
				BoardLetterVO vo = new BoardLetterVO();
				listBoard.add(vo);
			}
			sql = "select count(*) from comment_letter where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			if(rs.next()){
				comment_count = rs.getInt(1);
			}
			sql = "select * from comment_letter where comment_bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bno);
			rs = psmt.executeQuery();
			while(rs.next()){
				int comment_bno = rs.getInt(1);
				String comment_date = rs.getString(2);
				String comment_content = rs.getString(3);
				String comment_writer = rs.getString(4);
				int comment_cno = rs.getInt(5);
				CommentLetterVO vo = new CommentLetterVO(comment_count,comment_bno, comment_date,comment_content,comment_writer,comment_cno);
				listComment.add(vo);
			}
			sql = "update board_letter set hitcount = ? where bno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, hitcount+1);
			psmt.setInt(2, bno);
			psmt.executeUpdate();
			
		} 
		
		catch (SQLException e) {
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
		RequestDispatcher rd = request.getRequestDispatcher("showLetter.jsp");
		request.setAttribute("title", title);
		request.setAttribute("bno", bno);
		request.setAttribute("writer", writer);
		request.setAttribute("photo", photo);
		request.setAttribute("content", content);
		request.setAttribute("board_date", board_date);
		request.setAttribute("hitcount", hitcount+1);
		request.setAttribute("comment_count", comment_count);
		request.setAttribute("list", listBoard);
		request.setAttribute("list_C", listComment);
		rd.forward(request, response);
		
		
	}

}
