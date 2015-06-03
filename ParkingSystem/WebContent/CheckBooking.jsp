<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
		
		
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Check Booking</title>
</head>
<body>
<%@ page import="Parking.ConnectDB" %>
<%@ page import="Parking.ParkingSpace" %>
<%@ page import="Parking.ParkingLot" %>
<%@ page import="Parking.MainProgram" %>

<% ConnectDB db = new ConnectDB(); 

	String bookingnumber = request.getParameter("spotnumber");
	String username = (String) session.getAttribute("username");

 	if (!(bookingnumber.equals(""))){
			boolean hasuser = db.hasusername(username);
		if (hasuser == false){
				int booking = Integer.parseInt(bookingnumber);
				int stat = db.checkstatus(booking);
			 	if (stat == 0){
					System.out.println("You have successfully booked in!");
					db.updatelot(booking, 2, username);
				}
				else{
					System.out.println("Sorry that spot is taken!");
				}
		}
		else{
			System.out.println("Sorry you have already booked a place!");
		}
/* 				System.out.println("You cannot leave this empty."); */
	}
	response.sendRedirect("home.jsp");
	%>
	
</body>
</html>