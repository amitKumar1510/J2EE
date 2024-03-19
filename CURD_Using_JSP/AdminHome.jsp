AdminHome.jsp:-
<%@page import="java.io.IOException"%>
<%@page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        .main{
            height:400px;
            display : flex;
            flex-direction:row;
            justify-content:space-evenly;
            border:2px solid Red;
        }
         .inputForm{
                height:300px;
                width:200px;
                padding:20px;
                display:flex;
                margin:10% auto;
                flex-direction:column;
                justify-content: center;
                align-items: center;
                border:1px solid black;
                background-color:#ffe6e6;
                border-radius:0 20px;
            }
            input{
                height:20px;
                width:200px;  
                background-color:whiteSmoke;
                
            }
            input[type=submit]{
                height:28px;
                background-color:blue;
                color:white;
            }
    </style>
</head>
<body>
    <P>Welcome, <%= session.getAttribute("loggedInUser") %></p>
    <div class="main">
        <div class="Register">
            <form action="AdminHome.jsp" method="post" class="inputForm">
                <p>New Registration Form</p>
                Name : <input type="text" name="name"><br>
                Roll: <input type="text" name="roll"><br>
                User Id : <input type="text" name="uid"><br>
                Password : <input type="text" name="pass"><br>
                <input type="submit" value="Register">
            </form>
        </div>
        <div class="Update">
            <form action="Update.jsp" method="post" class="inputForm">
                <p> Update Form</p>
                Name : <input type="text" name="name"><br>
                Roll: <input type="text" name="roll"><br>
                User Id : <input type="text" name="uid"><br>
                Password : <input type="text" name="pass"><br>
                <input type="submit" value="Update"> 
            </form>    
        </div>
        <div class="Remove">
            <form action="Remove.jsp" method="post" class="inputForm">
                <p>Deletion Form</p>
                User Id : <input type="text" name="uid"><br>
                <input type="submit" value="Remove"> 
            </form>
        </div>
    </div>
</body>
</html>




<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
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
        out.println("<p>User Registration into the database successfully!</p>");
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
    }
%>

Update.jsp:-
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
