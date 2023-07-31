<%@ page import="java.sql.*"%>
<%
    String startingAirport = request.getParameter("start");
    String destinationAirport = request.getParameter("end");
    String startDateTime = request.getParameter("departureTime");
    String endDateTime = request.getParameter("arrivalTime");

    String admin = "joth";
    String adminPassword = "CS157a";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                admin, adminPassword);

        // select airport_id from the airport table
        String queryAirport1 = "SELECT airport_id FROM airport WHERE airport_name = ?";

        PreparedStatement pstmt = connection.prepareStatement(queryAirport1);
        pstmt.setString(1, startingAirport);

        ResultSet resultSet = pstmt.executeQuery();

        if (!resultSet.next()) {
            // airport is not in the database, need to add it.
            String insertAirport1 = "INSERT INTO `flight_reservation_system`.`airport` (`airport_name`) VALUES ('" + startingAirport + "');";

            Statement stmt = connection.createStatement();
            stmt.execute(insertAirport1);

            // now that the new airport is added, get the airport airport1_id
            pstmt = connection.prepareStatement(queryAirport1);
            pstmt.setString(1, startingAirport);

            resultSet = pstmt.executeQuery();
            resultSet.next();
        }
        int airport1_id = resultSet.getInt(1);

        resultSet.close();
        pstmt.close();
        connection.close();

        response.sendRedirect("AddFlights.html");

    } catch (ClassNotFoundException | SQLException e) {
        response.sendRedirect("AddFlights.html");
    }
%>