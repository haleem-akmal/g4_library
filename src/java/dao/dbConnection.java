
package dao;
import java.sql.*;

/**
 *
 * @author Moham
 */
public class dbConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/g4_library";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
}
