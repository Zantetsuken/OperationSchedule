<%
	String fname = (String)session.getAttribute("fname");
	String lname = (String)session.getAttribute("lname");
	String fullname = fname + " " + lname;
	if(fname != null && lname != null){
		try{
			out.println(fullname);
		}catch(Exception ex){}
	}
%>