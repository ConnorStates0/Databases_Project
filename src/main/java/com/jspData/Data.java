package com.jspData;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

public class Data{
    public static void main(String[] var0) {
         }
    public static void terminate(int emp_num) {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
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

    public static void UpdatePosition(String contact_phone, String chain_name, String title, int emp_num) {
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.execute("UPDATE works_at SET  contact_phone = '"+contact_phone+"', chain_name = '"+chain_name+"' , position_title = '"+title+ "' WHERE emp_num = '"+emp_num+"'");
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

    public static void addEmployee(String SIN, String last_name, String First_name, String Address, String ContactPhone, String Chain_name,String title,int managerid){

        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM employees WHERE SIN = '"+SIN+"'");
            rs.next();
            if(rs.getString(1).equals(SIN)){
                System.out.println("An Employee already exists with this SIN");
                return;
            }
            /**emp_num, sin, family_name, given_name, address, manager_id**/
            else{
                st.execute("INSERT INTO employees (emp_num, sin, family_name, given_name, address, manager_id) VALUES (DEFAULT,'"+SIN+"','"+last_name+"','"+First_name+"','"+Address+"',"+managerid+");");
                ResultSet empnumber = st.executeQuery("SELECT emp_num FROM employees WHERE SIN = '"+SIN+"'");
                empnumber.next();
                st.execute("INSERT INTO works_at(emp_num,contact_phone,chain_name,position_title) VALUES ("+empnumber.getInt(1)+",'"+ContactPhone+"','"+Chain_name+"','"+title+"')");}
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
            ResultSet rs = st.executeQuery("SELECT sin FROM customers WHERE sin = '"+SIN+"'");
            Date registration = new java.sql.Date(Calendar.getInstance().getTime().getTime());
            if(rs.next() == true){
                System.out.println("An Customer already registered an account with this SIN");
                return;
            }
            else{
                st.execute("INSERT INTO customers(sin, family_name, given_name, address, email, registration_date) VALUES ('"+SIN+"','"+last_name+"','"+First_name+"','"+Address+"','"+email+"','"+registration+"')");
                System.out.println("Thank you for registering an account!");
            }
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static ArrayList<String> searchBookings(String LastName, String Email){
        ArrayList<String> info = new ArrayList<String>();
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT address FROM hotels WHERE contact_phone in (SELECT contact_phone from has WHERE room_id in (SELECT room_id FROM rents WHERE sin = (SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"')))");
            rs.next();
            info.add(rs.getString(1));
            rs = st.executeQuery("SELECT COUNT(room_id) FROM rents WHERE sin = (SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"')");
            rs.next();
            info.add(rs.getString(1));
            rs = st.executeQuery("SELECT chain_name FROM belongs_to WHERE contact_phone in (SELECT contact_phone from has WHERE room_id = (SELECT room_id FROM rents WHERE sin = (SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"')))");
            rs.next();
            info.add(rs.getString(1));
            rs = st.executeQuery("SELECT sin FROM customers where email = '"+Email+"' AND family_name ='"+LastName+"'");
            rs.next();
            info.add(rs.getString(1));
            st.close();
            db.close();
            return info;
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
        return info;
    }

    public static void approveBookings(String sin, String Card){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.execute("UPDATE rents SET approved = 'true', credit_card = '"+Card+"' WHERE sin = '"+sin+"'");
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }

    public static ArrayList<String> RoomSearch(String Start, String End, String RoomCapacity, String city, int Price, String Sea_view, String Extendable){
        ArrayList<String> roomids = new ArrayList<String>();
        String entry;
        int i = 0;
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT rating,room_id,price,amenities,problems,contact_phone,address FROM rooms CROSS JOIN hotels WHERE room_id NOT in (SELECT room_id from rents where (CAST('"+Start+"' AS DATE) not between start_date AND end_date) AND (CAST('"+End+"' AS DATE) not between start_date AND end_date) AND room_id in (Select room_id from rooms where sea_view = "+Sea_view+" and is_extendable = "+Extendable+" and capacity = '"+RoomCapacity+"' and price <= "+Price+" and room_id in (select room_id from has where contact_phone in (select contact_phone from hotels where city = '"+city+"'))))");
            while (rs.next() && i < 15){
                entry = rs.getString(1)+", "+rs.getString(2)+", "+rs.getString(3)+", "+rs.getString(4)+", "+rs.getString(5)+", "+rs.getString(6)+", "+rs.getString(7);
                roomids.add(entry);
                i++;
            }
            st.close();
            db.close();
        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
        return roomids;
    }

    public static void BookRoom(String sin, int roomid, String start, String end){
        try {
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Groupproject", "postgres", "1234");
            Statement st = db.createStatement();
            st.execute("INSERT INTO rents(sin, room_id, credit_card,approved,start_date,end_date) VALUES ('"+sin+"',"+roomid+",Null,NULL,'"+start+"','"+end+"')");

        } catch (SQLException exception) {
            System.out.println(" An exception was thrown:" + exception.getMessage());
        }
    }
}
