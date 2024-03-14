<%@page import="java.io.IOException"%>
<%@page import="java.sql.*" %>
<%@include file="Connection.jsp" %>

<%
   String Name = request.getParameter("name");
   String Roll = request.getParameter("roll");
   String UID = request.getParameter("uid");
   String Pass = request.getParameter("pass");
   
   Connection conn = (Connection) session.getAttribute("dbConnection");
   PreparedStatement preparedStatement = null;
   try {
      String Query = "UPDATE UserReg SET Name=?, Roll=?, Pass=? WHERE userId=?";
      preparedStatement = conn.prepareStatement(Query);
      preparedStatement.setString(1, Name);
      preparedStatement.setString(2, Roll);
      preparedStatement.setString(3, Pass);
      preparedStatement.setString(4, UID);
            
      int check = preparedStatement.executeUpdate();
      if (check > 0) {
         out.println("<p>User updated into the database successfully! Click to <a href=AdminHome.jsp>Back</a></p>");
      }
   } catch (Exception e) {
      out.println("<p>Error updating data into the database: " + e.getMessage() + "</p>");
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
