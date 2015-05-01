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
function goServlet(){
	 document.getElementById("form").action = 'Schedule.jsp';
}
function check(){

	var flag = 0;
	if(document.form.choice == undefined){
		return false; // 送信を中止
	}else if(document.form.choice.length) { // 選択肢が複数ある場合
		flag = 1;
		var i;
		for(i = 0; i < document.form.choice.length; i ++){
			if(document.form.choice[i].checked){
				flag = 0;
				break;
			}
		}
	}else if(!document.form.choice.checked){ // 選択肢が1つだけの場合
		flag = 1;
	}

	if(flag){
		window.alert('選択されていません'); // 選択されていない場合は警告ダイアログを表示
		return false; // 送信を中止
	}else{
		return true; // 送信を実行
	}
}
$(document).ready(function() {
	//tr要素をクリックでイベント発火
	$('table tr').click(function() {
		//td要素からラジオボタンを探す
		var $r = $(this).children('td').children('input[type=radio]');
		if($r.prop('checked'))
			$r.prop('checked', '');
		else
			$r.prop('checked', 'checked');
	});
});
</script>
</head>
<body>
	<h1>行動予定の削除</h1>
	<h3>削除したい行動予定を選択してください</h3>
	<form action="Deleteselect.jsp" method="post" name="form">
<%
	String idses = (String)session.getAttribute("id");

	//DBAccess のインスタンスを生成する
	DBAccess db = new DBAccess();

	//データベースへのアクセス
	try {
		//SQL文
		String sql = "select * from schedule where id = "+ idses + " and not delflg = '削除'";
		//SQL実行
		PreparedStatement pstmt = db.preopen(sql);
		ResultSet result = pstmt.executeQuery();

		out.println("<table align='center'>");
		out.println("<tr align='center'><th>選択</th><th>No</th><th>TAチェック</th><th>日付(開始時間)</th><th>日付(終了時間)</th>"+
									"<th>社員番号</th><th>氏名</th><th>行先</th><th>内容</th><th>直行/直帰</th><th>ステータス</th></tr>");

		int i = 0;
		while(result.next())
		{
			int no = result.getInt("no");
			String tacheck  = result.getString("tacheck");
// 			String datestart = result.getString("datestart");
// 			String dateend  = result.getString("dateend");

			//日付(開始)
			Timestamp datestart = result.getTimestamp("datestart");
			String dateTimeStart = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(datestart);
			//日付(終了)
			Timestamp dateend  = result.getTimestamp("dateend");
			String dateTimeEend = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dateend);

			String id = result.getString("id");
			String name = result.getString("name");
			String place = result.getString("place");
			String detail = result.getString("detail");
			String riyu = result.getString("riyu");

			if(result.getString("riyu") == null){
				riyu = " ";
			}else{
				riyu = result.getString("riyu");
			}

			String delflg = result.getString("delflg");

			out.println("<tr align='center'><td><input type='radio' name='choice' value= "+ i +" /></td>");
			out.println("<td>" + no + "</td>");
			out.println("<td>" + tacheck + "</td>");
			out.println("<td>" + dateTimeStart + "</td>");
			out.println("<td>" + dateTimeEend + "</td>");
			out.println("<td>" + id + "</td>");
			out.println("<td>" + name + "</td>");
			out.println("<td>" + place + "</td>");
			out.println("<td>" + detail + "</td>");
			out.println("<td>" + riyu + "</td>");
			out.println("<td>" + delflg + "</td></tr>");
			i++;
		}
		session.setAttribute("choice",i);
		out.println("</table>");
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
		<input type="submit" class="button1" value='削除' onclick="return check();" />
		<input type="button" class="button1" value="行動予定一覧" onclick="location.href='Schedule.jsp'">
		<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
</body>
</html>