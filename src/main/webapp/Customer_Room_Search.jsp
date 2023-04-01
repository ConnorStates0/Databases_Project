<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="com.jspData.Data"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.print.DocFlavor" %>
<%@ page import= "java.text.DateFormat"%>
<%@ page import= "java.util.Calendar"%>
<%@ page import="javax.swing.plaf.nimbus.State" %>
<%@ page import="java.util.ArrayList" %><%@ page import="java.util.Map" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Room Search</title>
    <style>
      ul {
        list-style-type: none;
        padding: 0px;
      }
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
    <h1>CUSTOMER ROOM SEARCH</h1>
    <form method="POST" action="Customer_Room_Search.jsp">
      <label>Check in: </label>
      <input type="text" name="start" placeholder="Y/M/D" />
      </br>
      <label>Check out: </label>
      <input type="text" name="end" placeholder="Y/M/D" />
      </br>
      <label>City: </label>
      <input type="text" name="City" />
      </br>
      <label>Capacity: </label>
      <input type="text" name="Capacity"/>
      </br>
      <label>Price: </label>
      <input type="text" name="Price"/>
      </br>
      <input type="radio" name="Seaview" value="true">Sea View
      <input type="radio" name="Seaview" value="false">Mountain View
      </br>
      <label>Room is extendable: </label>
      <input type="radio" name="extendable" value="true">Yes
      <input type="radio" name="extendable" value="false">No
      </br>
      <button onclick="<%
                ArrayList<String> rooms=null;
                String start = request.getParameter("start");
                String end = request.getParameter("end");
                if (request.getParameter("City") != null && request.getParameter("Capacity") != null) {
                    String city = request.getParameter("City");
                    String capacity = request.getParameter("Capacity");
                    int price = Integer.parseInt(request.getParameter("Price"));
                    String seaview = request.getParameter("Seaview");
                    String extendable = request.getParameter("extendable");
                    rooms = Data.RoomSearch(start, end, capacity, city, price, seaview, extendable);
                    session.setAttribute("rooms", rooms);
                } %>">Search Available Rooms</button>
    </form>

    <h2>Available Rooms:</h2>
    <ul>
      <label>Hotel Rating, Room ID, Price, Amenities, Problems, Contact Phone, Address</label>
      <%
        if(rooms != null){for(Object room : rooms.toArray()){%>
      <li><%=room.toString()%></li>
      <%}}%>
    </ul>

    <form method="POST" action="Customer_Room_Search.jsp">
      <h2>Booking:</h2>
      <label>Chosen room ID: </label>
      <input type="text" name="roomid">
      </br>
      <label>Customer SIN: </label>
      <input type="text" name="customerSIN">
      </br>
      <label>Check in: </label>
      <input type="text" name="checkin" placeholder="Y/M/D">
      </br>
      <label>Check out: </label>
      <input type="text" name="checkout" placeholder="Y/M/D">
      </br>
      <button onclick="<%
      if(request.getParameter("roomid") != null && request.getParameter("customerSIN")!=null){
        int roomid = Integer.parseInt(request.getParameter("roomid"));
        String sin = request.getParameter("customerSIN");
        String in = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        Data.BookRoom(sin,roomid,in,checkout);
      }%>">Book Room</button>
      </br>
    </form>
  </body>
</html>
