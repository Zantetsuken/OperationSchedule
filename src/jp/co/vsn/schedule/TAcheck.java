package jp.co.vsn.schedule;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jp.co.vsn.dbaccess.DBAccess;

/**
 * Servlet implementation class TAcheck
 */
@WebServlet("/TAcheck")
public class TAcheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TAcheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String[] check = request.getParameterValues("check");

		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		try {
			//nullチェック
			if (check != null){
				for(int i = 0; i < check.length; i++){
					//個別チェック(チェックボックスにチェックを入れたレコードのみ対象)
					String sql = "update schedule set tacheck ='済' where no ='" + check[i] + "'";
					//SQL実行
					PreparedStatement pstmt = db.preopen(sql);
					int result = pstmt.executeUpdate();
			    }
			}
			//遷移先jsp
			RequestDispatcher dispatch = request.getRequestDispatcher("Schedule.jsp");

			dispatch.forward(request, response);

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
