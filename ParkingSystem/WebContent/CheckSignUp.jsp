<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Sign Up</title>
</head>
<body>
<%@ page import="Parking.ConnectDB" %>
	<% ConnectDB dbconnect = new ConnectDB();
		String full_name = request.getParameter("name");
		String npm = request.getParameter("id");
		String role = request.getParameter("role");
		String username = request.getParameter("uname");
		String password = request.getParameter("pword");
		
		if(!(full_name.equals("") || role.equals("") || npm.equals("") || username.equals("") ||
				password.equals(""))){
			boolean bool = dbconnect.insertData(npm, username, password, full_name, role);
			if(bool){
				session.setAttribute("username", username);
				boolean isadmin = dbconnect.isadmin(username);
				if(!isadmin){
					session.setAttribute("loginstatus", "yes");
					response.sendRedirect("home.jsp");
				} else {
					session.setAttribute("adminstatus", "yes");
					response.sendRedirect("adminhome.jsp");
				}
			} else{
				session.setAttribute("loginstatus", "fail");	
				response.sendRedirect("index.jsp");
			}
		} else{
			System.out.println("Incorrect Input. Please try again!");
			response.sendRedirect("index.jsp");
		}
		
		
	%>
<a>Test</a>
</body>
</html>