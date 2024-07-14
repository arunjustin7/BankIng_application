

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Bank.Dbconnection;

/**
 * Servlet implementation class customer_update_delete
 */
@WebServlet("/customer_ud")
public class customer_update_delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public customer_update_delete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.print("hello");
	
		try {
			if(request.getParameter("val").equals("d")) {
				System.out.print("delete");
				System.out.print(request.getParameter("account"));
				Connection con=Dbconnection.connect_data();
				PreparedStatement ps=con.prepareStatement("delete from  customer where  acc_no=?;");
			
				ps.setLong(1, Long.parseLong(request.getParameter("account")));

				ps.executeUpdate();		
				response.sendRedirect("Admin.jsp");
				
			}
			else {
				System.out.print("update");
				System.out.print(request.getParameter("account"));
				System.out.println("error");
				request.setAttribute("c_accountno", request.getParameter("account"));
				 RequestDispatcher dis=request.getRequestDispatcher("Customer_edit.jsp");
  				 dis.forward(request, response);
			}
			
		}
		catch(Exception e){
			System.out.print(e);
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.print("hello");
		try {
			 HttpSession s=request.getSession();
			 Connection con=Dbconnection.connect_data();
			 PreparedStatement ps=con.prepareStatement("update customer set  fullname=?,address=?,mobileno=?,email=?,acc_type=?,balance=?,dob=?,id=? where acc_no=?");
	

		
			
			 ps.setString(1, request.getParameter("full-name"));
			 ps.setString(2, request.getParameter("address"));
			 ps.setLong(3, Long.parseLong(request.getParameter("mobile")));
			 ps.setString(4, request.getParameter("email"));
			 ps.setString(5, request.getParameter("acc_type"));
			 ps.setLong(6, Long.parseLong(request.getParameter("balance")));
			 ps.setString(7, request.getParameter("dob"));
			 ps.setLong(8, Long.parseLong(request.getParameter("id-proof")));
			 ps.setLong(9, (long) s.getAttribute("current_cus"));
			 ps.executeUpdate();
			System.out.println("hree is code");
			System.out.println(s.getAttribute("current_cus"));
		}
		catch(Exception e){
			System.out.print(e);
			
		}
		
		response.sendRedirect("Admin.jsp");
	}

}
