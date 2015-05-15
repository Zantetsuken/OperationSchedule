<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jp.co.vsn.dbaccess.DBAccess"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<link href="css/table.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
<script type="text/javascript">

function goServletSchedule(){
	 document.getElementById("form").action = 'Schedule';
	 }
function disp(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('削除しますか？')){
		 document.getElementById("form").action = 'Delete';
	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{
		window.alert('キャンセルされました'); // 警告ダイアログを表示
	}
	// 「キャンセル」時の処理終了
}
function check(){
	var flag = 0;
	if(document.form.choice.length) { // 選択肢が複数ある場合
		flag = 1;
		var i;
		for(i = 0; i < document.form.choice.length; i ++){
			if(document.form.choice[i].checked){
				flag = 0;
				break;
			}
		}
	}else{ // 選択肢が1つだけの場合
		if(!document.form.choice.checked){
			flag = 1;
		}
	}
	if(flag){
		window.alert('選択されていません'); // 選択されていない場合は警告ダイアログを表示
		return false; // 送信を中止

	}else{
		return true; // 送信を実行
	}
}
</script>
</head>
<body>
	<h1>行動予定の削除</h1>
	<h3>削除されます</h3>
	<form action='Delete' method='post' id='form' name="form">
<%
	//パターン定義
	final String DATE_PATTERN = "yyyy-MM-dd HH:mm";
	String idses = (String)session.getAttribute("id");
	String rd = request.getParameter("choice");
	//DBAccess のインスタンスを生成する
	DBAccess db = new DBAccess();

	try {
		//データベースへのアクセス
		//SQL文
		String sql = "select * from schedule where id= "+ idses + " and not delflg = '削除' limit "+ rd + ", 1";

		//SQL実行
		PreparedStatement pstmt = db.preopen(sql);
		ResultSet result = pstmt.executeQuery();

		out.println("<table align='center'>");
		out.println("<tr align='center'><th>No</th><th>TAチェック</th><th>日付(開始時間)</th><th>日付(終了時間)</th><th>社員番号</th>"
					+"<th>氏名</th><th>行先(最寄駅、VSN拠点名)</th><th>内容</th><th>直行/直帰</th><th>ステータス</th></tr>");

		result.next();
		int no = result.getInt("no");
		String tacheck  = result.getString("tacheck");
		//日付処理(開始)(本当はそのまま格納したい)
		Timestamp datestart = result.getTimestamp("datestart");
		String dateTimeStart = new SimpleDateFormat(DATE_PATTERN).format(datestart);
// 		String[] strstart = dateTimeStart.split(" ", 0);

		//日付処理(終了)(本当はそのまま格納したい)
		Timestamp dateend  = result.getTimestamp("dateend");
		String dateTimeEend = new SimpleDateFormat(DATE_PATTERN).format(dateend);
// 		String[] strend = dateTimeEend.split(" ", 0);

		String id = result.getString("id");
		String name = result.getString("name");
		String place = result.getString("place");
		String detail = result.getString("detail");
		String riyu = result.getString("riyu");
		String delflg = result.getString("delflg");

		out.println("<tr align='center'><td>" + no + "</td>");
		out.println("<td>" + tacheck + "</td>");
		out.println("<td>" + dateTimeStart + "</td>");
		out.println("<td>" + dateTimeEend + "</td>");
		out.println("<td>" + id + "</td>");
		out.println("<td>" + name + "</td>");
		out.println("<td>" + place + "</td>");
		out.println("<td>" + detail + "</td>");
		out.println("<td>" + riyu + "</td>");
		out.println("<td>" + delflg + "</td></tr>");
		out.println("</table>");

		session.setAttribute("no",no);
		session.setAttribute("tacheck",tacheck);
		session.setAttribute("datestart",dateTimeStart);
		session.setAttribute("dateend",dateTimeEend);
		session.setAttribute("id",id);
		session.setAttribute("name",name);
		session.setAttribute("place",place);
		session.setAttribute("detail",detail);
// 		out.println(riyu);
		session.setAttribute("riyu",riyu);
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("<h3>エラーです。</h3>");
		out.println("<h3>エラーコード：" + e.getErrorCode() + "</h3>");
	} finally {
		try {
			//dbクローズ処理
			db.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
		<br>
		<input type="submit" class="button1" value='削除' onclick="disp()" />
		<input type="submit" class="button1" value="行動予定一覧" onclick="goServletSchedule()">
		<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
</body>
</html>