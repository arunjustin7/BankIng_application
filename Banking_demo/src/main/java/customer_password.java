

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
 * Servlet implementation class customer_password
 */
@WebServlet("/customer_pass")
public class customer_password extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public customer_password() {
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
		   System.out.println(request.getParameter("c_pass"));
		   try {
				 HttpSession s= request.getSession();
		   
			   Connection con=Dbconnection.connect_data();
				 PreparedStatement ps=con.prepareStatement("update  customer  set password= ? where acc_no=?");
				

			
				 ps.setString(1, request.getParameter("c_pass"));
				 ps.setLong(2, (long)s.getAttribute("customer"));
				 s.setAttribute("cus_password", request.getParameter("c_pass") );
				
				 ps.executeUpdate();
				 RequestDispatcher dis=request.getRequestDispatcher("customer.jsp");
  				 dis.forward(request, response);	
//				 Statement st = miConexion.createStatement();
//			     st.executeUpdate(Query);
//				System.out.print(Long.parseLong("9344518268"));

				
			}
			catch (Exception e) {
				System.out.print(e);

		   
	}

}
}
