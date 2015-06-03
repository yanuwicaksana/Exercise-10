<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Login</title>
</head>
<body>
	<%@ page import="Parking.ConnectDB" %>
	<%@ page import="Parking.ParkingSpace" %>
	<%@ page import="Parking.ParkingLot" %>
	<%@ page import="Parking.MainProgram" %>
	<% ConnectDB dbconnect = new ConnectDB();
		//System.out.println(dbconnect);
		String username = request.getParameter("username");
		boolean valid = dbconnect.checklogin(username, request.getParameter("password")); 
		if(valid){ 
			boolean role = dbconnect.isadmin(username);
			session.setAttribute("username", username);
			//System.out.println(role);
			//session.setAttribute("loginstatus", "yes");
			//response.sendRedirect("home.jsp");
			//role.toLowerCase();
			
			if(role){
				session.setAttribute("adminstatus", "yes");
				response.sendRedirect("adminhome.jsp");
				return;
			} else{
				session.setAttribute("loginstatus", "yes");
				response.sendRedirect("home.jsp");
				return;
			}
		} else if(!valid) {
			session.setAttribute("loginstatus", "fail");
			response.sendRedirect("index.jsp");
			return;
		}%>
	
</body>
</html>