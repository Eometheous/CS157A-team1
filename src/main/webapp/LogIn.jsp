<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- NavBar -->
    <header>
        <h1> <a href="index.html" style="width: 20%; text-decoration: none; color: #44cea4;">Flights GO</a></h1>
        <div class="hamburger">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
        </div>
        <nav class="nav-bar">
            <ul>
                <li>
                    <a href="LogIn.jsp">Login</a>
                </li>
                <li>
                    <a href="SignUp.jsp">Signup</a>
                </li>
                <li>
                    <a href="landingPage.jsp">Book</a>
                </li>
            </ul>
        </nav>
    </header>
    <section>
        <div class="whatWeAre__list" style="margin-left: -3rem;">        
            <ul>
                <li>
                    <h1>Login</h1>
                </li>
                <li>
                    <form action="LogIn.jsp" method="post">
                        <input style="width: 8rem;" placeholder="email" type="text" id="email" required><br>
                        <input style="width: 8rem;" placeholder="password" type="password" id="password" required><br>

        
                        <input style="width: 8rem; text-align: center;" type="Submit" value="Login">
                    </form>
                </li>
                <li>
                    <form action="SignUp.html">
                        <input style="width: 8rem;" type="submit" value="Sign Up">
                    </form>
                </li>
            </ul>
            
        </div>
    </section>
</body>
</html>

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

        if (loggedIn) {
            // Redirect to the home page or any other authorized page
            // Will need to create "home.jsp" file
            response.sendRedirect("landingPage.html");
        }else {
            // Invalid credentials
            out.println("Invalid email or password. Please try again.");
        }

        resultSet.close();
        pstmt.close();
        connection.close();

    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
%>
