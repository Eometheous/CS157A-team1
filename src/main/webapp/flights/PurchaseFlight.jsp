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
        String cart_idStr = request.getParameter("cart_id");

        if (iduserStr != null && !iduserStr.isEmpty() &&
            flightIdStr != null && !flightIdStr.isEmpty()) {

            int iduser = Integer.parseInt(iduserStr);
            int flightId = Integer.parseInt(flightIdStr);
            int cart_id = Integer.parseInt(cart_idStr);

            String sqlStatement = "INSERT INTO `flight_reservation_system`.purchased (flight_id, iduser) " +
                "Values (?, ?); " ;
            out.println(flightId);
            out.println(iduser);
            out.println(sqlStatement);
            PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, flightId);
            pstmt.setInt(2, iduser);
            
            int rowsAffected = pstmt.executeUpdate();

            sqlStatement = "DELETE FROM `flight_reservation_system`.cart where cart_id = ?";
            pstmt = connection.prepareStatement(sqlStatement);
            pstmt.setInt(1, cart_id);
            
            rowsAffected = pstmt.executeUpdate();
            pstmt.close();

            connection.close();
 

            response.sendRedirect("../flights/Cart.html");
        } else {

            response.sendRedirect("../flights/Cart.html");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();

        out.println(e);
    }
%>
