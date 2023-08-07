<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="application/json; charset=UTF-8"%>

<%
    try{
        session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            if (email != null) {
                String db = "flight_reservation_system";
                String admin = "joth";
                String adminPassword = "CS157a";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                                admin, adminPassword);

                    String searchTerm = request.getParameter("search");
                    String sqlStatement = "SELECT * FROM `flight_reservation_system`.`user` WHERE `email` = " + "'" + email + "'";
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(sqlStatement);

                    while(rs.next()){
                        out.print("{");
                        out.print("\"iduser\": " + rs.getInt("iduser"));
                        out.print("}");
                    }
                    
                }catch (Exception e){
                    out.println(e);
                }


            }else{
                out.println(email);

            }
        } else {


        }
    }catch (Exception e){
        out.println(e);


    }
%>

