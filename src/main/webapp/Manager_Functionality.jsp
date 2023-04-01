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
    <title>Managment</title>
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
    <h1>MANAGEMENT FEATURES</h1>
    <div name="terminate" id="terminate" class="terminate">
      <h2>Terminate Employee:</h2>
        <form method = "POST" action="Manager_Functionality.jsp">
            <input type="text" name="Empinput" placeholder="Employee ID">
            <button onclick="<%
            if(request.getParameter("Empinput")!=null){
            int emp = Integer.parseInt(request.getParameter("Empinput"));
            Data.terminate(emp);} %>">Remove</button>
        </form>

    </div>

    <div name="remove-cust" id="remove-cust" class="remove-cust">
      <h2>Remove Customer:</h2>
        <form method = "POST" action="Manager_Functionality.jsp">
            <input type="text" name="SINinput" placeholder="Customer SIN">
            <button onclick="<%
            if(request.getParameter("SINinput")!=null){
            String Sin = request.getParameter("SINinput");
            Data.removeCustomer(Sin);} %>">Remove</button>
        </form>
    </div>

    <div name="update-cust" id="update-cust" class="update-cust">
      <h2>Update Customer:</h2>
        <form method = "POST" action="Manager_Functionality.jsp">
            <label>SIN:</label>
            <input type="text" name="SIN" placeholder="Customer SIN">
            </br>
            <label>Choose attribute to update:</label>
            <input type="radio" name="Column" value="sin"/>SIN
            <input type="radio" name="Column" value="family_name"/>Last Name
            <input type="radio" name="Column" value="given_name"/>First Name
            <input type="radio" name="Column" value="address"/>Address
            <input type="radio" name="Column" value="Email"/>Email
            </br>
            <label>Enter new Value:</label>
            <input type="text" name="newValue" placeholder="New Value">
            </br>
            <button onclick="<%
            if(request.getParameter("newValue")!=null && request.getParameter("Column")!= null){
                String SIN = request.getParameter("SIN");
                String column = request.getParameter("Column");
                String newvalue = request.getParameter("newValue");
                Data.UpdateCustomer(column,SIN,newvalue);} %>">Confirm Update</button>
        </form>
    </div>


    <div name="update-emp" id="update-emp" class="update-emp">
        <h2>Update Employee:</h2>
        <form method = "POST" action="Manager_Functionality.jsp">
            <label>Employee ID:</label>
            <input type="text" name="empID" placeholder="Employee ID">
            </br>
            <label>Choose attribute to update:</label>
            <input type="radio" name="column" value="sin" onclick="hide()"/>Employee Number
            <input type="radio" name="column" value="sin" onclick="hide()"/>SIN
            <input type="radio" name="column" value="family_name" onclick="hide()"/>Last Name
            <input type="radio" name="column" value="given_name" onclick="hide()"/>First Name
            <input type="radio" name="column" value="address" onclick="hide()"/>Address
            <input type="radio" name="column" value="Email" onclick="hide()"/>Email
            <input type="radio" name="column" value="Job" onclick="display()"/>Job
            </br>
            <label>Enter new Value:</label>
            <div id="Employeeinputs" style="display: block">
                <input type="text" name="input" placeholder="New Value">
            </div>
            <div id="jobinputs" style="display: none">
                <input type="text" name="chain_name" placeholder="Chain Name">
                <input type="text" name="contact_phone" placeholder="Contact Phone">
                <input type="text" name="position_title" placeholder="Position Title">
            </div>
            </br>
            <button onclick="<%
            if(request.getParameter("empID") != null){
                int ID = Integer.parseInt(request.getParameter("empID"));
                if(request.getParameter("column").equals("Job")){
                    String phone = request.getParameter("contact_phone");
                    String chain = request.getParameter("chain_name");
                    String position = request.getParameter("position_title");
                    Data.UpdatePosition(phone,chain,position,ID);
                }else{
                        if(request.getParameter("input")!=null){
                            String column = request.getParameter("column");
                            String input = request.getParameter("input");
                            Data.UpdateEmployee(column,input,ID);
                        }
                }
            }%>">Confirm Update</button>
        </form>
        <script type="text/javascript">
            function display(){
                document.getElementById("Employeeinputs").style.display = "none";
                document.getElementById("jobinputs").style.display = "block";
            }
            function hide(){
                document.getElementById("Employeeinputs").style.display = "block";
                document.getElementById("jobinputs").style.display = "none";
            }
        </script>
    </div>


    <div name="new-hire-forum" id="new-hire-forum">
        <h2>New Hire:</h2>
        <form method = "POST" action="Manager_Functionality.jsp">
            <input type="text" name="chainname" placeholder="Chain Name">
            </br>
            <input type="text" name="contactphone" placeholder="Contact Phone">
            </br>
            <input type="text" name="title" placeholder="Position Title">
            </br>
            <input type="text" name="Sin" placeholder="SIN">
            </br>
            <input type="text" name="familyname" placeholder="Last Name">
            </br>
            <input type="text" name="givenname" placeholder="First Name">
            </br>
            <input type="text" name="Address" placeholder="Address">
            </br>
            <input type="text" name="managerid" placeholder="Manager ID">
            </br>
            <button onclick="<%
                if(request.getParameter("chainname")!= null && request.getParameter("contactphone")!= null && request.getParameter("Sin")!= null && request.getParameter("familyname")!= null && request.getParameter("givenname")!= null && request.getParameter("Address")!= null && request.getParameter("managerid")!= null){
                    String chain_name = request.getParameter("chainname");
                    String contact_phone = request.getParameter("contactphone");
                    String title = request.getParameter("title");
                    String sin = request.getParameter("Sin");
                    String family_name = request.getParameter("familyname");
                    String given_name = request.getParameter("givenname");
                    String address = request.getParameter("Address");
                    int manager_id = Integer.parseInt(request.getParameter("managerid"));
                    Data.addEmployee(sin, family_name, given_name, address, contact_phone, chain_name,title, manager_id);
                }
            %>">You're Hired!</button>
        </form>
    </div>
  </body>
</html>
