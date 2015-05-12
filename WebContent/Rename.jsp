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
<script type="text/javascript">
function blank_alert() {
	//入力欄が空白かチェック
	if(document.form.fname.value=="" || document.form.lname.value==""){
		alert("姓、名を入力してください");
		return false;
	}else{
			// 「OK」時の処理開始 ＋ 確認ダイアログの表示
			if(window.confirm('登録しますか？')){
				if(false == chk1() || false == chk2() || false == chk3() || false == chk4()){
					alert("登録できません。")
					location.href = 'Rename.jsp';
					return false;
				}else{
					document.getElementById("form").action = 'Rename'; // Addusersignup.jsp へジャンプ
					alert("登録されました。")
					return true;
				}
			}else{
				window.alert('キャンセルされました。'); // 警告ダイアログを表示
				return false;
			}
		}
		return true;
}
//半角英数字記号が入力されたかチェック
function chk1() {
	var str1 = $("input[name='fname']").val();
	if(str1.match(/^[a-zA-Z0-9 -/:-@\[-\`\{-\~]+$/)) {
		alert("半角英数字記号が入力されました。");
		return false;
	} else {
		return true;
	}
}
//半角英数字記号が入力されたかチェック
function chk2() {
	var str2 = $("input[name='lname']").val();
	if(str2.match(/^[a-zA-Z0-9 -/:-@\[-\`\{-\~]+$/)) {
		alert("半角英数字記号が入力されました。");
		return false;
	} else {
		return true;
	}
}
function chk3() {
	var str3 = $("input[name='fname']").val();
	if(str3.match(/^[ぁ-んァ-ヶー一-龠 　\r\n\t]+$/)) {
		return true;
	} else {
		return false;
	}
}
function chk4() {
	var str4 = $("input[name='lname']").val();
	if(str4.match(/^[ぁ-んァ-ヶー一-龠 　\r\n\t]+$/)) {
		return true;
	} else {
		return false;
	}
}
</script>
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
	<form id="form" name="form" action="Rename" method="post">
	<table align="center">
		<tr>
		<th>社員番号</th><th>姓</th><th>名</th>
		</tr>
		<tr>
		<td><%= id %></td>
		<td><input type="text" name="fname" maxlength="10" value=<%= fname %>></td>
		<td><input type="text" name="lname" maxlength="10" value=<%= lname %>></td>
		</tr>
	</table>
	<br><br>
		<input type="submit" class="button1" value="登録" onclick="return blank_alert();">
		<input type="button" class="button1" value="ログイン画面" onclick="location.href='Login.html'">
	</form>
</body>
</html>