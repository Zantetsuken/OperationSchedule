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
 * Servlet implementation class Change
 */
@WebServlet("/Change")
public class Change extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Change() {
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
		String datestart = request.getParameter("datestart");
		String dateend = request.getParameter("dateend");
		String id = (String)session.getAttribute("id");
		String name = (String)session.getAttribute("name");
		String place = request.getParameter("place");
		String detail = request.getParameter("detail");
		String riyu2 = null;
		String[] riyu = request.getParameterValues("riyu");

		//直行直帰のnullチェック
		if(riyu == null){
			//未選択の場合
			riyu2 = " ";
		}else{
			for(int i = 0; i < riyu.length; i++){
				if(i == 1){
					riyu2 = riyu[0] + riyu[1];
				}else{
					riyu2 = riyu[0];
				}
			}
		}
		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		try{
			//データベースへのアクセス

			String sql ="update schedule set tacheck ='未',datestart ='"+ datestart + "', dateend ='"+ dateend +"',place ='" + place + "',"
				+ " detail ='"+ detail +"',riyu ='" + riyu2 + "',delflg ='変更'  where no = '" + no + "'";
			PreparedStatement pstmt = db.preopen(sql);
			int res = pstmt.executeUpdate();
			request.setAttribute("no", no);
			request.setAttribute("datestart", datestart);
			request.setAttribute("dateend", dateend);
			request.setAttribute("id", id);
			request.setAttribute("name", name);
			request.setAttribute("place", place);
			request.setAttribute("detail", detail);
			request.setAttribute("riyu2", riyu2);
			//遷移先jsp
			request.getRequestDispatcher("Change.jsp").forward(request, response);
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
