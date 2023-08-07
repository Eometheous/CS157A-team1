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

        // Get the 'iduser' and 'flight_id' from the URL parameters
        String flightIdStr = request.getParameter("flight_id");
        String iduserStr = request.getParameter("iduser");

        if (iduserStr != null && !iduserStr.isEmpty() &&
            flightIdStr != null && !flightIdStr.isEmpty()) {

            int iduser = Integer.parseInt(iduserStr);
            int flightId = Integer.parseInt(flightIdStr);

            // SQL query to add a new row to the 'cart' table with auto-incremented 'cart_id'
            String sqlStatement = "INSERT INTO `flight_reservation_system`.cart (iduser, flight_id) VALUES (?, ?)";
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, iduser);
            pstmt.setInt(2, flightId);
            int rowsAffected = pstmt.executeUpdate();
            // Close the PreparedStatement
            pstmt.close();

            // Close the database connection
            connection.close();

            // Redirect to FlightListings.html after the insertion
            response.sendRedirect("../flights/FlightListings.html");
        } else {
            // If 'iduser' or 'flight_id' is not provided, redirect to FlightListings.html
            response.sendRedirect("../flights/FlightListings.html");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle any exceptions that occurred during database operations
        out.print("An error occurred while processing the request.");
    }
%>
