<%@ page import="java.sql.*"%>
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
                           "AND (a1.airport_name LIKE '%" + searchTerm + "%' OR a2.airport_name LIKE '%" + searchTerm + "%');";
        } else {
            // If the URL parameter is empty or not provided, return all the listings
            sqlStatement = "SELECT flight_id, a1.airport_name AS `from`, a2.airport_name AS `to`, flight.departure_time, flight.arrival_time " +
                           "FROM flight, airport a1, airport a2 " +
                           "WHERE a1.airport_id = flight.departing_airport " +
                           "AND a2.airport_id = flight.arriving_airport;";
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sqlStatement);

        while (rs.next()) {
            out.println(rs.getInt(1) + "    " + rs.getString(2) + "    " + rs.getString(3) + "    " + rs.getString(4) + "    " + rs.getString(5) + "<br/>");
        }
        rs.close();
        stmt.close();
        connection.close();

    } catch (ClassNotFoundException | SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
