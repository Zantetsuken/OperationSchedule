<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/table.css" type="text/css" rel="stylesheet" />

<link rel="stylesheet" media="all" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" media="all" type="text/css" href="js/jquery-ui-timepicker-addon.css" />
<script src="js/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
<script src="js/jquery-ui-timepicker-addon.js"></script>
<script src="js/jquery-ui-timepicker-ja.js"></script>
<script src="js/jquery-ui-sliderAccess.js"></script>
<title>行動予定表</title>
<script type="text/javascript">
function blank_alert() {
	//入力欄が空白かチェック
	if(document.form.datestart.value=="" || document.form.dateend.value=="" || document.form.place.value==""){
		alert("日付、行き先を入力してください");
		return false;
		document.getElementById("form").action = 'Scheduleadd.jsp'; // Scheduleadd.jsp へジャンプ
	}else{
		// 「OK」時の処理開始 ＋ 確認ダイアログの表示
		if(window.confirm('登録しますか？')){
			return true;
			document.getElementById("form").action = 'Insert'; // Insert.jsp へジャンプ
		}
		// 「OK」時の処理終了
		// 「キャンセル」時の処理開始
		else{
			window.alert('キャンセルされました。'); // 警告ダイアログを表示
			return false;
		}
		// 「キャンセル」時の処理終了
	}
}

function goServlet(){
	 document.getElementById("form").action = 'Schedule.jsp';
}
</script>
</head>
<body>
<%
	//現在ログインしている社番と名前を取得(セッション)
	String id = (String)session.getAttribute("id");
	String fname = (String)session.getAttribute("fname");
	String lname = (String)session.getAttribute("lname");
	String fullname = fname + "　" + lname;
%>
	<h1>行動予定の登録</h1>
	<form action="Insert" method="post" name="form">
		<table align="center">
			<tr align="center">
				<th>TAチェック</th>
				<th>日付(開始時間)</th>
				<th>日付(終了時間)</th>
				<th>社員番号</th>
				<th>氏名</th>
				<th>行先(最寄駅、VSN拠点名)</th>
				<th>内容</th>
				<th>直行/直帰</th>
				<th>ステータス</th>
			</tr>
			<tr align="center">
				<td id="tacheck">未</td>
				<td><input type="text" name="datestart" id="datepickerFrom" autocomplete readonly/></td>
				<td><input type="text" name="dateend" id="datepickerTo" autocomplete readonly/></td>
				<td><%= id %></td>
				<td><%= fullname %></td>
				<td><input type="text" name="place" maxlength="20" placeholder="最寄駅、VSN拠点名" required autocomplete style="ime-mode: active;"></td>
				<td>
				<select name="detail">
						<option value="業務打合せ" selected>業務打合せ</option>
						<option value="事前打合せ">事前打合せ</option>
						<option value="面談">面談</option>
						<option value="資格試験">資格試験</option>
						<option value="その他">その他</option>
				</select>
				<td>
				<input type="checkbox" name="riyu" value="直行">直行
				<input type="checkbox" name="riyu" value="直帰">直帰
				</td>
				<td>新規</td>
			</tr>
		</table>
		<br>
		<input type="submit" class="button1" value='登録' onclick="return blank_alert()" />
		<input type="button" class="button1" value="行動予定一覧" onclick="location.href='Schedule.jsp'" />
		<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
</body>
<script>
var startDateTextBox = $('#datepickerFrom');
var endDateTextBox = $('#datepickerTo');

startDateTextBox.datetimepicker({
	timeFormat: 'HH:mm',

	onClose: function(dateText, inst) {
		if (endDateTextBox.val() != '') {
			var testStartDate = startDateTextBox.datetimepicker('getDate');
			var testEndDate = endDateTextBox.datetimepicker('getDate');
			if (testStartDate > testEndDate)
				alart(setDate)
				endDateTextBox.datetimepicker('setDate', testStartDate);
		}
		else {
			endDateTextBox.val(dateText);
		}
	},
	onSelect: function (selectedDateTime){
		endDateTextBox.datetimepicker('option', 'minDate', startDateTextBox.datetimepicker('getDate') );
	}
});
endDateTextBox.datetimepicker({
	timeFormat: 'HH:mm',
	onClose: function(dateText, inst) {
		if (startDateTextBox.val() != '') {
			var testStartDate = startDateTextBox.datetimepicker('getDate');
			var testEndDate = endDateTextBox.datetimepicker('getDate');
			if (testStartDate > testEndDate)
				startDateTextBox.datetimepicker('setDate', testEndDate);
		}
		else {
			startDateTextBox.val(dateText);
		}
	},
	onSelect: function (selectedDateTime){
		startDateTextBox.datetimepicker('option', 'maxDate', endDateTextBox.datetimepicker('getDate') );
	}
});
</script>
</html>