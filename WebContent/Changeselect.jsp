<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jp.co.vsn.dbaccess.DBAccess"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/table.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" media="all" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" media="all" type="text/css" href="js/jquery-ui-timepicker-addon.css" />
<script src="js/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
<script src="js/jquery-ui-timepicker-addon.js"></script>
<script src="js/jquery-ui-timepicker-ja.js"></script>
<script src="js/jquery-ui-sliderAccess.js"></script>

<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script> -->
<!-- Timepicker -->
<!-- <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/base/jquery-ui.css"/> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.js"></script> -->
<!-- <script src="js/jquery-ui-timepicker-addon.js"></script> -->
<!-- <script src="js/jquery-ui-timepicker-ja.js"></script> -->
<!-- <script src="js/jquery-ui-sliderAccess.js"></script> -->
<!-- Timepicker -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行動予定表</title>
<script type="text/javascript">
// function goServletSchedule(){
// 	 document.getElementById("form").action = 'Schedule.jsp';
// }
function blank_alert() {
	if(document.form.place.value==""){
		alert("行先を入力してください");
		return false;
	}else{
		if(window.confirm('登録しますか？')){
			document.getElementById("form").action = 'Change'; // Change.jsp へジャンプ
			return true;
		}else{
			window.alert('キャンセルされました。'); // 警告ダイアログを表示
			return false;
		}
	}
}
</script>
</head>
<body>
	<h1>行動予定の変更</h1>
	<h3>変更してください</h3>
	<form action="Change" method="post" name="form" id="form">
<%
	//パターン定義
	final String DATE_PATTERN = "yyyy-MM-dd HH:mm";
	final String detaillist[] = {"業務打合せ","事前打合せ","面談","資格試験","その他"};

	String idses = (String)session.getAttribute("id");
	String rd = request.getParameter("choice");
	//DBAccess のインスタンスを生成する
	DBAccess db = new DBAccess();

	try {
		//データベースへのアクセス
		//SQL文
		String sql = "select * from schedule where id = "+ idses + " and not delflg = '削除' limit "+ rd + ", 1";

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
		String[] strstart = dateTimeStart.split(" ", 0);

		//日付処理(終了)(本当はそのまま格納したい)
		Timestamp dateend  = result.getTimestamp("dateend");
		String dateTimeEend = new SimpleDateFormat(DATE_PATTERN).format(dateend);
		String[] strend = dateTimeEend.split(" ", 0);

		String id = result.getString("id");
		String name = result.getString("name");
		String place = result.getString("place");
		String detail = result.getString("detail");

		String riyu = result.getString("riyu");
		String delflg = result.getString("delflg");

		out.println("<tr align='center'><td>" + no + "</td>");
		out.println("<td>" + tacheck + "</td>");
		out.println("<td><input type='text' name='datestart' id='datepickerFrom'  value='" + strstart[0] + " " + strstart[1] +"' readonly/></td>");
		out.println("<td><input type='text' name='dateend' id='datepickerTo'  value='" + strend[0] + " " + strend[1] + "' readonly/></td>");
		out.println("<td>" + id + "</td>");
		out.println("<td>" + name + "</td>");
		out.println("<td><input type='text' name='place' maxlength='20' required autocomplete value='" + place + "'></td>");
		out.println("<td><select name='detail'>");

		for(int i = 0; i < detaillist.length; i++){
			if(detail.equals(detaillist[i])){
				out.println("<option value='" + detaillist[i] + "' selected = selected > "+ detaillist[i] + "</option>");
			}else{
				out.println("<option value='" + detaillist[i] + "'> "+ detaillist[i] + "</option>");
			}
		}

		out.println("</select></td>");

		//直行直帰
		if(riyu.equals("直行")){
			out.println("<td><input type='checkbox' name='riyu' value='直行' checked='checked'>直行");
			out.println("<input type='checkbox' name='riyu' value='直帰'>直帰</td>");
		}else if(riyu.equals("直帰")){
			out.println("<td><input type='checkbox' name='riyu' value='直行'>直行");
			out.println("<input type='checkbox' name='riyu' value='直帰' checked='checked'>直帰</td>");
		}else if(riyu.equals("直行直帰")){
			out.println("<td><input type='checkbox' name='riyu' value='直行' checked='checked'>直行");
			out.println("<input type='checkbox' name='riyu' value='直帰' checked='checked'>直帰</td>");
		}else{
			out.println("<td><input type='checkbox' name='riyu' value='直行'>直行");
			out.println("<input type='checkbox'  name='riyu' value='直帰'>直帰</td>");
		}
		out.println("<td>" + delflg + "</td></tr>");
		out.println("</table>");
		request.setAttribute("tacheck", tacheck);
		session.setAttribute("no",no);
		session.setAttribute("name",name);

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
		<input type="submit" class="button1" value='登録' onclick="return blank_alert()" />
		<input type="button" class="button1" value="行動予定一覧" onclick="location.href='Schedule.jsp'" />
		<input type="button" class="button1" value='ログアウト' onclick="location.href='Logout.jsp'" />
	</form>
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
</body>
</html>