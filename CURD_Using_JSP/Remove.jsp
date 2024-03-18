<%@page import="java.io.IOException"%>
<%@page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>


<%
    String UID=request.getParameter("uid");
    
    Connection conn = (Connection) session.getAttribute("dbConnection");
    PreparedStatement preparedStatement = null;
     
         try {
        String Query="DELETE FROM UserReg WHERE userId =?";
        preparedStatement = conn.prepareStatement(Query);
        preparedStatement.setString(1, UID);
        int check=preparedStatement.executeUpdate();
        if(check>0){
        out.println("<p>User Delete into the database successfully! Click to <a href=AdminHome.jsp>Back</a></p>");
    }
        
    }catch (Exception e) {
            out.println("<p>Error Deleting data into the database: " + e.getMessage() + "</p>");
        } finally {
            try { 
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
%>
