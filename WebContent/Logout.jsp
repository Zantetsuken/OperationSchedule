<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
</head>
<body>
	<!-- セッション無効化 -->
	<% session.invalidate(); %>
	<!-- ログイン画面へリダイレクト -->
	<% response.sendRedirect("Login.html"); %>
</body>
</html>