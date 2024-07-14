<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="com.Bank.*,java.sql.*,javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
    <style>
        .hidden-info {
            color: #6c757d;
            font-style: italic;
        }
    </style>
</head>

<body>
    <div id="app" class="container mt-5 ">
    <%  	HttpSession s=request.getSession(); %>
        <h1 class="mb-4">admin:  ${sessionScope.admin}</h1>
        <Form action="admin_create.jsp">
        <button type="submit" class="btn  btn-primary">Add
                                Customer</button>
</Form>
<Form action="Login.jsp">
        <button type="submit" class="btn  btn-primary">Logout</button>
</Form>
        <div class="row">
          
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Customer List</h5>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Account No</th>
                                         <th>Name</th>
                                        <th>Address</th>
                                        <th>MobileNo</th>
                                        <th>email</th>
                                        <th>Date-of-birth</th>
                                          <th>Account type</th>
                                           <th>Update</th>
                                            <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                                    <%
                
                try {
                	 Connection con=Dbconnection.connect_data();
                	 PreparedStatement ps=con.prepareStatement("select * from customer ; ");

                	     
                	   //  ps.setLong(1, (Long)s.getAttribute("customer"));
                	   
                	   ResultSet val1=ps.executeQuery();
                	    
                    

                    while (val1.next()){
                        out.println("<tr>");
                        out.println("<td>" + val1.getLong(1) + "</td>");
                       out.println("<td>" + val1.getString(3) + "</td>");
                        out.println("<td>" + val1.getString(4) + "</td>");
                        out.println("<td>" + val1.getLong(5) + "</td>");
                        out.println("<td>" + val1.getString(6) + "</td>");
                        out.println("<td>" + val1.getDate(9) + "</td>");
                        out.println("<td>" + val1.getString(7) + "</td>");
                        out.println("<td>");
                        out.println("<a href='customer_ud?account="+val1.getLong(1) +"&val=u'>Update</a>");
                        out.println(" </td>");
                        out.println("<td>");
                        out.println("<a href='customer_ud?account="+ val1.getLong(1)+"&val=d'>delete</a>");
                        out.println(" </td>");
                        	 
                        
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } 
            %>
                                  
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
       
    </script>
</body>

</html>