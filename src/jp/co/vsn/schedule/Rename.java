package jp.co.vsn.schedule;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jp.co.vsn.dbaccess.DBAccess;
/**
 * Servlet implementation class Insert
 */
@WebServlet("/Rename")
public class Rename extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Rename() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String fname = (String)session.getAttribute("fname");
		String lname = (String)session.getAttribute("lname");
		String fullname = fname + "　" + lname;
		//MyDBAccessのインスタンスを生成する
		DBAccess db = new DBAccess();

		try{
			//データベースへのアクセス
			String sqlinsert = "update user set id = '"+ id + "',name ='"+ fullname +"'";
			PreparedStatement pstmtinsert = db.preopen(sqlinsert);
			int res = pstmtinsert.executeUpdate();

			//遷移先jsp
			request.getRequestDispatcher("Update.jsp").forward(request, response);

		} catch (Exception e) {
			throw new ServletException(e);
		} finally {
			try {
				//dbクローズ処理
				db.close();
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
