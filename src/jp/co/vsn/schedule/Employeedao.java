package jp.co.vsn.schedule;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import jp.co.vsn.dbaccess.DBAccess;

public class Employeedao {
	public List<Employee> findall() throws Exception{

		List<Employee> emplist = new ArrayList<Employee>();

//		String id = (String)session.getAttribute("id");
		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		//データベースへのアクセス
		try {

			//SQL文
			String sql = "select * from schedule";
			//SQL実行
			PreparedStatement pstmt = db.preopen(sql);
			ResultSet result = pstmt.executeQuery();

//			out.println("<table align='center'>");
//
////	 		out.println("<tr align='center'><th>No</th><th>TAチェック</th><th>日付(開始時間)</th><th>日付(終了時間)</th><th>社員番号</th><th>氏名</th><th>行先</th><th>内容</th><th>ステータス</th></tr>");
//			out.println("<tr align='center'><th>選択</th><th>No</th><th>TAチェック</th><th>日付(開始時間)</th><th>日付(終了時間)</th>"
//													+ "<th>氏名</th><th>行先</th><th>内容</th><th>直行/直帰</th><th>ステータス</th></tr>");

			while(result.next())
			{
				String riyu = null;
				int no = result.getInt("no");
				String tacheck  = result.getString("tacheck");

				//日付(開始)
				Timestamp datestart = result.getTimestamp("datestart");
				String dateTimeStart = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(datestart);
				//日付(終了)
				Timestamp dateend  = result.getTimestamp("dateend");
				String dateTimeEend = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dateend);
				String id1 = result.getString("id");
				String name = result.getString("name");
				String place = result.getString("place");
				String detail = result.getString("detail");

				if(result.getString("riyu") == null){
					riyu = " ";
				}else{
					riyu = result.getString("riyu");
				}
				String delflg = result.getString("delflg");

//				out.println("<tr align='center'>");
//				out.println("<td><input type='checkbox' name='check' value='" + no + "'></td>");
//				out.println("<td>" + no + "</td>");
//				//TAチェック
//				if(tacheck.equals("未")){
//					out.println("<td bgcolor='#ff0000'><b>" + tacheck + "</b></td>");
//				}else{
//					out.println("<td bgcolor='#00bfff'><b>" + tacheck + "</b></td>");
//				}
//
//				out.println("<td>" + dateTimeStart + "</td>");
//				out.println("<td>" + dateTimeEend + "</td>");
////	 			out.println("<td>" + id1 + "</td>");
//				out.println("<td>" + name + "</td>");
//				out.println("<td>" + place + "</td>");
//				out.println("<td>" + detail + "</td>");
//				out.println("<td>" + riyu + "</td>");
//				//ステータス
//				if(delflg.equals("新規")) {
//					out.println("<td bgcolor='#ff0000'><b>"+ delflg +"</b></td></tr>");
//				}else if(delflg.equals("削除")){
//					out.println("<td bgcolor='#00bfff'><b>"+ delflg +"</b></td></tr>");
//				}else if(delflg.equals("変更")){
//					out.println("<td bgcolor='#ffff00'><b>"+ delflg +"</b></td></tr>");
//				}
	 			Employee employee = new Employee(no,tacheck,dateTimeStart,dateTimeEend,id1,name,place,detail,riyu,delflg);
	 			emplist.add(employee);
			}
//			out.println("</table>");

			} catch (SQLException e) {
				throw new SQLException(e);
			} finally {
			try {
				//dbクローズ処理
				db.close();
			} catch (Exception e) {
				throw new Exception(e);
			}
	}
		return emplist;


	}
}
