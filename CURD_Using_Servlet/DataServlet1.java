import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DataServlet1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String userRoll=request.getParameter("roll");
        String userName=request.getParameter("name");
        String Class=request.getParameter("course");

        try {
            Connection connection = MysqlConnection_Class.getConnection();

            createTable(connection);

            insertData(connection, userRoll, userName,Class);
            out.println("<h2>Data from the Database after insertion :</h2>");
            printData(out, connection); // print data after insertion.
            
            updateData(connection);
            out.println("<h2>Data from the Database after update :</h2>");
            printData(out, connection); // print data after update.
            
            deleteData(connection);
            out.println("<h2>Data from the Database after deletion :</h2>");
            printData(out, connection); // print data after deletion.

            MysqlConnection_Class.closeConnection();

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }

    private void createTable(Connection connection) throws SQLException {
        String CreateTable = "CREATE TABLE IF NOT EXISTS Users (id VARCHAR(15) PRIMARY KEY, name VARCHAR(50),course VARCHAR(10))";
        try (PreparedStatement preparedStatement = connection.prepareStatement(CreateTable)) {
            preparedStatement.executeUpdate();
        }
    }

    private void insertData(Connection connection,String userRoll,String userName,String Class) throws SQLException {
        String InsertData = "INSERT INTO Users (id, name, course) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(InsertData)) {
            preparedStatement.setString(1, userRoll);
            preparedStatement.setString(2, userName);
            preparedStatement.setString(3, Class);
            preparedStatement.executeUpdate();
        }
    }

    private void printData(PrintWriter out, Connection connection) throws SQLException {
        String selectData = "SELECT * FROM Users"; 
        try (PreparedStatement preparedStatement = connection.prepareStatement(selectData)) {

            out.println("<table border='1'><tr><th>ID</th><th>Name</th><th>Course</th></tr>");
            var resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String id = resultSet.getString("id");
                String name = resultSet.getString("name");
                
                String Class = resultSet.getString("course");
                out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + Class + "</td></tr>");
            }

            out.println("</table>");
        }
    }
    
    private void updateData(Connection connection) throws SQLException {
        String UpdateData = "UPDATE Users SET name = 'animesh' WHERE id ='23MCA20151'";
        try (PreparedStatement preparedStatement = connection.prepareStatement(UpdateData)) {
            preparedStatement.executeUpdate();
        }
    }
    
    private void deleteData(Connection connection) throws SQLException {
        String DeleteData = "DELETE FROM Users WHERE id ='23MCA30153'";
        try (PreparedStatement preparedStatement = connection.prepareStatement(DeleteData)) {
            preparedStatement.executeUpdate();
        }
    }

    
}
