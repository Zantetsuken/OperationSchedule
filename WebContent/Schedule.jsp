<%@page import="jp.co.vsn.schedule.Employeedao"%>
<%@page import="jp.co.vsn.schedule.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import=" java.util.List"%>
<jsp:include page="Checklogin.jsp" />
<%@ page import="java.text.SimpleDateFormat" %>
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
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript">

//サーブレットへ遷移
function goServletTAcheck(){
	 document.getElementById("form").action = 'TAcheck';
}
$(document).ready(function() {
	//tr要素をクリックでイベント発火
	$('table tr').click(function() {
		//td要素からチェックボックスを探す
		var $c = $(this).children('td').children('input[type=checkbox]');
		if($c.prop('checked'))
			$c.prop('checked', '');
		else
			$c.prop('checked', 'checked');
	});
});
</script>
</head>
<body>
<h3 align="center">
	ようこそ<jsp:include page="Getuser.jsp" />さん。
</h3>
<h1 align="center">行動予定表一覧</h1>
	<form name="area_chk" id="form" action="" method="post" >
<%
	String fname = (String)session.getAttribute("fname");
	String lname = (String)session.getAttribute("lname");
	String fullname = fname + "　"+ lname;
// 	out.println(fullname);
// 	int no = (int)session.getAttribute("no");

	Employeedao empdao = new Employeedao();
	List<Employee> emplist = empdao.findall();

	out.println("<table align='center'>");
	out.println("<tr align='center'><th>選択</th><th>No</th><th>TAチェック</th><th>日付(開始時間)</th><th>日付(終了時間)</th>"
												+ "<th>氏名</th><th>行先</th><th>内容</th><th>直行/直帰</th><th>ステータス</th></tr>");
	out.println("<tr align='center'>");

	for(Employee emp : emplist){
		out.println("<td><input type='checkbox' name='check' value='" + emp.getNo() + "'></td>");
		out.println("<td>" + emp.getNo() + "</td>");
		//TAチェック
		if(emp.getTacheck().equals("未")){
			out.println("<td bgcolor='#ff0000'><b>" + emp.getTacheck() + "</b></td>");
		}else{
			out.println("<td bgcolor='#00bfff'><b>" + emp.getTacheck() + "</b></td>");
		}
		out.println("<td>" + emp.getDatestart() + "</td>");
		out.println("<td>" + emp.getDateend() + "</td>");
		out.println("<td>" + emp.getName() + "</td>");
		out.println("<td>" + emp.getPlace() + "</td>");
		out.println("<td>" + emp.getDetail() + "</td>");
		out.println("<td>" + emp.getRiyu() + "</td>");
		//ステータス
		if(emp.getDelflg().equals("新規")) {
			out.println("<td bgcolor='#ff0000'><b>"+ emp.getDelflg() +"</b></td></tr>");
		}else if(emp.getDelflg().equals("削除")){
			out.println("<td bgcolor='#00bfff'><b>"+ emp.getDelflg() +"</b></td></tr>");
		}else if(emp.getDelflg().equals("変更")){
			out.println("<td bgcolor='#ffff00'><b>"+ emp.getDelflg() +"</b></td></tr>");
		}
	}
	out.println("</table>");
%>
<br>
<%
	boolean flg = false;
	//とりあえずTAの名前を列挙
	String str[] = {"武威　アデコ","赤羽根　大輔","須賀　俊介","板倉　剛一","板倉　剛一","髙尾　昌平","神谷　朋弘","小口　尊士","石黒　友恵","松倉　大樹"};
	for(int i = 0; i < str.length; i++){
// 		System.out.println(str[i]);
		if(str[i].equals(fullname)) {
// 			System.out.println("ありました");
			flg  = true;
			break;
		}
	}

	if (flg) { %>
<!-- 		<input type="button" value="登録(テスト用)" class="button1" onclick="location.href='Scheduleadd.jsp'" /> -->
<!-- 		<input type="button" value="変更(テスト用)" class="button1" onclick="location.href='Schedulechange.jsp'"  /> -->
<!-- 		<input type="button" value="削除(テスト用)" class="button1" onclick="location.href='Scheduledel.jsp'"  /> -->
		<input type="submit" value="チェック" class="button1"  onclick="goServletTAcheck();">
	<% } else { %>
		<input type="button" value="登録" class="button1" onclick="location.href='Scheduleadd.jsp'" />
		<input type="button" value="変更" class="button1" onclick="location.href='Schedulechange.jsp'" />
		<input type="button" value="削除" class="button1" onclick="location.href='Scheduledel.jsp'" />
<!-- 		<input type="submit" value="チェック" class="button1"  onclick="goServletTAcheck();"> -->
	<% }
%>
		<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
</body>
</html>