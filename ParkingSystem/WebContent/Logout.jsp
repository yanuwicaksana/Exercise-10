<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log out</title>
</head>
<body>
	<%@ page import="Parking.ParkingSpace" %>
	<%@ page import="Parking.ParkingLot" %>
	<%@ page import="Parking.MainProgram" %>
	<%
		if(session.getAttribute("loginstatus") == "yes"){
			session.setAttribute("loginstatus", null);
			
		} else if(session.getAttribute("adminstatus") == "yes"){
			session.setAttribute("adminstatus", null);
		} else if(session.getAttribute("gueststatus") == "yes"){
			session.setAttribute("gueststatus", null);
		}
		session.setAttribute("username", null);
		response.sendRedirect("index.jsp");
	%>
</body>
</html>