<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Retrieve the session
    session = request.getSession(false);
    if (session != null) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            // Return the session data as a response to the Ajax request
            out.println("<p>Hello, " + email + "!</p>");
        } else {
            out.println("<p>Session exists, but email attribute is not set.</p>");
        }
    } else {
        out.println("<p>No active session found.</p>");
    }
%>
