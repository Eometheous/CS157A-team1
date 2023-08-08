<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*"%>

<%

    
    if (session != null) {

        session.invalidate();
    }
    

    response.sendRedirect("../user/LogIn.html");
%>
