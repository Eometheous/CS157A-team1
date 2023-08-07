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


        String iduserStr = request.getParameter("iduser");
        if (iduserStr != null && !iduserStr.isEmpty()) {
            iduser = Integer.parseInt(iduserStr);
        } else {

            out.print("{\"error\": \"iduser parameter is missing or invalid.\"}");
            return;
        }


        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");


        String cartSql = "SELECT * FROM `flight_reservation_system`.`purchased` WHERE iduser = ?";
        PreparedStatement cartPstmt = connection.prepareStatement(cartSql);
        cartPstmt.setInt(1, iduser);
        ResultSet cartRs = cartPstmt.executeQuery();

        boolean firstItem = true;
        while (cartRs.next()) {
            if (!firstItem) {
                jsonBuilder.append(",");
            }
            jsonBuilder.append("{\"iduser\":").append(cartRs.getInt("iduser")).append(",");
            jsonBuilder.append("\"flight_id\":").append(cartRs.getInt("flight_id"));


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


        cartRs.close();
        cartPstmt.close();


        connection.close();


        out.print(jsonBuilder.toString());
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();

        out.print("{\"error\": \"An error occurred while processing the request.\"}");
    }
%>
