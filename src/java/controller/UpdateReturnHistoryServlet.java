package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.dbConnection;

@WebServlet(name = "UpdateReturnHistoryServlet", urlPatterns = {"/UpdateReturnHistoryServlet"})
public class UpdateReturnHistoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            int borrowing_id = Integer.parseInt(request.getParameter("borrowing_id"));
            String return_date = request.getParameter("return_date");
            int staff_id = Integer.parseInt(request.getParameter("staff_id"));

            conn = dbConnection.getConnection();

            String query = "UPDATE return_history SET return_date = ?, returned_by_staff_id = ? WHERE borrowing_id = ?";

            stmt = conn.prepareStatement(query);
            stmt.setString(1, return_date);
            stmt.setInt(2, staff_id);
            stmt.setInt(3, borrowing_id);

            int rowsAffected = stmt.executeUpdate();

            // Redirect with success message
            response.sendRedirect("returnHistory/return_history.jsp?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("returnHistory/return-history.jsp?error=" + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
