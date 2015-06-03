<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>CSUI Parking System</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name = "description" content="Web-based parking system for fasilkom UI">
	<meta name = "author" content="Tsabita Vera Cyavrilla, Yanuar Wicaksana, Hakeem Radiansyah Daud, Abicantya Prasidya Sophie, Yohana Fransiska Kanisia Hadiati">
	<link href = "bootstrap.min.css" rel = "stylesheet">
	<link href = "stylesheet.css" rel="stylesheet">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<script src = "bootstrap.min.js"></script>
	<script type="text/javascript">
	    function toggle_visibility(id) {
	       var e = document.getElementById(id);
	       if(e.style.display == 'block')
	          e.style.display = 'none';
	       else
	          e.style.display = 'block';
	    }
	</script>
</head>

<body>
	<%@ page import="Parking.ParkingSpace" %>
	<%@ page import="Parking.ParkingLot" %>
	<%@ page import="Parking.MainProgram" %>
	<%@ page import="Parking.ConnectDB" %>
	<%@ page import="Parking.ParkingMap" %>
	
	<div id = "top">
		<img src = "carlogo.png" alt = "csuiparkingsystemlogo">
		<h1> CSUI PARKING SYSTEM </h1>
	</div>
	<% if(session.getAttribute("loginstatus") == "yes"){
			response.sendRedirect("home.jsp");
	} else if(session.getAttribute("adminstatus") == "yes"){
			response.sendRedirect("adminhome.jsp");
	} else if(session.getAttribute("gueststatus") == "yes"){
			response.sendRedirect("homeGuest.jsp");
	}
	%>
	<div id = "welcomemenu">
		<div class = "col-md-6">
			<div id = "login">
				<h1><i class = "fa fa-car fa-lg"></i></h1>
				<h2 id ="logtitle">Login</h2>
				<form name = "login" method = "post" action="CheckLogIn.jsp">
					<p>Username <input type = "text" name = "username"></p>
					<p>Password <input type = "password" name = "password" length="8"></p>
					<button type="submit" value="Submit" class="btn btn-submit">Submit</button>
				</form>
			<br />
			<button class = "btn btn-primary" onclick = "toggle_visibility('guestlogin')">Log in as guest</button>
			</div>
		</div>
		
		<div class = "col-md-6">
			<div id = "register">
				<h1><i class = "fa fa-male fa-lg"></i> <i class = "fa fa-car fa-lg"></i></h1>
				<h2 id ="registertitle">Register</h2>
				<form name = "register" method = "post" action="CheckSignUp.jsp">
					<p>Name <input type = "text" name = "name"></p>
					<p>ID number <input type = "text" name = "id"></p>
					<p>Role <input type = "text" name = "role"></p>
					<p>Username <input type = "text" name = "uname"></p>
					<p>Password <input type = "password" name = "pword" maxlength="8"></p>
					<button type="submit" class="btn btn-submit">Submit</a></button>
				</form>
			</div>
		</div>
	</div>
	<br/><br/><br/>
	
	<div id = "guestlogin">	
		<h2>Guest Log-in</h2>
		<form name = "guestloginform" method = "post" action="GuestLogIn.jsp">
			<p>Guest Name <input type = "text" name = "guestname"></p>
			<p>Phone Number <input type = "text" name = "phonenumber"></p>
			<button type="submit" value="Submit" class="btn btn-submit">Submit</button>
		</form>
	</div>
	<br/><br/>
	
	<footer class = "below">
		<p>Copyright 2015. A project by Group 2 for Advanced Programming assignment.</p>
		<p>Created by Tsabita Vera Cyavrilla, Yanuar Wicaksana, Hakeem Radiansyah Daud, Abicantya Prasidya Sophie, Yohana Fransiska Kanisia Hadiati.</p>
	</footer>
</body>

</html>