
# Banking System 🏦

This project is a simple banking application built using Java, JSP, and MySQL. It allows customers to manage their bank accounts and perform basic transactions such as deposits and withdrawals. Admins can register and manage customer details.


## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Setup](#setup)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [License](#license)

## Features

### Admin Roles
- Admin login with username and password
- Register a customer with details: Full name, Address, Mobile No, Email id, Type of account, Initial Balance, Date of Birth, Id proof
- Add/Delete/Modify/View customer details (password and balance not visible to admin)
- Generate account number and temporary password for new customers

## Customer Roles
- Customer registration by admin
- Setup new password using account number and temporary password
- Customer login/logout
- View account details and balance
- View last 10 transactions
- Deposit and withdraw money
- Maintain account balance (cannot go below 0)
- Close account (withdraw all money before closing)
- Download a PDF of the last 10 transactions

## Bonus Functionality


- Print mini statements
## Technologies Used

- **Eclipse IDE**
- **Tomcat 9 Server**
- **MySQL Server**
- **MySQL Workbench**
- **Java**
- **JSP (JavaServer Pages)**
- **Servlets**

## Setup

1. **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/banking-application.git
    ```

2. **Import the project into Eclipse IDE:**
    - Open Eclipse IDE
    - File -> Import -> Existing Maven Projects -> Select the cloned repository

3. **Set up MySQL Database:**
    - Open MySQL Workbench
    - Create a new database called `banking`
    - Import the SQL script from the `database` directory to set up the tables

4. **Configure Tomcat Server:**
    - Download and install Tomcat 9
    - In Eclipse, go to Servers view, right-click -> New -> Server -> Apache -> Tomcat v9.0 Server
    - Add your project to the server

5. **Update Database Connection Details:**
    - Open `Dbconnection.java` in `com.Bank` package
    - Update the database URL, username, and password as per your MySQL configuration

6. **Run the Project:**
    - Right-click on the project -> Run As -> Run on Server
    - Open a web browser and go to `http://localhost:8080/banking-application`

## Usage

### Admin
1. **Login:**
    - Navigate to the admin login page and enter credentials
2. **Register Customer:**
    - Fill in the customer details and submit to generate an account number and temporary password
3. **Manage Customers:**
    - Add, delete, modify, and view customer details (password and balance not visible)

### Customer
1. **Setup New Password:**
    - Use account number and temporary password to set up a new password
2. **Login:**
    - Enter account number and password to log in
3. **View Account Details:**
    - See account balance and last 10 transactions
4. **Deposit/Withdraw Money:**
    - Enter the amount to deposit or withdraw
5. **Close Account:**
    - Withdraw all money and close the account
6. **Download Mini Statement:**
    - Download a PDF of the last 10 transactions
## Project Structure

- `src/`: Contains all the source code for the application.
  - `main/`: Contains the main application code.
    - `java/`: Contains the Java source files.
      - `com/Bank/`: Package for the bank application.
        - `Dbconnection.java`: Handles the database connection.
        - `Customer_op_Servlet.java`: Servlet for customer operations.
        - `...`: Other Java files related to the application.
    - `webapp/`: Contains the web application files.
      - `customer.jsp`: JSP file for customer interface.
      - `admin.jsp`: JSP file for admin interface.
      - `...`: Other JSP and web files.
  - `test/`: Contains the test cases and files.
    - `...`: Test files for the application.
- `database/`: Contains the database files.
  - `banking.sql`: SQL file to set up the database schema.
- `pom.xml`: Maven configuration file.
- `README.md`: This README file.
