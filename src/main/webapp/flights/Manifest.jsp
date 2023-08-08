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

           sqlStatement = "SELECT " +
                              "flight_id, " +
                              "iduser, " +
                              "email, " +
                              "first_name, " +
                              "last_name, " +
                              "plane, " +
                              "a1.airport_name AS 'Departing From', " +
                              "a2.airport_name AS 'Arriving', " +
                              "departure_time, " +
                              "arrival_time, " +
                              "seats_available " +
                          "FROM " +
                              "user " +
                                  "NATURAL JOIN " +
                              "purchased " +
                                  "NATURAL JOIN " +
                              "flight, " +
                              "airport a1, " +
                              "airport a2 " +
                          "WHERE " +
                              "`user`.iduser = purchased.iduser " +
                                  "AND a1.airport_id = flight.departing_airport " +
                                  "AND a2.airport_id = flight.arriving_airport " +
                                  "AND (a1.airport_name LIKE '%" + searchTerm + "%' OR a2.airport_name LIKE '%" + searchTerm + "%') ";
        } else {

            sqlStatement = "SELECT " +
                               "flight_id, " +
                               "iduser, " +
                               "email, " +
                               "first_name, " +
                               "last_name, " +
                               "plane, " +
                               "a1.airport_name AS 'Departing From', " +
                               "a2.airport_name AS 'Arriving', " +
                               "departure_time, " +
                               "arrival_time, " +
                               "seats_available " +
                           "FROM " +
                               "user " +
                                   "NATURAL JOIN " +
                               "purchased " +
                                   "NATURAL JOIN " +
                               "flight, " +
                               "airport a1, " +
                               "airport a2 " +
                           "WHERE " +
                               "`user`.iduser = purchased.iduser " +
                                   "AND a1.airport_id = flight.departing_airport " +
                                   "AND a2.airport_id = flight.arriving_airport; ";
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
            out.println("\"user_id\": \"" + rs.getString(2) + "\",");
            out.println("\"email\": \"" + rs.getString(3) + "\",");
            out.println("\"first_name\": \"" + rs.getString(4) + "\",");
            out.println("\"last_name\": \"" + rs.getString(5) + "\",");
            out.println("\"plane\": \"" + rs.getInt(6) + "\",");
            out.println("\"departing_airport\": \"" + rs.getString(7) + "\",");
            out.println("\"arriving_airport\": \"" + rs.getString(8) + "\",");
            out.println("\"departure_time\": \"" + rs.getString(9) + "\",");
            out.println("\"arrival_time\": \"" + rs.getString(10) + "\",");
            out.println("\"seats_available\": \"" + rs.getInt(11) + "\"");
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
