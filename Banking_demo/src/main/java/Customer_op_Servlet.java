

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.*;

import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Bank.Dbconnection;
import com.mysql.cj.Session;

/**
 * Servlet implementation class Customer_op_Servlet
 */
@WebServlet("/customer_op")
public class Customer_op_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
       
    /**
     * @throws IOException 
     * @throws ServletException 
     * @see HttpServlet#HttpServlet()
     */
	
    public Customer_op_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.print(request.getParameter("deposit"));
		
		try {
			con=Dbconnection.connect_data();
			PrintWriter out=response.getWriter();
			HttpSession s=request.getSession();
			System.out.print(request.getParameter("deposit"));
			
			if(Long.parseLong(request.getParameter("deposit")) <0 ) {
				
			
				 RequestDispatcher dis=request.getRequestDispatcher("customer.jsp");
  				 dis.forward(request, response);				   
				   
			}else {
			PreparedStatement ps=con.prepareStatement("update customer set balance=balance+? where acc_no=?");
			ps.setLong(1, Long.parseLong(request.getParameter("deposit")));
			ps.setLong(2, (long) s.getAttribute("customer") );

			ps.executeUpdate();				
			ps=con.prepareStatement("insert into transaction values(?,?,?,?,?)");
			ps.setLong(1, (long) s.getAttribute("customer"));
			ps.setString(2, "deposit");
			ps.setLong(3, Long.parseLong(request.getParameter("deposit")));
			ps.setString(4, "success");
			long millis=System.currentTimeMillis();  
	        java.sql.Date date=new java.sql.Date(millis);  
			
			ps.setDate(5, date);

			ps.executeUpdate();			
			System.out.print(s.getAttribute("cus_bal"));}
			response.sendRedirect("customer.jsp");
			
			
		}
		catch(Exception e) {
			System.out.print(e);
		}
		

		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			con=Dbconnection.connect_data();
			PrintWriter out=response.getWriter();
			HttpSession s=request.getSession();
			System.out.print(request.getParameter("withdraw"));
			
			if(Long.parseLong(request.getParameter("withdraw")) > (long) s.getAttribute("cus_bal")) {
				
			
				 RequestDispatcher dis=request.getRequestDispatcher("customer.jsp");
  				 dis.forward(request, response);				   
				   
			}else {
			PreparedStatement ps=con.prepareStatement("update customer set balance=balance-? where acc_no=?");
			ps.setLong(1, Long.parseLong(request.getParameter("withdraw")));
			ps.setLong(2, (long) s.getAttribute("customer") );

			ps.executeUpdate();	
			ps=con.prepareStatement("insert into transaction values(?,?,?,?,?)");
			ps.setLong(1, (long) s.getAttribute("customer"));
			ps.setString(2, "Withdraw");
			ps.setLong(3, Long.parseLong(request.getParameter("withdraw")));
			ps.setString(4, "success");
			long millis=System.currentTimeMillis();  
	        java.sql.Date date=new java.sql.Date(millis);  
			
			ps.setDate(5, date);

			ps.executeUpdate();		
			System.out.print(s.getAttribute("cus_bal"));}
			response.sendRedirect("customer.jsp");
			
			
		}
		catch(Exception e) {
			System.out.print(e);
		}
		
		
		
	}
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.print(request.getParameter("param"));
		System.out.print("hello this is deposit");
	
	}
	


}
