<%@ page import="javax.servlet.http.HttpSession" %>
<%
    session = request.getSession(false);
    if (session != null) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            out.println("<p>Hello, " + email + "!</p>");
        } else {
            out.println("<p>Session exists, but email attribute is not set.</p>");
        }
    } else {
        out.println("<p>No active session found.</p>");
    }
%>
