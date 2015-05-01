
<%
	try{
		String login = (String)session.getAttribute("login");
		if(login.equals("false"))pageContext.forward("Loginerror.html");
	}catch(Exception ex){
		try{
			pageContext.forward("Loginerror.html");
		}catch(Exception ex2){}
	}
%>
