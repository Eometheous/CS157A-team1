<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>

<%
    String db = "flight_reservation_system";
    String admin = "joth";
    String adminPassword = "CS157a";
    int iduser;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                admin, adminPassword);

        // Get the 'iduser' from the URL parameter
        String iduserStr = request.getParameter("iduser");
        if (iduserStr != null && !iduserStr.isEmpty()) {
            iduser = Integer.parseInt(iduserStr);
        } else {
            // If 'iduser' is not provided, return an error message
            out.print("{\"error\": \"iduser parameter is missing or invalid.\"}");
            return;
        }

        // Create a StringBuilder to construct the JSON response
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");

        // SQL query to retrieve cart items for the given 'iduser'
        String cartSql = "SELECT * FROM `flight_reservation_system`.`cart` WHERE iduser = ?";
        PreparedStatement cartPstmt = connection.prepareStatement(cartSql);
        cartPstmt.setInt(1, iduser);
        ResultSet cartRs = cartPstmt.executeQuery();

        boolean firstItem = true;
        while (cartRs.next()) {
            if (!firstItem) {
                jsonBuilder.append(",");
            }
            jsonBuilder.append("{\"iduser\":").append(cartRs.getInt("iduser")).append(",");
            jsonBuilder.append("\"cart_id\":").append(cartRs.getInt("cart_id")).append(",");
            jsonBuilder.append("\"flight_id\":").append(cartRs.getInt("flight_id"));

            // Retrieve additional flight information using the flight_id
            int flightId = cartRs.getInt("flight_id");
            String flightSql = "SELECT * FROM `flight_reservation_system`.`flight` WHERE flight_id = ?";
            PreparedStatement flightPstmt = connection.prepareStatement(flightSql);
            flightPstmt.setInt(1, flightId);
            ResultSet flightRs = flightPstmt.executeQuery();

            if (flightRs.next()) {
                jsonBuilder.append(",\"plane\":\"").append(flightRs.getString("plane")).append("\",");
                jsonBuilder.append("\"departing_airport\":\"").append(flightRs.getString("departing_airport")).append("\",");
                jsonBuilder.append("\"arriving_airport\":\"").append(flightRs.getString("arriving_airport")).append("\",");
                jsonBuilder.append("\"departure_time\":\"").append(flightRs.getString("departure_time")).append("\",");
                jsonBuilder.append("\"arrival_time\":\"").append(flightRs.getString("arrival_time")).append("\"");
            }

            flightRs.close();
            flightPstmt.close();

            jsonBuilder.append("}");
            firstItem = false;
        }

        jsonBuilder.append("]");

        // Close the cart ResultSet and PreparedStatement
        cartRs.close();
        cartPstmt.close();

        // Close the database connection
        connection.close();

        // Write the JSON string as the response
        out.print(jsonBuilder.toString());
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle any exceptions that occurred during database operations
        out.print("{\"error\": \"An error occurred while processing the request.\"}");
    }
%>
