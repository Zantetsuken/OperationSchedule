package jp.co.vsn.schedule;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import jp.co.vsn.dbaccess.DBAccess;

public class Autodelete {

	public void Autodeletedatabase(String dateend) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//DBAccess のインスタンスを生成する
		DBAccess db = new DBAccess();

		//データベースへのアクセス
		try {
			//SQL文
			String sql = "select * from schedule";
			//SQL実行
			PreparedStatement pstmtsel = db.preopen(sql);
			ResultSet result = pstmtsel.executeQuery(sql);

			while(result.next())
			{
				String date_db = sdf.format(result.getDate("dateend"));
//				System.out.println("DBより日時取得 = "+ date_db);
//				System.out.println(dateend.substring(0, 10));
				if( date_db.substring(0,10).compareTo(dateend.substring(0, 10) ) < 0 )
				{
					//データベース削除
					String sqldel = "delete from schedule where tacheck = '済' and delflg = '削除' and dateend <= '" + dateend.substring(0, 10) + "'";
//					String sqldel = "delete from schedule where tacheck = '済' and delflg = '削除' and dateend <= '2015-04-22'";
					PreparedStatement pstmtdel = db.preopen(sqldel);
					int result2 = pstmtdel.executeUpdate();
				}
			}

//			//Noを初期化したい
//			String sqla = "alter table schedule change no no int not null";
//			System.out.println(sqla);
//			//SQL実行
//			PreparedStatement pstmta = db.preopen(sqla);
//			int res = pstmta.executeUpdate();
//
//			String sqlb = "alter table schedule pack_keys = 0 checksum = 0 delay_key_write =0 auto_increment = 1";
//			String sqlb = "alter table schedule auto_increment = 1";
//			System.out.println(sqlb);
//			//SQL実行
//			PreparedStatement pstmtb = db.preopen(sqlb);
//			int resa = pstmtb.executeUpdate();
//
//			String sqlc = "alter table schedule change no no int auto_increment";
//			String sqlc = "alter table schedule change no no int not null auto_increment";
//			System.out.println(sqlc);
//			//SQL実行
//			PreparedStatement pstmtc = db.preopen(sqlc);
//			int resb = pstmtc.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//dbクローズ処理
				db.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
