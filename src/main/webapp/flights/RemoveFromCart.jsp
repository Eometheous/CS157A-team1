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


        String cartIdStr = request.getParameter("cart_id");
        String flightIdStr = request.getParameter("flight_id");
        if (cartIdStr != null && !cartIdStr.isEmpty()) {
            int cartId = Integer.parseInt(cartIdStr);
            int flightId = Integer.parseInt(flightIdStr);


            String sqlStatement = "DELETE FROM `flight_reservation_system`.`cart` WHERE cart_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, cartId);
            int rowsAffected = pstmt.executeUpdate();


            pstmt.close();

            String updateSqlStatement = "UPDATE `flight_reservation_system`.flight " +
                                        "SET seats_available = seats_available + 1 " +
                                        "WHERE flight_id = ?;";
            PreparedStatement updateState = connection.prepareStatement(updateSqlStatement);
            updateState.setInt(1, flightId);
            int rowsUpdated = updateState.executeUpdate();
            
            updateState.close();

            connection.close();


            if (rowsAffected > 0) {
                response.sendRedirect("../flights/Cart.html");
            } else {
                response.sendRedirect("../flights/Cart.html");
            }
        } else {

            response.sendRedirect("../flights/Cart.html");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();

        out.print("An error occurred while processing the request.");
    }
%>
