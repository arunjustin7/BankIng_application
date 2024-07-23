<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Bank.*,java.sql.*,javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background-color: #3498db;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .dashboard {
            background-color: white;
            border-radius: 5px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .balance {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .button {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
        }

        .transactions {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 5px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        /* Styling for the dialog */
        .dialog-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .dialog-box {
            position: fixed;
            background-color: white;
            width: 300px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1010;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1200px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        th,
        td {
            padding: 20px;
            text-align: left;
            border-bottom: 2px solid #ddd;
            font-size: 1.1em;
        }

        th {
            background-color: #6e8efb;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tr:hover {
            background-color: #f5f5f5;
            transform: scale(1.02);
            transition: all 0.3s ease;
        }

        .status {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
        }

        .completed {
            background-color: #4CAF50;
            color: white;
        }

        .pending {
            background-color: #FFC107;
            color: black;
        }

        .failed {
            background-color: #F44336;
            color: white;
        }
    </style>
</head>

<body>
<%
try{
    HttpSession s=request.getSession();

    Connection con=Dbconnection.connect_data();
    PreparedStatement ps=con.prepareStatement("select * from customer where acc_no=? and password=?");


     ps.setLong(1, (Long)s.getAttribute("customer"));
     ps.setString(2,(String) s.getAttribute("cus_password"));

     ResultSet val=ps.executeQuery();
     int i=0;
     if( val.next()){
         s.setAttribute("user_name", val.getString(3));
    	 s.setAttribute("cus_data", val);
         s.setAttribute("cus_bal", val.getLong(8));
         i=i+1;
    	 
     }
  
     else{
    	 
         System.out.print("error in val retrieving customer data ");
         
     }
   

    
}catch(Exception e){
    System.out.print(e);
}

%>
    <div class="container">
        <div class="header">
        ${sessionScope.cus_data.getString(3)}
           
        </div>
        <div class="dashboard">
            <div class="balance">Balance: Rs <span id="balance">${sessionScope.cus_data.getLong(8)}</span></div>
            <button class="button" id="openDialog">Deposit</button>
            <button class="button" id="openDialog1">Withdraw</button>
            <button class="button" id="openDialog2">Change password</button>
               
            <form action="customer_cv" method="post">
            <button class="button" type="submit" id="openDialog2"> Close</button></form>
            <Form action="Login.jsp">
        <button  class="button" type="submit" >Logout</button>
</Form>
            
            <button class="button" onclick="generatePDF()">Print Transactions</button>
            
            
            <div class="dialog-overlay" id="dialogOverlay">
                <div class="dialog-box">
                    <form action="customer_op" method="get">
                        <p>Enter amount to be deposited:</p>
                        <input type="text" name="deposit">
                        <br><br>
                        <button type="submit" id="submitValue">Submit</button>
                    </form>
                </div>
            </div>

            <div class="dialog-overlay" id="dialogOverlay1">
                <div class="dialog-box">
                    <form action="customer_op" method="post">
                        <p>Enter amount to withdraw:</p>
                        <input type="text" name="withdraw">
                        <br><br>
                        <button type="submit" id="submitValue1">Submit</button>
                    </form>
                </div>
            </div>
            <div class="dialog-overlay" id="dialogOverlay2">
                <div class="dialog-box">
                    <form action="customer_pass" method="post">
                        <p>Enter the new password:</p>
                        <input type="text" name="c_pass">
                        <br><br>
                        <button type="submit" id="submitValue2">Submit</button>
                    </form>
                </div>
            </div>

            <table id="transactionTable">
                <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                  <%
                
                try {
                	 Connection con=Dbconnection.connect_data();
                	 PreparedStatement ps=con.prepareStatement("select * from transaction where acc_no=? ORDER BY dob DESC LIMIT 10");

                	    HttpSession s=request.getSession();

                	    ps.setLong(1, (Long) s.getAttribute("customer"));
                	   
                	   ResultSet val1=ps.executeQuery();
                	    
                    

                    while (val1.next()){
                        out.println("<tr>");
                        out.println("<td>" + val1.getLong(1) + "</td>");
                       out.println("<td>" + val1.getString(2) + "</td>");
                        out.println("<td>" + val1.getLong(3) + "</td>");
                        out.println("<td>" + val1.getString(4) + "</td>");
                        out.println("<td>" + val1.getDate(5) + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } 
            %>
                    <!-- Data will be populated here by JavaScript -->
                </tbody>
            </table>
        </div>
    </div>
<%

%>
    <script>
        const openDialogButton = document.getElementById('openDialog');
        const dialogOverlay = document.getElementById('dialogOverlay');
        const submitButton = document.getElementById('submitValue');

        openDialogButton.addEventListener('click', function() {
            dialogOverlay.style.display = 'block';
        });

        submitButton.addEventListener('click', function() {
            dialogOverlay.style.display = 'none';
        });

        const openDialogButton1 = document.getElementById('openDialog1');
        const dialogOverlay1 = document.getElementById('dialogOverlay1');
        const submitButton1 = document.getElementById('submitValue1');

        openDialogButton1.addEventListener('click', function() {
            dialogOverlay1.style.display = 'block';
        });

        submitButton1.addEventListener('click', function() {
            dialogOverlay1.style.display = 'none';
        });
        const openDialogButton2 = document.getElementById('openDialog2');
        const dialogOverlay2 = document.getElementById('dialogOverlay2');
        const submitButton2 = document.getElementById('submitValue2');

        openDialogButton2.addEventListener('click', function() {
            dialogOverlay2.style.display = 'block';
        });

        submitButton2.addEventListener('click', function() {
            dialogOverlay2.style.display = 'none';
        });
        function generatePDF() {
            var { jsPDF } = window.jspdf;
            var doc = new jsPDF();

            var userName = "<%= session.getAttribute("user_name") %>";
            var columns = ["Account_Number",  "Transaction Type", "Transaction Amount","Status", "Transaction Date"];
            var rows = [];

            <% 
            
                try {
                	Connection con=Dbconnection.connect_data();
                	
                	PreparedStatement ps=con.prepareStatement("select * from transaction where acc_no=? ORDER BY dob DESC LIMIT 10");

             	    HttpSession s=request.getSession();

             	    ps.setLong(1, (Long) s.getAttribute("customer"));
                    ResultSet rs = ps.executeQuery();
                    
                    while (rs.next()) {
            %>
            rows.push(["<%= rs.getLong(1) %>", "<%= rs.getString(2) %>", "<%= rs.getLong(3) %>" ,"<%= rs.getString(4) %>", "<%= rs.getDate(5)  %>"]);
            <% 
                    }
                    
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            doc.text("Account Holder: " + userName, 14, 16);
            doc.autoTable({
                head: [columns],
                body: rows,
                startY: 20,
            });

            doc.save(userName +"_Transaction_History.pdf");
        }
       
    </script>

</body>

</html>
