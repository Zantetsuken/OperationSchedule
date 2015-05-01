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
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(true);
		Integer no = (Integer) session.getAttribute("no");
		String tacheck = (String)session.getAttribute("tacheck");
		String datestart = (String)session.getAttribute("datestart");
		String dateend = (String)session.getAttribute("dateend");
		String id = (String)session.getAttribute("id");
		String name = (String)session.getAttribute("name");
		String place = (String)session.getAttribute("place");
		String detail = (String)session.getAttribute("detail");
		String riyu =(String) session.getAttribute("riyu");

		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		try{
			String sql ="update schedule set delflg = '削除' where no = " + no + " and not delflg = '削除'";
			PreparedStatement pstmt = db.preopen(sql);
			int result = pstmt.executeUpdate();
			request.setAttribute("tacheck", tacheck);
			request.setAttribute("no", no);
			request.setAttribute("datestart", datestart);
			request.setAttribute("dateend", dateend);
			request.setAttribute("id", id);
			request.setAttribute("name", name);
			request.setAttribute("place", place);
			request.setAttribute("detail", detail);
			request.setAttribute("riyu", riyu);
			//遷移先jsp
			request.getRequestDispatcher("Delete.jsp").forward(request, response);

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
