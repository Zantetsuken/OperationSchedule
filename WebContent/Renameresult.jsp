<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<link href="css/table.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
</head>
<body>
	<h1>次の内容で登録しました</h1>
	<br>
	<br>
	<table align="center">
		<tr align="center">
				<th>社員番号</th>
				<th>氏名</th>
		</tr>
		<tr align="center">
			<td><%= request.getAttribute("id") %></td>
			<td><%= request.getAttribute("fullname") %></td>
		</tr>
	</table>
	<br>
		<input type="button" class="button1" value="ログイン画面" onclick="location.href='Login.html'">
</body>
</html>