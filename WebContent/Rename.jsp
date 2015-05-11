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
<%
	request.setCharacterEncoding("UTF-8");
	//セッション取得
	HttpSession ses = request.getSession();

	//パラメータ取得
	String id = (String)ses.getAttribute("id");
	String fname = (String)ses.getAttribute("fname");
	String lname = (String)ses.getAttribute("lname");
%>
	<h1>行動予定表</h1>
	<h3>ユーザ名変更</h3>
	<form id="form" name="form" action="" method="post">
	<table align="center">
		<tr>
		<th>社員番号</th><th>姓</th><th>名</th>
		</tr>
		<tr>
		<td><%= id %></td>
		<td><input type="text"  value=<%= fname %>></td>
		<td><input type="text" value=<%= lname %>></td>
		</tr>
	</table>
	<br><br>
		<input type="button" class="button1" value="ユーザ名変更" onclick="location.href=''">
	</form>
</body>
</html>