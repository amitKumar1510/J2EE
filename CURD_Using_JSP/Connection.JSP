<%@page import="java.io.IOException"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.*" %>

<%
    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/selfinfo", "root", "DATABASEPassword");

        session.setAttribute("dbConnection", con);
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        throw new RuntimeException("Error connecting to the database");
    }
%>
