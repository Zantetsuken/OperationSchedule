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
@WebServlet("/Insert")
public class Insert extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Insert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String datestart = request.getParameter("datestart");
		String dateend = request.getParameter("dateend");
		String id = (String)session.getAttribute("id");
		String fullname = (String)session.getAttribute("fname") + "　" + (String)session.getAttribute("lname");
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
					//直行or直帰
					riyu2 = riyu[0] + riyu[1];
				}else{
					//直行直帰
					riyu2 = riyu[0];
				}
			}
		}
		//MyDBAccessのインスタンスを生成する
		DBAccess db = new DBAccess();

		try{
			//データベースへのアクセス
			String sql ="insert into schedule(tacheck,datestart,dateend,id,name,place,detail,riyu,delflg) values"
						+"('" + '未' + "','" + datestart + "','" + dateend +"','" + id + "','" + fullname +"','" + place + "'"
						+ ",'" + detail + "','" + riyu2 + "','" + "新規" + "')";
			PreparedStatement pstmt = db.preopen(sql);
			int result = pstmt.executeUpdate();

			request.setAttribute("datestart", datestart);
			request.setAttribute("dateend", dateend);
			request.setAttribute("id", id);
			request.setAttribute("fullname", fullname);
			request.setAttribute("place", place);
			request.setAttribute("detail", detail);
			request.setAttribute("riyu", riyu2);

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
