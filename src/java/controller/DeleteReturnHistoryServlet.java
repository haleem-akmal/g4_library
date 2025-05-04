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

@WebServlet(name = "DeleteReturnHistoryServlet", urlPatterns = {"/DeleteReturnHistoryServlet"})
public class DeleteReturnHistoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get borrowing_id from request
            int borrowing_id = Integer.parseInt(request.getParameter("borrowing_id"));

            // Establish DB connection
            conn = dbConnection.getConnection();

            // SQL delete query
            String query = "DELETE FROM return_history WHERE borrowing_id = ?";

            // Prepare and execute
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, borrowing_id);
            int rowsAffected = stmt.executeUpdate();

            // Redirect with success message
            response.sendRedirect("returnHistory/return_history.jsp?deleted=" + rowsAffected);

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
