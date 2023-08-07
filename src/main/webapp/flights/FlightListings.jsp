<%@ page import="java.sql.*"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%
    String db = "flight_reservation_system";
    String admin = "joth";
    String adminPassword = "CS157a";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                    admin, adminPassword);

        String searchTerm = request.getParameter("search");
        String sqlStatement;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Use the search term in the SQL query to filter the listings
            sqlStatement = "SELECT flight_id, a1.airport_name AS `from`, a2.airport_name AS `to`, flight.departure_time, flight.arrival_time " +
                           "FROM flight, airport a1, airport a2 " +
                           "WHERE a1.airport_id = flight.departing_airport " +
                           "AND a2.airport_id = flight.arriving_airport " +
                           "AND (a1.airport_name LIKE '%" + searchTerm + "%' OR a2.airport_name LIKE '%" + searchTerm + "%') " +
                           "AND flight_id not in (select flight_id from purchased);";
        } else {
            // If the URL parameter is empty or not provided, return all the listings
            sqlStatement = "SELECT flight_id, a1.airport_name AS `from`, a2.airport_name AS `to`, flight.departure_time, flight.arrival_time " +
                           "FROM flight, airport a1, airport a2 " +
                           "WHERE a1.airport_id = flight.departing_airport " +
                           "AND a2.airport_id = flight.arriving_airport " +
                           "AND flight_id not in (select flight_id from purchased);";
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sqlStatement);

        out.println("[");

        boolean firstRow = true;
        while (rs.next()) {
            if (!firstRow) {
                out.println(",");
            } else {
                firstRow = false;
            }

            out.println("{");
            out.println("\"flight_id\": " + rs.getInt(1) + ",");
            out.println("\"from\": \"" + rs.getString(2) + "\",");
            out.println("\"to\": \"" + rs.getString(3) + "\",");
            out.println("\"departure_time\": \"" + rs.getString(4) + "\",");
            out.println("\"arrival_time\": \"" + rs.getString(5) + "\"");
            out.println("}");
        }

        out.println("]");

        rs.close();
        stmt.close();
        connection.close();

    } catch (ClassNotFoundException | SQLException e) {
        out.println("{\"error\": \"SQLException caught: " + e.getMessage() + "\"}");
    }
%>
