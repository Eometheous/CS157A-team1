<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<%
    String db = "flight_reservation_system";
    String admin = "joth";
    String adminPassword = "CS157a";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                admin, adminPassword);


        String flightIdStr = request.getParameter("flight_id");
        String iduserStr = request.getParameter("iduser");

        if (iduserStr != null && !iduserStr.isEmpty() &&
            flightIdStr != null && !flightIdStr.isEmpty()) {

            int iduser = Integer.parseInt(iduserStr);
            int flightId = Integer.parseInt(flightIdStr);


            String sqlStatement = "INSERT INTO `flight_reservation_system`.cart (iduser, flight_id) " +
                "Select ?, ?" + 
                " WHERE NOT EXISTS ( " +
                    "Select 'dummy' " + 
                    "from `flight_reservation_system`.cart " + 
                    "Where flight_id = ? and iduser = ?" + 
                ")";
            out.println(sqlStatement);
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, iduser);
            pstmt.setInt(2, flightId);
            pstmt.setInt(3, flightId);
            pstmt.setInt(4, iduser);
            int rowsAffected = pstmt.executeUpdate();

            pstmt.close();

            connection.close();
 

            response.sendRedirect("../flights/FlightListings.html");
        } else {

            response.sendRedirect("../flights/FlightListings.html");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();

        out.println(e);
    }
%>
