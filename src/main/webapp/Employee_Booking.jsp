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
    <title>Employee Booking</title>
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
    <h1>EMPLOYEE BOOKINGS</h1>
    <form method="POST" action="Employee_Booking.jsp">
      <input type="text" name ="customerlast" placeholder="Customer Last Name">
      </br>
      <input type="text" name ="customeremail" placeholder="Customer Email">
      </br>
      <button onclick="<%
                ArrayList<String> info;
                String Address=null;
                String num_of_rooms=null;
                String ChainName=null;
                String CustomerSIN=null;
                if (request.getParameter("customerlast") != null && request.getParameter("customeremail") != null) {
                    String Lastname = request.getParameter("customerlast");
                    String email = request.getParameter("customeremail");
                    info = Data.searchBookings(Lastname,email);
                    Address = (String) session.getAttribute("Address");
                    if(Address == null){
                      Address = info.get(0);
                    }
                    num_of_rooms = (String) session.getAttribute("num_of_rooms");
                    if (num_of_rooms == null) {
                        num_of_rooms = info.get(1);
                    }
                    ChainName = (String) session.getAttribute("ChainName");
                    if (ChainName == null) {
                        ChainName = info.get(2);
                    }
                    CustomerSIN = (String) session.getAttribute("CustomerSIN");
                    if (CustomerSIN == null) {
                        CustomerSIN = info.get(3);
                    }
                }
                %>"; value="">Search for booking</button>
    </form>

    <div id="booking-out" name="booking-out" class="booking-out">
        <h2>Booking Info:</h2>
      <div id="booked-chain-out" name="booked-chain-out" class="booking-out">
        <label for="booked-chain">Chain: <%=ChainName%></label>
        <output id="booked-chain" name="booked-chain"></output>
      </div>

      <div
        id="booked-location-out"
        name="booked-location-out"
        class="booking-out"
      >
        <label for="booked-location">Location: <%=Address%></label>
        <output id="booked-location" name="booked-location"><output>
      </div>

      <div id="num-rooms-out" name="num-rooms-out" class="booking-out">
        <label for="num-rooms">Number of Rooms: <%=num_of_rooms%> </label>
        <output id="num-rooms" name="num-rooms"></output>
      </div>
    </div>

    <div id="Customer-Sin" name="Customer-Sin" class="booking-out">
      <label for="num-rooms">Customer SIN: <%=CustomerSIN%> </label>
      <output id="customersin" name="customersin"></output>
    </div>
    </div>

    <div name="customer-payment" id="customer-payment" class="customer-payment">
        <h2>Customer Payment:</h2>
        <form method="POST" action="Employee_Booking.jsp">
          <input type="text" name="sin" placeholder="SIN">
          </br>
          <input type="text" name="CardNum" placeholder="Credit Card Number">
          </br>
          <button onclick="<%
                if (request.getParameter("sin") != null && request.getParameter("CardNum") != null) {
                    String Sin = request.getParameter("sin");
                    String Card = request.getParameter("CardNum");
                    Data.approveBookings(Sin, Card);
                }
                %>">Approve Booking</button>
        </form>
    </div>

  </body>
</html>
