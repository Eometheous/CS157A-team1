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
        if (cartIdStr != null && !cartIdStr.isEmpty()) {
            int cartId = Integer.parseInt(cartIdStr);


            String sqlStatement = "DELETE FROM `flight_reservation_system`.`cart` WHERE cart_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, cartId);
            int rowsAffected = pstmt.executeUpdate();


            pstmt.close();


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
