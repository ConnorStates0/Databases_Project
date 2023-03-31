package com.jspData;
import java.sql.*;
import java.util.Calendar;

public class Data{
    public static void main(String[] var0) {
        /**java.sql.Date sqldate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
         addCustomer("121-121-121","goldthwait", "bobcat", "100 the moon lane", "6592659638", sqldate);
        searchBookings("Grimes", "rgrimes@hotmail.com");**/

    }

    public static void Available() {
        System.out.println("1231231312312312312213");
    }

    public static void terminate(int emp_num) {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.addBatch("DELETE FROM works_at WHERE emp_num = "+emp_num);
            st.addBatch("DELETE FROM employees WHERE emp_num = "+emp_num);
            st.executeBatch();
            System.out.println("Employee "+Integer.toString(emp_num)+" has been removed from database.");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void removeCustomer(String SIN){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.addBatch("DELEtE FROM rents WHERE sin = '"+SIN+"'");
            st.addBatch("DELETE FROM customers WHERE sin = '"+SIN+"'");
            st.executeBatch();
            st.close();
            db.close();
            System.out.println("Customer "+SIN+" has been removed from database.");
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void UpdateEmployee(String column, String input, int emp_num) {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.addBatch("UPDATE employees SET "+column+" = '"+input+"' WHERE emp_num = '"+emp_num+"'");
            st.executeBatch();
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void UpdatePosition(String contact_phone, String chain_name, int emp_num) {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.execute("UPDATE works_at SET  contact_phone = '"+contact_phone+"', chain_name = '"+chain_name+"' WHERE emp_num = '"+emp_num+"'");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void UpdateCustomer(String column,String SIN, String input){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.execute("UPDATE customers SET "+column+" = '"+input+"' WHERE sin = '"+SIN+"'");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void addEmployee(String SIN, String last_name, String First_name, String Address, String ContactPhone, String Chain_name,int managerid){

        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM employees WHERE SIN = '"+SIN+"'");
            if(rs.next()){
                System.out.println("An Employee already exists with this SIN");
                return;
            }
            /**emp_num, sin, family_name, given_name, address, manager_id**/
            st.execute("INSERT INTO employees (emp_num, sin, family_name, given_name, address, manager_id) VALUES (DEFAULT,'"+SIN+"','"+last_name+"','"+First_name+"','"+Address+"',"+managerid+");");
            ResultSet empnumber = st.executeQuery("SELECT emp_num FROM employees WHERE SIN = '"+SIN+"'");
            empnumber.next();
            st.execute("INSERT INTO works_at(emp_num,contact_phone,chain_name) VALUES ("+empnumber.getInt(1)+",'"+ContactPhone+"','"+Chain_name+"')");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void addCustomer(String SIN, String last_name, String First_name, String email, String Address){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM customers WHERE SIN = '"+SIN+"'");
            Date registration = new java.sql.Date(Calendar.getInstance().getTime().getTime());
            if(rs.next()){
                System.out.println("An Customer already registered an account with this SIN");
                return;
            }
            st.execute("INSERT INTO customers(sin, family_name, given_name, address, email, registration_date) VALUES ('"+SIN+"','"+last_name+"','"+First_name+"','"+Address+"','"+email+"','"+registration+"')");
            System.out.println("Thank you for registering an account!");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static void searchBookings(String LastName, String Email){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT address, num_of_rooms FROM hotels WHERE contact_phone = (SELECT contact_phone from has WHERE room_id = (SELECT room_id FROM rents WHERE sin = (SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"')))");
            rs.next();
            System.out.println(rs.getString(1) +" "+ rs.getString(2));
            rs = st.executeQuery("SELECT chain_name FROM belongs_to WHERE contact_phone = (SELECT contact_phone from has WHERE room_id = (SELECT room_id FROM rents WHERE sin = (SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"')))");
            rs.next();
            System.out.println(rs.getString(1));
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

}
