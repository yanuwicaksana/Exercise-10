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
		if(session.getAttribute("adminstatus") == "yes"){
			response.sendRedirect("adminhome.jsp");
		} else if(session.getAttribute("gueststatus") == "yes"){
			response.sendRedirect("homeGuest.jsp");
		} else if(session.getAttribute("loginstatus") == null){
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
				param.add(Integer.toString((i+1)));
				//System.out.println("test");
			} else if(status == 2){
				book.add(Integer.toString((i+1)));
				}
			lot.addParkingSpace(space);
		}
		lot.checkavailable();
		int length = param.size();
		int booklength = book.size();
		ParkingMap map = new ParkingMap(lot);
		map.InitiateMap();
		//System.out.println(map.getdirection());
	%>
	<div id = "top">
		<img src = "carlogo.png" alt = "csuiparkingsystemlogo">
		<h1> CSUI PARKING SYSTEM </h1>
	</div>
	
	<div id = "nav">
		
		<div class = "col-xs-15">
			<a href ="home.jsp" class = "home"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-home fa-lg"></i></button></a>
			<span id="hometext">Home</span>
		</div>
		<div class = "col-xs-15">
			<a class = "checkin" href = "#" onclick="toggle_visibility('checkinmenu')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-map-marker fa-lg"></i></button></a>
			<span id="checkintext">Check-in/Check-out</span>
		</div>
		<div class = "col-xs-15">
			<a class = "booking" href = "#" onclick="toggle_visibility('bookingmenu')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-car fa-lg"></i></button></a>
			<span id="booktext">Booking</span>
		</div>
		<div class = "col-xs-15">
			<a class = "directions" href = "#" onclick = "toggle_visibility('map')"><button class = "btn btn-default btn-circle btn-lg"><i class ="fa fa-location-arrow fa-lg"></i></button></a>
			<span id="directtext">Show Directions</span>
		</div>
		<div class = "col-xs-15">
			<form name="logout" method="post" action="Logout.jsp">
			<a class = "signout" href ="index.jsp"><button class = "btn btn-default btn-circle btn-lg" type="submit" value="Submit"><i class ="fa fa-arrow-circle-left fa-lg"></i></button></a>
			<span id="signouttext">Log Out</span>
			</form>
		</div>
		
	</div>
	<br /><br /><br /><br /><br />
	
	<div id = "availability">
		<div class = "col-md-6 col-sm-height" id = "carsicons">
			<br />
			<h1 id ="carz"><i class = "fa fa-car"></i> <i class = "fa fa-cab"></i> <i class = "fa fa-bus"></i></h1>
		</div>
		<div class = "col-md-6 col-sm-height" id = "spots">
			<h2>Available Parking Spot</h2>
			<h1 id = "avanumber"><%=lot.getavailablespace() %></h1>
			<h4>Spots Available</h4>
		</div>
	</div>
	
	<div id = "checkinmenu">
		<div class = "col-md-6 col-sm-height" id ="gridone">
			<h2><i class = "fa fa-map-marker"></i> Check-in to parking slot</h2>
		</div>
		<div class = "col-md-6 col-sm-height" id = "gridtwo">
			
			<button class = "btn btn-success" onclick="toggle_visibility('specificspot')"><h3><i class = "fa fa-check"></i> CHECK IN</h3></button>
 			
 			<div id = "specificspot">
 			
 			<% if(request.getParameter("check-in") != null){
 				//System.out.println(request.getParameter("checkinspot"));
 				
 				int id = Integer.parseInt(request.getParameter("checkinspot"));
 				System.out.println(db.checkbook(username));
 				if ((db.checkbook(username))){
 					if (id == db.getid(username)){
 						System.out.println("Congratulations, you have signed in to your desired spot!");
 						db.updatelot(id, 1, username);
 					} else{
 						System.out.println("You cannot check in here!");
 					}
 				} else{
 					if(!db.hasusername(username)){
						if(db.checkstatus(id) == 0){
							lot.checkin(new ParkingSpace(id));
							db.updatelot(id, 1, username);
						} else{
							System.out.println("Spot already taken!");
						}
					}
				}
				response.sendRedirect("home.jsp");	
			}
					

			%>
	 			<form name = "form1" method = "post">
	 				<h3>Spot: <input type = "text" name = "checkinspot"></h3>
	 				<button class = "btn btn-success" onclick="CheckIn()"><h4><i class = "fa fa-check"></i> OK</h4></button>
	 				<input type ="hidden" name="check-in">
	 			</form>
 			</div>
 			
			<% if(request.getParameter("check-out") != null){
				if(db.hasusername(username)){
					int idout = db.getid(username);
					if(db.checkstatus(idout) == 1){
						db.updatelot(idout, 0, null);
						lot.checkout(new ParkingSpace(idout));
						//session.setAttribute("checkstatus", null);
						//session.setAttribute("checklot", null);
						
					} else{
						System.out.println("Check out not available!");
					}
					response.sendRedirect("home.jsp");
				}
			}
			%>
 			<form name = "form2" method = "post">
				<button class = "btn btn-danger" onclick="CheckOut()"><h3><i class = "fa fa-remove"></i> CHECK OUT</h3></button>
				<input type = "hidden" name = "check-out">
			</form>
		</div>
		<br /><br />
	</div>
	
	<br /><br />
	<div id = "bookingmenu">
		<div id = "bookspace">
			<h2>Book your parking spot!</h2>
			<form name = "bookparking" method = "post" action="CheckBooking.jsp">
					<p>Take this spot <input type = "text" name = "spotnumber"></p>
					<button type="submit" class="btn btn-submit">Submit</a></button>
			</form>
		</div>
	</div>
	
	<div id = "map" style="text-align:center;">
		<h2>Parking Map</h2><br/>
		<div id = "tables" class = "text-center">
		<table id = "mapmenu">
			<tr class = "text-center" id = "row1">
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
			<tr class = "text-center" id = "row2">
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
			<tr class = "text-center" id = "row3">
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
		<br /><br />
		<button id = "getdirbutton" class = "btn btn-info btn-lg" onclick="getdirection()">Direction to the nearest space</button>
		<br><br>
		<h3 id="Direction1"></h3>
		<h4 id="Direction2"></h4>
		<h5 id="Direction3"></h5>
		<h5 id="Direction4"></h5>
		
	</div>
	
	<br /><br />
	
<!-- 	***Second option to get direction*** -->
<!-- 	<div id = "getdirections" style="display:none;"> -->
<!-- 			<form name = "directionsform" method = "post"> -->
<!-- 				<h3>Where do you wanna go? Slot: <input type = "text" name = "directionspot"></h3> -->
<!-- 				<button class = "btn btn-success" onclick = "getdirection()"><h4><i class = "fa fa-check"></i> Go!</h4></button> -->
<!-- 				<h6 id="Direction1"></h6> -->
<!-- 				<h6 id="Direction2"></h6> -->
<!-- 			</form> -->
<!-- 	</div> -->
	
	<script type="text/javascript">
		function CheckIn(){
			document.form1.checkin.value = "check in"
			form1.submit()
		}
		
		function CheckOut(){
			document.form2.checkout.value = "check out"
			form2.submit()
		}
		function getdirection(){
			<%
				String direct = map.getdirection();
				String[] list = direct.split(" ");
				String row = list[0];
				String col = list[1];
				//int spaceid = Integer.parseInt(row+col);
				int spot = Integer.parseInt(row) * Integer.parseInt(col);
				String spotstr = Integer.toString(spot);
				while(book.contains(spotstr) || param.contains(spotstr)){
					spot += 1;
					row = Integer.toString((spot/10)+1);
					col = Integer.toString(spot%10);
					spotstr = Integer.toString(spot);
					if(spot > 30){
						spot = 0;
						row = "";
						col = "";
						break;
					}
				}
				
			%>
			
			document.getElementById("Direction1").innerHTML = "The nearest spot is Space " +<%=spot%>;
			document.getElementById("Direction2").innerHTML = "<br>HOW TO GET THERE? <br>";
			document.getElementById("Direction3").innerHTML = "Take the turn no. "+<%=row%>+" to the left <br>";
			document.getElementById("Direction4").innerHTML = "Straight ahead, the available space is the space no. " +<%=col%>+" <br>";
			
		}

		<% 
			for (int i = 0; i<length; i++){
				String space = (String) param.get(i);
				space = "space" + space;
		%>		
		changecolor('<%=space%>');
		<%		}%>
		<%
			for(int j = 0; j<booklength; j++){
				String bookspace = (String) book.get(j);
				bookspace = "space" + bookspace;
		%>
		changebookcolor('<%=bookspace%>');
		<%	
			}
		%>	

		
	</script>
	<footer id = "below" class="col-md-12">
		<p>Copyright 2015. A project by Group 2 for Advanced Programming assignment.</p>
		<p>Created by Tsabita Vera Cyavrilla, Yanuar Wicaksana, Hakeem Radiansyah Daud, Abicantya Prasidya Sophie, Yohana Fransiska Kanisia Hadiati.</p>
	</footer>
</body>