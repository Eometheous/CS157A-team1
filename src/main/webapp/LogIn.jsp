<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    if (request.getParameter("loginButton") != null)  {
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

            if (loggedIn) {

                if (session == null) {
                    // Create a new session and set the "email" attribute
                    session = request.getSession(true);
                }
                session.setAttribute("email", email);
                
                // Redirect to the secured page
                response.sendRedirect("secured_page.jsp");
            } else {
                // Invalid credentials
                out.println(email);
                out.println(password);
            }

            resultSet.close();
            pstmt.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
%>
