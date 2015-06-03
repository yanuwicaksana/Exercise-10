<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Guest Login</title>
</head>
<body>
	<%@ page import="Parking.ConnectDB" %>
	<%@ page import="Parking.ParkingSpace" %>
	<%@ page import="Parking.ParkingLot" %>
	<%@ page import="Parking.MainProgram" %>
	<% ConnectDB dbconnect = new ConnectDB();
		String username = request.getParameter("guestname");
		boolean valid = dbconnect.checkGuest(username);
		if(valid){ 
			session.setAttribute("gueststatus", "yes");
			session.setAttribute("username", request.getParameter("guestname"));
			
			response.sendRedirect("homeGuest.jsp");
			} else if(!valid) {
			session.setAttribute("loginstatus", "fail");
			response.sendRedirect("index.jsp");
			}%>
	<a>Test</a>
</body>
</html>