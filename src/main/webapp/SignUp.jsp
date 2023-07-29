<%@ page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("passwordConfirm");

    if(!password.equals(confirmPassword)){
        out.println("Passwords do not Match");
    }
    else{

        String db = "flight_reservation_system";
        String admin = "joth";
        String adminPassword = "CS157a";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_reservation_system?autoReconnect=true&useSSL=false",
                        admin, adminPassword);


            String sqlStatement = "INSERT INTO `flight_reservation_system`.`user`" +
                                "(`email`," +
                                "`first_name`," +
                                "`last_name`," +
                                "`password`)" +
                                "VALUES" +
                                "('" + email + "'," +
                                "'" + firstName + "'," +
                                "'" + lastName + "'," +
                                "'" + password + "');";

            Statement stmt = connection.createStatement();

            stmt.execute(sqlStatement);

            stmt.close();
            connection.close();

            response.sendRedirect("Home.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            response.sendRedirect("SignUp.html");
        }
    }
%>