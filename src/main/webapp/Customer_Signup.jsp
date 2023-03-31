<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspData.Data"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.print.DocFlavor" %>
<%@ page import= "java.text.DateFormat"%>
<%@ page import= "java.util.Calendar"%>
<%@ page import="javax.swing.plaf.nimbus.State" %>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>
    <style>
      .button-container {
        position: fixed;
        top: 10px;
        right: 10px;
        z-index: 9999;
      }
      .my-button {
        display: inline-block;
        padding: 10px;
        background-color: darkgray;
        font-size: 16px;
        border: none;
        cursor: pointer;
        border-radius: 5px;
      }
    </style>
  </head>
  <body>
    <%
      String url = "jdbc:postgresql://localhost:5432/Groupproject";
      Class.forName("org.postgresql.Driver");
      Connection db = DriverManager.getConnection(url, "postgres", "1234");
    %>
    <div class = "button-container">
      <button class="my-button" onclick="location.href='index.jsp'">Home Page</button>
    </div>
    <h1>SIGN UP</h1>
    <form method = "POST" action="Customer_Signup.jsp">
      <input type="text" name="lname" placeholder="Last Name" />
      </br>
      <input type="text" name="fname" placeholder="First Name" />
      </br>
      <input type="text" name="email" placeholder="Email" />
      </br>
      <input type="text" name="address" placeholder="Address" />
      </br>
      <input type="text" name="sin" placeholder="SIN" />
      </br>
      <button onclick="<%
      if (request.getParameter("lname") != null && request.getParameter("fname") != null && request.getParameter("email") != null && request.getParameter("address") != null && request.getParameter("sin") != null){
            String lname = request.getParameter("lname");
            String fname = request.getParameter("fname");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String sin = request.getParameter("sin");
            Data.addCustomer(sin, lname, fname, email, address);
        }%>" >Register</button>
    </form>
    <button type="button" onclick="location.href='Customer_Room_Search.jsp';">
      Book a room!
    </button>
  </body>
</html>
