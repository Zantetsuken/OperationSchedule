<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page import="java.sql.*"%> --%>
<%-- <%@page import="jp.co.vsn.dbaccess.DBAccess"%> --%>
<%-- <%@ page import="java.util.*" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<link href="css/table.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
<script type="text/javascript">
</script>
</head>
<body>
	<h1>次の内容で登録しました</h1>
	<br>
	<br>
	<form action="Schedule.jsp" method="post">
	<table align="center">
		<tr align="center">
				<th>No</th>
				<th>TAチェック</th>
				<th>日付(開始時間)</th>
				<th>日付(終了時間)</th>
				<th>社員番号</th>
				<th>氏名</th>
				<th>行先</th>
				<th>内容</th>
				<th>直行/直帰</th>
				<th>ステータス</th>
		</tr>
		<tr align="center">
			<td><%= request.getAttribute("no") %></td>
			<td>未</td>
			<td><%= request.getAttribute("datestart") %></td>
			<td><%= request.getAttribute("dateend") %></td>
			<td><%= request.getAttribute("id") %></td>
			<td><%= request.getAttribute("name") %></td>
			<td><%= request.getAttribute("place") %></td>
			<td><%= request.getAttribute("detail") %></td>
			<td><%= request.getAttribute("riyu2") %></td>
			<td>変更</td>
		</tr>
	</table>
	<br>
	<input type="submit" class="button1" value="行動予定一覧" />
	<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
</body>
</html>