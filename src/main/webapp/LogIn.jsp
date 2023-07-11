<%@ page import="java.sql.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String db = "flight_reservation_system";
    String admin = "joth";
    String adminPassword = "CS157a";

    boolean loggedIn = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                    admin, adminPassword);

        String sqlStatement = "SELECT * FROM `flight_reservation_system`.`user` WHERE `email` = ? AND `password` = ?";
        PreparedStatement pstmt = connection.prepareStatement(sqlStatement);
        pstmt.setString(1, email);
        pstmt.setString(2, password);

        ResultSet resultSet = pstmt.executeQuery();
        loggedIn = resultSet.next();

        resultSet.close();
        pstmt.close();
        connection.close();

    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }

    if (loggedIn) {
        // Redirect to the home page or any other authorized page
        // Will need to create "home.jsp" file
        response.sendRedirect("Home.jsp");
    } else {
        // Show an error message or redirect to an error page
        // Will need to create "login_error.jsp" file
        response.sendRedirect("Login_Error.jsp");
    }
%>
