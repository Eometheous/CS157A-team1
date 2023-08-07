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

        // Get the 'cart_id' from the URL parameter
        String cartIdStr = request.getParameter("cart_id");
        if (cartIdStr != null && !cartIdStr.isEmpty()) {
            int cartId = Integer.parseInt(cartIdStr);

            // SQL query to remove the row from the 'cart' table with the given 'cart_id'
            String sqlStatement = "DELETE FROM `flight_reservation_system`.`cart` WHERE cart_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, cartId);
            int rowsAffected = pstmt.executeUpdate();

            // Close the PreparedStatement
            pstmt.close();

            // Close the database connection
            connection.close();

            // Check if the removal was successful
            if (rowsAffected > 0) {
                response.sendRedirect("../flights/Cart.html");
            } else {
                response.sendRedirect("../flights/Cart.html");
            }
        } else {
            // If 'cart_id' is not provided, return an error message
            response.sendRedirect("../flights/Cart.html");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle any exceptions that occurred during database operations
        out.print("An error occurred while processing the request.");
    }
%>
