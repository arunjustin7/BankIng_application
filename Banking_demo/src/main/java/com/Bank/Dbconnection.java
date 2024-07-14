package com.Bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Dbconnection {
	public static Connection connect_data() {

	      String JdbcURL = "jdbc:mysql://localhost:3306/Banking";
	      String Username = "root";
	      String password = "12345";
	      Connection con = null;
	      try {
	    	 Class.forName("com.mysql.jdbc.Driver");
	    
	         con=DriverManager.getConnection(JdbcURL, Username, password);
	        
	         
	        
	      }
	      catch(Exception e) {
	    	  System.out.println("Error");
	         e.printStackTrace();
	      }
	      return con;
		
	}

}
