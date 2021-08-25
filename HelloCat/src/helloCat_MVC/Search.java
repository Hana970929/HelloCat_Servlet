package helloCat_MVC;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hellocat.vo.Action;
import com.hellocat.vo.BoardLetterVO;
import com.hellocat.vo.ProductVO;

public class Search implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		String search = request.getParameter("search");
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		DecimalFormat df = new DecimalFormat("###,###");
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);		
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
			}
		ArrayList<BoardLetterVO> list  = new ArrayList<BoardLetterVO>();
		ArrayList<ProductVO> pdlist  = new ArrayList<ProductVO>();
		String sql = "select * from board_letter where content like ? or title like ? or writer like ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%"+search+"%");
			psmt.setString(2, "%"+search+"%");
			psmt.setString(3, "%"+search+"%");
			rs = psmt.executeQuery();
			while(rs.next()) {
				int comment_count = 0;
				int bno = rs.getInt("bno");
				String sql2 = "select count(*) from comment_letter where comment_bno = ?";
				PreparedStatement psmt2 = conn.prepareStatement(sql2);
				psmt2.setInt(1, bno);
				ResultSet rs2 = psmt2.executeQuery();
				if(rs2.next()){
					comment_count = rs2.getInt(1);
				}
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String photo = rs.getString("photo");
				String board_date = rs.getString("board_date");
				int hitcount = rs.getInt("hitcount");
				BoardLetterVO vo = new BoardLetterVO(comment_count,bno,title,content,writer,board_date,photo, hitcount);
				list.add(vo);
			}
			sql = "SELECT * FROM product WHERE name LIKE ? OR explain LIKE ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%"+search+"%");
			psmt.setString(2, "%"+search+"%");
			rs = psmt.executeQuery();
			while(rs.next()) {
				double d = 0;
				double sum = 0;
				String pdid = rs.getString("id");
				String name = rs.getString("name");
				int price = rs.getInt("price");
				int sales = rs.getInt("sales");
				String explain = rs.getString("explain");
				String photo = rs.getString("photo");
				String s_price = df.format(price);
				String sql2 = "SELECT * FROM review WHERE pd_id = ?";
				PreparedStatement pstmt2;
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, pdid);
				ResultSet rs2;
				rs2 = pstmt2.executeQuery();
				while (rs2.next()) {
					int a = rs2.getInt("score");
					sum += a;
					d++;
				}
				double avr = Math.round((sum / d) * 100.0) / 100.0;
				int rvcnt = (int)d;
				pdlist.add(new ProductVO(pdid,name,price,sales,explain,photo,s_price,avr,rvcnt)); 
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
		
		RequestDispatcher rd = request.getRequestDispatcher("SearchResult.jsp");
		request.setAttribute("pdList", pdlist);
		request.setAttribute("list",list);
		request.setAttribute("search", search);
		rd.forward(request, response);
		
	}

}
