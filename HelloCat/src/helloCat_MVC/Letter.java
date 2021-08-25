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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardLetterVO;
@WebServlet("/Letter")
public class Letter implements Action{

	@SuppressWarnings("resource")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		Connection conn = null;
		PreparedStatement psmt = null;
		PreparedStatement psmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);		
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
			}

		int pageNo = 1;
		int pageSize = 8;
		int count = 0;
		int comment_count = 0;
		if(request.getParameter("page")!=null){
			pageNo = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<BoardLetterVO>listletter = new ArrayList<BoardLetterVO>();
		try {
			String sql = "select b2.* from (select rownum rnum,b.* from(select * from Board_letter order by bno desc)b)b2 where rnum >= ? and rnum <= ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,pageNo*pageSize-(pageSize-1));
			psmt.setInt(2,pageNo*pageSize);
			rs = psmt.executeQuery();
			while(rs.next()){
				int bno = rs.getInt("bno");
				String sql2 = "select count(*) from comment_letter where comment_bno = ?";
				psmt2 = conn.prepareStatement(sql2);
				psmt2.setInt(1, bno);
				rs2 = psmt2.executeQuery();
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
		
		RequestDispatcher rd = request.getRequestDispatcher("Board_letter.jsp");
		request.setAttribute("list", listletter);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("total", total);
		request.setAttribute("nextPage", nextPage);
		request.setAttribute("prePage", prePage);
		
		rd.forward(request, response);
		
	}

}
