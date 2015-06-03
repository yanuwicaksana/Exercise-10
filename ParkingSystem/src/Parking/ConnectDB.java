package Parking;


import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class ConnectDB {
	private Connection con;
	private Statement st;
	private ResultSet rs;
		
	public ConnectDB() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parking","root","");
			st  = con.createStatement();
			
		} catch(Exception ex) {
			System.out.println("Error: "+ex);
		}
	}
	
	
	public LinkedList getmember(){
    	LinkedList list = new LinkedList();
    	try{
    		String sql = "select * from member";
    		rs = st.executeQuery(sql);
    		//rs.next();
    		
    		while(rs.next()){
    			String name = rs.getString("full_name");
    			String npm = rs.getString("npm");
    			String username = rs.getString("username");
    			list.add(name + "," + npm + "," + username);
    		}
    		return list;
    	} catch(Exception ex){
    		System.out.println(ex);
    		return null;
    	}
    	
    }
	
	
	public boolean insertData(String npm, String username, String password, String full_name, String role) {
		try {
	    	String checkSql = "Select count(*) from member where username = '"+username+"'";
	    	rs = st.executeQuery(checkSql);
	    	rs.next();
	    	if ( rs.getInt(1) == 0) {
	    		String query = "Insert into Member(npm,username,password,full_name, role) "+
					       "values('"+npm+"','"+username+"','"+password+"','"+full_name+"','"+role+"')";						
	    		st.executeUpdate(query);
	    		System.out.println(username+" is inserted into the Database!");
	    		System.out.println("Congratulations, you're now member of CSUI parking privileges, " + username + "!\n");
	    		return true;
	    	} else {
	    		System.out.println(username+ " already exists! Please choose another one.");
	    		return false;
	    	}
	    } catch(Exception ex) {
	    	System.out.println(ex);
	    	return false;
	    }

	}
		
	
	public void checkMember(String username)
	{
	    try {
	    	String checkSql = "Select count(*) from member where username = '"+username+"'";
	    	rs = st.executeQuery(checkSql);
	    	rs.next();
	    	if ( rs.getInt(1) == 0) {
	    	  System.out.println(username+" doesn't exist");
	    	} else {
	    	  System.out.println(username+ " exist");
	    	}
	    } catch(Exception ex) {
	    	System.out.println(ex);
	    }
	}
	    
	    public boolean checklogin(String username, String password){
	    	try {
		    	String checkSql = "select * from member where username = '"+username+"' and password = '"+password+"'";
		    	rs = st.executeQuery(checkSql);
		    	
		    	rs.next();
		    	System.out.println(rs.getString("username"));
		    	//System.out.println(rs.getString(1));
		    	if ( rs.getInt(1) == 0) {
		    	  System.out.println("Username or Password incorrect. Please try again.");
		    	  return false;
		    	} else {
		    	  System.out.println(username+ " is logged in.");
		    	  return true;
		    	}
		    } catch(Exception ex) {
		    	System.out.println(ex);
		    	return false;
		    }   
		}
	    
	    public int checkstatus(int id){
	    	try{
	    		String sql = "select * from lot where id = '"+id+"'";
	    		rs = st.executeQuery(sql);
	    		rs.next();
	    		
	    		return rs.getInt("status");
	    		
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return -1;
	    	}
	    }
	    
	    public void updatelot(int id, int status, String username){
	    	try{
	    		String sql = "update lot set status = '"+status+"', user = '"+username+"' where id = '"+id+"'";
	    		st.executeUpdate(sql);
	    		System.out.println("DB updated!");
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    	}
	    }
	    
	    public String checkusername(int id){
	    	try{
	    		String sql = "select * from lot where id = '"+id+"'";
	    		rs = st.executeQuery(sql);
	    		rs.next();
	    		
	    		return rs.getString("username");
	    		
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return null;
	    	}
	    }
	    
	    public boolean hasusername(String username){
	    	try{
	    		String sql = "select count(*) from lot where user = '"+username+"'";
	    		rs = st.executeQuery(sql);
	    		rs.next();
	    		if(rs.getInt(1) == 1){
	    			return true;
	    		} else{
	    			return false;
	    		}
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return false;
	    	}
	    }
	    
	    public boolean checkGuest(String guest) {
		    try {
		    	String checkSql = "Select count(*) from guest where guest = '"+guest+"'";
		    	rs = st.executeQuery(checkSql);
		    	rs.next();
		    	if(rs.getInt(1) == 1){
	    			return true;
	    		} else{
	    			return false;
	    		}
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return false;
	    	}
		}
	    
	    public int getid(String username){
	    	try{
	    		String sql = "select * from lot where user = '"+username+"'";
	    		rs = st.executeQuery(sql);
	    		rs.next();
	    		int id = rs.getInt("id");
	    		return id;
	    		
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return -1;
	    	}
	    }
	    
	    public boolean isadmin(String username){
	    	try{
	    		String sql = "select * from member where username = '"+username+"'";
	    		rs = st.executeQuery(sql);
	    		rs.next();
	    		String role = rs.getString("role");
	    		if(role.equalsIgnoreCase("admin")) return true;
	    		else return false;
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return false;
	    	}
	    }
	    
	    public LinkedList getguest(){
	    	LinkedList list = new LinkedList();
	    	try{
	    		String sql = "select * from guest";
	    		rs = st.executeQuery(sql);
	    		//rs.next();
	    		
	    		while(rs.next()){
	    			String guest = rs.getString("guest");
	    			String phone = "0" + rs.getString("phone_number");
	    			list.add(guest + "," + phone);
	    		}
	    		return list;
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return null;
	    	}
	    	
	    }
	    
	    public boolean insertguest(String guest, String phone){
	    	try {
		    	String checkSql = "Select count(*) from guest where guest = '"+guest+"'";
		    	rs = st.executeQuery(checkSql);
		    	rs.next();
		    	if ( rs.getInt(1) == 0) {
		    		String query = "Insert into guest(guest,phone_number) "+
						       "values('"+guest+"','"+phone+"')";						
		    		st.executeUpdate(query);
		    		System.out.println(guest+" is inserted into the Database!");
		    		System.out.println("Congratulations, you're now member of CSUI parking privileges, " + guest + "!\n");
		    		return true;
		    	} else {
		    		System.out.println(guest+ " already exists! Please choose another one.");
		    		return false;
		    	}
		    } catch(Exception ex) {
		    	System.out.println(ex);
		    	return false;
		    }
	    }
	    
	    public boolean checkbook(String username){
	    	try{
	    		String sql = "select * from lot where status = 2";
	    		rs = st.executeQuery(sql);
	    		while(rs.next()){
	    			String user = rs.getString("user");
	    			if(user.equals(username)){
	    				return true;
	    			}
	    		}
	    		return false;
	    	} catch(Exception ex){
	    		System.out.println(ex);
	    		return false;
	    	}
	    }
}

