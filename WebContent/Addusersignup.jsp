<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jp.co.vsn.dbaccess.DBAccess"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<link href="css/table.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
</head>
<body>
<form action="Schedule" method="post">
<%
	request.setCharacterEncoding("UTF-8");
	//パラメータ取得
	String id = request.getParameter("id");
	//	String name = request.getParameter("name");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String fullname = fname + "　" + lname;
	//	out.println(fullname);
	//DBAccessのインスタンスを生成する
	DBAccess db = new DBAccess();
	try{
		//データベースへのアクセス
		//SQL文
		String sql = "select * from user where id = \"" + id + "\" and name = \"" + fullname + "\"";
		//SQL実行
		PreparedStatement pstmt = db.preopen(sql);
		ResultSet result = pstmt.executeQuery();
		//フラグ初期化
		boolean flg =false;
		//入力された社員番号、名前が見つかればtrueにする
		if(result.next()){
			if(result.getString("id").equals(id) && result.getString("name").equals(fullname)){
				flg = true;
			}
		}
		if(flg){
			out.println("<h3>既に登録されています。</h3>");
			out.println("<h3>社員番号：" + id + "</h3>");
			out.println("<h3>氏名：" + fullname + "</h3>");
		}else{
			String sqlinsert = "insert into user (id,name) values ('" + id + "', '" + fullname + "')";
			PreparedStatement pstmtinsert = db.preopen(sqlinsert);
			int res = pstmtinsert.executeUpdate();
			out.println("<h3>登録しました。</h3>");
			out.println("<h3>社員番号：" + id + "</h3>");
			out.println("<h3>氏名：" + fullname + "</h3>");
		}
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("<h3>エラーです。</h3>");
		out.println("<h3>エラーコード：" + e.getErrorCode() + "</h3>");
	} finally {
		try {
			//dbクローズ処理
			db.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
		<input type="button" class="button1" value="ログイン画面" name="btn2" onclick="location.href='Login.html'">
		<input type="button" class="button1" value="ユーザ追加" name=btn2 onclick="location.href='Admin.html'">
	</form>
</body>
</html>