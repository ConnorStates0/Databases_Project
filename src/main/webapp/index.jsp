<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspData.Data"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.print.DocFlavor" %>
<%@ page import= "java.text.DateFormat"%>
<%@ page import= "java.util.Calendar"%>
<%@ page import="javax.swing.plaf.nimbus.State" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Objects" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Welcome To The Hotel!</title>
  </head>
  <body>
    <%
      String url = "jdbc:postgresql://localhost:5432/Groupproject";
      Class.forName("org.postgresql.Driver");
      Connection db = DriverManager.getConnection(url, "postgres", "1234");
    %>
    <h1>HOTEL MANAGMENT SYSTEM</h1>
    <h2>I Am:</h2>
    <button type="button" onclick="location.href='Customer_Room_Search.jsp';">
      An Existing Customer
    </button>
    <button type="button" onclick="location.href='Customer_Signup.jsp';">
      A New Customer
    </button>
    <button type="button" onclick="location.href='Employee_Booking.jsp';">
      An Employee
    </button>
    <button type="button" onclick="location.href='Manager_Functionality.jsp';">
      A Manager
    </button>
    <table>
      <thead>
      <h2>Rooms Per Hotel</h2>
        <tr>
          <th>Contact Phone</th>
          <th>Number of Rooms</th>
        </tr>
      </thead>
      <tbody>
        <%Statement st = db.createStatement();
          ResultSet rs = st.executeQuery("SELECT * FROM hotel_rooms");
          while(rs.next()){%>
          <tr>
            <td><%= rs.getString("contact_phone")%></td>
            <td><%= rs.getString("num_rooms")%></td>
          </tr>
      <% } %>
      </tbody>
    </table>
    <table>
      <thead>
      <h2>Rooms Per City</h2>
      <tr>
        <th>City</th>
        <th>Number of Rooms</th>
      </tr>
      </thead>
      <tbody>
      <%ResultSet rs2 = st.executeQuery("SELECT * FROM room_by_city");
        while(rs2.next()){%>
      <tr>
        <td><%= rs2.getString("city")%></td>
        <td><%= rs2.getString("total_rooms")%></td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </body>
  <h5>
    Mustafa Ahmed 300242013| Ashvin Ramanathan 300242541| Connor States
    300254333
  </h5>
</html>
