

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Bank.Dbconnection;

/**
 * Servlet implementation class Customer_view_close
 */
@WebServlet("/customer_cv")
public class Customer_view_close extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Customer_view_close() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.print("hellodsvsjd");
		try {
			HttpSession s=request.getSession();
			System.out.print(s.getAttribute("cus_bal"));
			if((long) s.getAttribute("cus_bal") ==0 ) {
				Connection con=Dbconnection.connect_data();
				PreparedStatement ps=con.prepareStatement("delete from customer where acc_no=?");
				
				ps.setLong(1, (long) s.getAttribute("customer") );
				

				ps.executeUpdate();
				s.invalidate();
				response.sendRedirect("Login.jsp");
				
			}else {
				response.sendRedirect("customer.jsp");
				
				
				
			}
			
			
			
			
		}
		catch(Exception e) {
			System.out.print(e);
		}
		
	}

}
