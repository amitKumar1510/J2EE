<%@page import="java.io.IOException"%>
<%@page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>
<%
    String Name=request.getParameter("name");
    String Roll=request.getParameter("roll");
    String UID=request.getParameter("uid");
    String Pass=request.getParameter("pass");
    
    Connection conn = (Connection) session.getAttribute("dbConnection");
    PreparedStatement preparedStatement = null;
    // Use the connection as needed
    try {
        String Query="insert into UserReg(Name,Roll,userId,Pass) values (?, ?, ?, ?)";
        preparedStatement = conn.prepareStatement(Query);
            preparedStatement.setString(1, Name);
            preparedStatement.setString(2, Roll);
            preparedStatement.setString(3, UID);
            preparedStatement.setString(4, Pass);
        preparedStatement.executeUpdate();
        out.println("<p>User Registration into the database successfully!Go<a href=AdminHome.jsp>Back</a></p>");
    }catch (Exception e) {
            out.println("<p>Error inserting data into the database: " + e.getMessage() + "</p>");
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
