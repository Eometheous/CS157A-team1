<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Get the current session, if one exists (otherwise, it will create a new session)
    
    if (session != null) {
        // Invalidate the session (log out the user)
        session.invalidate();
    }
    
    // Redirect the user to the login page or any other desired page after logout
    response.sendRedirect("/user/LogIn.html");
%>
