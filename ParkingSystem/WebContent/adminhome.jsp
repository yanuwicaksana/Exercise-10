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
	    function changecolor(id){
			var y = document.getElementById(id);
			y.style.backgroundColor = "red";
		}
		
		function changebookcolor(id){
			var b = document.getElementById(id);
			b.style.backgroundColor = '#65C6BB';
		}
	</script>
</head>

<body>
	<%@ page import="Parking.ParkingSpace" %>
	<%@ page import="Parking.ParkingLot" %>
	<%@ page import="Parking.MainProgram" %>
	<%@ page import="Parking.ConnectDB" %>
	<%@ page import="Parking.ParkingMap" %>
	<% 
		if(session.getAttribute("loginstatus") == "yes"){
			response.sendRedirect("home.jsp");
		} else if(session.getAttribute("gueststatus") == "yes"){
			response.sendRedirect("homeGuest.jsp");
		} else if(session.getAttribute("adminstatus") == null){
			response.sendRedirect("index.jsp");
		} 
	%>
	<%
		ConnectDB db = new ConnectDB();
		ParkingLot lot = new ParkingLot();
		LinkedList param = new LinkedList();
		LinkedList book = new LinkedList();
		//MainProgram.InitParkingSpace(lot);
		String username = (String) session.getAttribute("username");
		for (int i = 0; i < 30; i++){
			ParkingSpace space = new ParkingSpace(i+1);
			int status = db.checkstatus(i+1);
			//System.out.println(status);
			if(status == 1){
				space.setAvailability(false);
				param.add("space" + (i+1));
				//System.out.println("test");
			} else if(status == 2){
				book.add("space" + (i+1));
				}
			lot.addParkingSpace(space);
		}
		lot.checkavailable();
		int length = param.size();
		int booklength = book.size();
	%>
	<div id = "top">
		<img src = "carlogo.png" alt = "csuiparkingsystemlogo">
		<h1> CSUI PARKING SYSTEM </h1>
		<h3>- ADMIN VIEW -</h3><br />
	</div>
	
	<div id = "nav">
		
		<div class = "col-xs-15">
			<a class = "parkspot" href = "#"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-home fa-lg"></i></button></a>
			<span id="parkspottext">Home</span>
		</div>
		<div class = "col-xs-15">
			<a class = "guestregist" href = "#" onclick="toggle_visibility('guestregistmenu')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-user-plus fa-lg"></i></button></a>
			<span id="guestregisttext">Register Guest</span>
		</div>
		<div class = "col-xs-15">
			<a class = "viewguest" href = "#" onclick = "toggle_visibility('viewguestmenu')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-user fa-lg"></i></button></a>
			<span id="viewguesttext">View Guests</span>
		</div>
		<div class = "col-xs-15">
			<a class = "viewmember" href = "#" onclick = "toggle_visibility('viewmembermenu')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-list-alt fa-lg"></i></button></a>
			<span id="viewmembertext">View Members</span>
		</div>
		<div class = "col-xs-15">
			<form name="logout" method="post" action="Logout.jsp">
			<a class = "signout" href ="index.jsp"><button class = "btn btn-default btn-circle btn-lg" type="submit" value="Submit"><i class ="fa fa-arrow-circle-left fa-lg"></i></button></a>
			<span id="signouttext">Log Out</span>
			</form>
		</div>
		
	</div>
	<br /><br /><br />

	<div id = "guestregistmenu">	
		<h2>Register Guest</h2>
		<form name = "guestregisterform" method = "post" action="GuestRegister.jsp">
			<p>Guest Name <input type = "text" name = "guestname"></p>
			<p>Phone Number <input type = "text" name = "phonenumber"></p>
			<button type="submit" value="Submit" class="btn btn-submit">Submit</button>
		</form>
	</div>
	<br/><br/>
	
	<div id = "viewguestmenu">	
		<h2>List of Guests</h2>
		<br>
		<table id="guesttable">
			<tr>
				<td>No</td>
				<td>Name</td>
				<td>Phone Number</td>
			</tr>
		</table>
	</div>
	<br/><br/>
	
	<div id = "viewmembermenu">	
		<h2>List of Members</h2>
		<br>
		<table id="membertable">
			<tr>
				<td>No</td>
				<td>Name</td>
				<td>Identification Number</td>
				<td>Username</td>
			</tr>
		</table>
	</div>
	
	<div id = "parkspotmenu">
	<div id = "map" style="display:block;">
		<h2>Parking Map</h2><br/>
		<div id = "tables">
		<table id = "mapmenu">
			<tr id = "row1">
				<td id = "space1">Space1</td>
				<td id = "space2">Space2</td>
				<td id = "space3">Space3</td>
				<td id = "space4">Space4</td>
				<td id = "space5">Space5</td>
				<td id = "space6">Space6</td>
				<td id = "space7">Space7</td>
				<td id = "space8">Space8</td>
				<td id = "space9">Space9</td>
				<td id = "space10">Space10</td>
			</tr>
			<tr id = "row2">
				<td id = "space11">Space11</td>
				<td id = "space12">Space12</td>
				<td id = "space13">Space13</td>
				<td id = "space14">Space14</td>
				<td id = "space15">Space15</td>
				<td id = "space16">Space16</td>
				<td id = "space17">Space17</td>
				<td id = "space18">Space18</td>
				<td id = "space19">Space19</td>
				<td id = "space20">Space20</td>
			</tr>
			<tr id = "row3">
				<td id = "space21">Space21</td>
				<td id = "space22">Space22</td>
				<td id = "space23">Space23</td>
				<td id = "space24">Space24</td>
				<td id = "space25">Space25</td>
				<td id = "space26">Space26</td>
				<td id = "space27">Space27</td>
				<td id = "space28">Space28</td>
				<td id = "space29">Space29</td>
				<td id = "space30">Space30</td>
			</tr>
		</table>
		</div>
	</div>
	</div>
	
	<br /><br />
	<script type="text/javascript">
		<% 
		for (int i = 0; i<length; i++){
			String space = (String) param.get(i);
		%>		
		changecolor('<%=space%>');
		<%		}%>
		
		<%
		for (int j = 0; j<booklength; j++){
			String bookspace = (String) book.get(j);
		%>
		changebookcolor('<%=bookspace%>');
		<% } %>
		
		<%
		LinkedList guestlist = db.getguest();
		//System.out.println(guestlist.size());
		for(int i = 0; i<guestlist.size(); i++){
			String guest = (String) guestlist.get(i);
			//System.out.println(guest);
			String[] guestrow = guest.split(",");
	%>
			var tr= document.createElement('tr');
			var no= document.createElement('td');
			no.appendChild(document.createTextNode('<%=i+1%>'));
			tr.appendChild(no);
	<%
			for(int j = 0; j<2; j++){
				String text = guestrow[j];
				//System.out.println(text);
	%>
				var td = document.createElement('td');
				td.appendChild(document.createTextNode('<%=text%>'));
				tr.appendChild(td);
		<%	}%>
			document.getElementById("guesttable").appendChild(tr);
	<% 		
		}%>
		
		<%
		LinkedList memberlist = db.getmember();
		//System.out.println(memberlist.size());
		for(int i = 0; i<memberlist.size(); i++){
			String member = (String) memberlist.get(i);
			//System.out.println(member);
			String[] memberrow = member.split(",");
	%>
			var tr= document.createElement('tr');
			var no= document.createElement('td');
			no.appendChild(document.createTextNode('<%=i+1%>'));
			tr.appendChild(no);
	<%
			for(int j = 0; j<3; j++){
				String text = memberrow[j];
				//System.out.println(text);
	%>
				var td = document.createElement('td');
				td.appendChild(document.createTextNode('<%=text%>'));
				tr.appendChild(td);
		<%	}%>
			document.getElementById("membertable").appendChild(tr);
	<% 		
		}%>
		
		
	</script>
	<footer id = "below" class="col-md-12">
		<p>Copyright 2015. A project by Group 2 for Advanced Programming assignment.</p>
		<p>Created by Tsabita Vera Cyavrilla, Yanuar Wicaksana, Hakeem Radiansyah Daud, Abicantya Prasidya Sophie, Yohana Fransiska Kanisia Hadiati.</p>
	</footer>
</body>