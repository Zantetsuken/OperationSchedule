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
// 	String name = request.getParameter("name");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String fullname = fname + "　" + lname;
// 	out.println(fullname);
	//DBAccessのインスタンスを生成する
	DBAccess db = new DBAccess();
	try{
		//データベースへのアクセス
		//SQL文
		String sql = "select * from user where id = \"" + id + "\"";
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
		//セッション取得
		HttpSession ses = request.getSession();
		if(flg){
			ses.setAttribute("login", "true");
			ses.setAttribute("id", id);
	// 		ses.setAttribute("name", name);
			ses.setAttribute("fname", fname);
			ses.setAttribute("lname", lname);
	// 		out.println(fname + lname);
			out.println("<h3>ログインしました。</h3>");
			out.println("<input type='submit' class='button1' value='行動予定一覧' autofocus>");

		}else{
			ses.setAttribute("login", "false");
			out.println("<h3>ログインに失敗しました。</h3>");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			//dbクローズ処理
			db.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
		<input type="button" class="button1" value="ユーザ名変更" onclick="location.href='Rename.jsp'">
		<input type="button" class="button1" value="ログイン画面" onclick="location.href='Login.html'">
	</form>
</body>
</html>