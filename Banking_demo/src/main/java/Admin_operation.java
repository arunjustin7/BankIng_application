

import java.io.IOException;
import java.sql.*;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Bank.Dbconnection;

/**
 * Servlet implementation class Admin_operation
 */
@WebServlet("/Admin_op")
public class Admin_operation extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_operation() {
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
try {
	Connection con=Dbconnection.connect_data();
	 PreparedStatement ps=con.prepareStatement("insert into customer values(?,?,?,?,?,?,?,?,?,?)");
	 Random random = new Random();

	 int rand = random.nextInt(10000000,999999999);
	 ps.setInt(1, rand);
	 ps.setString(2, "123");
	 ps.setString(3, request.getParameter("full-name"));
	 ps.setString(4, request.getParameter("address"));
	 ps.setLong(5, Long.parseLong(request.getParameter("mobile")));
	 ps.setString(6, request.getParameter("email"));
	 ps.setString(7, request.getParameter("acc_type"));
	 ps.setLong(8, Long.parseLong(request.getParameter("balance")));
	 ps.setString(9, request.getParameter("dob"));
	 ps.setLong(10, Long.parseLong(request.getParameter("id-proof")));
	 ps.executeUpdate();
	 response.sendRedirect("Admin.jsp");
//	 Statement st = miConexion.createStatement();
//     st.executeUpdate(Query);
//	System.out.print(Long.parseLong("9344518268"));

	
}
catch (Exception e) {
	System.out.print(e);
}
	}

}
