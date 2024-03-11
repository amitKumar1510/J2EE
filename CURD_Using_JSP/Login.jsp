<%@page import="java.io.IOException"%>
<%@page import="java.sql.*" %>
<%@include file="Connection.jsp" %>

<%
        String uid = request.getParameter("uid");
        String pass = request.getParameter("pwd");
        Connection conn = (Connection) session.getAttribute("dbConnection");
            try (PreparedStatement ps = conn.prepareStatement("SELECT Name FROM UserReg WHERE userId = ? AND Pass = ?")) {
                ps.setString(1, uid);
                ps.setString(2, pass);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String userName = rs.getString("Name");
                        // Use session.setAttribute to store user information
                        session.setAttribute("loggedInUser", userName);

                        // Use absolute path for RequestDispatcher
                        RequestDispatcher rd = request.getRequestDispatcher("/AdminHome.jsp");
                        rd.forward(request, response);
                    } else {
                        out.println("<p>Login Failed!</p>");
                        out.println("<a href='index.html'>Try again</a>");
                    }
                }
            }
         catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error executing SQL query: " + e.getMessage());
        }
    
%>
