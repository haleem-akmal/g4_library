package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.dbConnection;

/**
 *
 * @author Moham
 */
@WebServlet(name = "AddReturnHistoryServlet", urlPatterns = {"/AddReturnHistoryServlet"})
public class AddReturnHistoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get values from form
            int borrowing_id = Integer.parseInt(request.getParameter("borrowing_id"));
            String return_date = request.getParameter("return_date");
            int staff_id = Integer.parseInt(request.getParameter("staff_id"));

            // DB connection
            conn = dbConnection.getConnection();

            // SQL insert query
            String query = "INSERT INTO return_history (borrowing_id, return_date, returned_by_staff_id) VALUES (?, ?, ?)";

            // Set parameters
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, borrowing_id);
            stmt.setString(2, return_date);
            stmt.setInt(3, staff_id);

            // Execute insert
            int rowsAffected = stmt.executeUpdate();

            // Success response
            // Redirect with success message
            response.sendRedirect("returnHistory/return_history.jsp?Add=" + rowsAffected);

        } catch (Exception e) {
            e.printStackTrace();
            // Optional: redirect with error message
            response.sendRedirect("returnHistory/return_history.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
