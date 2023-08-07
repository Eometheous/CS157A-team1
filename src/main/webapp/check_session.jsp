<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    try{
        session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            if (email != null) {
                response.sendError(200, "Okay");
            }else{
                response.sendError(400, "Bad");
            }
        } else {
            response.sendError(400, "Need Authentication");
        }
    }catch (Exception e){
        response.sendError(400, "Need Authentication");
    }
%>
