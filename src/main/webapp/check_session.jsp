<%@ page import="javax.servlet.http.HttpSession" %>
<%
    try{
        session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            if (email != null) {
                response.sendError(200, "Okay");
            }else{
                response.sendError(407, "Bad");
            }
        } else {
            response.sendError(407, "Need Authentication");
        }
    }catch (Exception e){
        response.sendError(407, "Need Authentication");
    }
%>
