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

		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		//データベースへのアクセス
		try {

			//SQL文
			String sql = "select * from schedule";
			//SQL実行
			PreparedStatement pstmt = db.preopen(sql);
			ResultSet result = pstmt.executeQuery();

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

	 			Employee employee = new Employee(no,tacheck,dateTimeStart,dateTimeEend,id1,name,place,detail,riyu,delflg);
	 			emplist.add(employee);
			}

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
