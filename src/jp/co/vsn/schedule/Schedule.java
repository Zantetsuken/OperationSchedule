package jp.co.vsn.schedule;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import jp.co.vsn.util.Datasourcefactory;

/**
 * Servlet implementation class Schedule
 */
@WebServlet("/Schedule")
public class Schedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private static final String DATASOURCE_NAME = "java:comp/env/jdbc/vsn_scheduledb";
	@Override
	public void init() throws ServletException{
		try {
			ds = Datasourcefactory.lookup(DATASOURCE_NAME);
		} catch (Exception e) {
			throw new ServletException();
		}

	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Schedule() {
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
		try{
			String dateend;
			Date now = new Date();
			java.text.DateFormat date = new java.text.SimpleDateFormat("yyyy-MM-dd kk:mm");
			dateend = date.format(now);
			Autodelete delete = new Autodelete();
			delete.Autodeletedatabase(dateend);
			//遷移先jsp

			RequestDispatcher rd = request.getRequestDispatcher("Schedule.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				//dbクローズ処理
//				db.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
