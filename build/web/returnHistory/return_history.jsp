<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="dao.dbConnection"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return History - Library System</title>

    <!-- Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Google Font -->
    <link href="../fonts/fonts.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
html, body {
    font-family: 'Poppins', sans-serif;
    background-color: #f9fafb;
    color: #333;
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

main {
    flex: 1;
}

.history-title {
    font-weight: 600;
    padding: 40px 0 20px;
    color: #1e3a8a;
}

.section-title {
    font-weight: 500;
    margin-bottom: 30px;
}

.card-button {
    background-color: #ffffff;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    transition: all 0.3s ease;
    font-size: 1.2rem;
    margin-top: 20px;
    margin-bottom: 5px;
    display: inline-block;
}

.card-button:hover {
    background-color: #e9f2ff;
    transform: translateY(-5px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

table thead {
    background-color: #1e3a8a;
    color: white;
}

table tbody tr:hover {
    background-color: #eef4ff;
    transition: background-color 0.3s ease;
}

.badge-status {
    font-size: 0.85rem;
}

.table-responsive {
    overflow-x: auto;
}

.fade-out {
    animation: fadeOut 1s ease-out forwards;
    animation-delay: 3s;
}

@keyframes fadeOut {
    to {
        opacity: 0;
        visibility: hidden;
        height: 0;
        margin: 0;
        padding: 0;
    }
}

footer {
    background-color: #e5e7eb;
    font-size: 0.9rem;
    color: #4b5563;
    padding: 20px 0;
}

a.card-button {
    height: 100%;
}

@media (max-width: 767px) {
    .dashboard-title {
        font-size: 2rem;
    }

    .section-title {
        font-size: 1.3rem;
    }
}

    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark p-2">
        <div class="container">
            <a class="navbar-brand fw-bold h4 pt-2" href="#">📚 G4 Library</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="../index.jsp">Dashboard</a>
                    </li>
                    <!-- 
                    <li class="nav-item">
                        <a class="nav-link" href="#">Settings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="#">Logout</a>
                    </li>-->
                </ul>
            </div>
        </div>
    </nav>
    
    <main>
<div class="container">
    <h1 class="history-title text-center">📅  Return History</h1>
    <div class="text-start mb-3">
        <a href="add-return-record.jsp" class="card-button text-dark fw-semibold text-decoration-none">
            📅 Add New Records
        </a>
    </div>

    <div class="card">
        <h4 class="section-title"><i class="bi bi-people-fill"></i> Return History Records</h4>

        <!-- Filter Buttons -->
        <div class="mb-3 d-flex justify-content-end">
            <button class="btn btn-outline-success me-2" onclick="filterStatus('returned')">Show Returned</button>
            <button class="btn btn-outline-warning text-dark me-2" onclick="filterStatus('not-returned')">Show Not Returned</button>
<!--            <button class="btn btn-outline-secondary" onclick="filterStatus('all')">Show All</button>-->
        </div>

        <div class="table-responsive">
            <table class="table table-hover table-bordered align-middle text-center">
                <caption class="text-start text-muted">List of books returned by borrowers</caption>
                <thead>
                    <tr>
                        <th>Borrower Name</th>
                        <th>Book Title</th>
                        <th>Borrow Date</th>
                        <th>Due Date</th>
                        <th>Return Status</th>
                        <th>Returned by Staff</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    conn = dbConnection.getConnection();

    String sql = "SELECT br.borrowing_id, u.name AS borrower_name, b.title AS book_title, br.borrow_date, br.due_date, rh.return_date, s.name AS returned_by_staff " +
                 "FROM borrowings br " +
                 "JOIN books b ON br.book_id = b.book_id " +
                 "JOIN users u ON br.borrower_id = u.user_id " +
                 "LEFT JOIN return_history rh ON br.borrowing_id = rh.borrowing_id " +
                 "LEFT JOIN staff s ON rh.returned_by_staff_id = s.staff_id";

    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();

    while (rs.next()) {
        int borrowingId = rs.getInt("borrowing_id");
        String borrower = rs.getString("borrower_name");
        String title = rs.getString("book_title");
        String borrowDate = rs.getString("borrow_date");
        String dueDate = rs.getString("due_date");
        String returnDate = rs.getString("return_date");
        String staffName = rs.getString("returned_by_staff");
        boolean returned = (returnDate != null);
%>
<tr class="<%= returned ? "returned" : "not-returned" %>">
    <td><%= borrower %></td>
    <td><%= title %></td>
    <td><%= borrowDate %></td>
    <td><%= dueDate %></td>
    <td>
        <% if (returned) { %>
            <span class="badge bg-success badge-status">Returned</span>
        <% } else { %>
            <span class="badge bg-warning text-dark badge-status">Not Returned</span>
        <% } %>
    </td>
    <td><%= (staffName != null) ? staffName : "-" %></td>
    <td>
        <form method="post" action="../DeleteReturnHistoryServlet" style="display:inline;">
            <input type="hidden" name="borrowing_id" value="<%= borrowingId %>" />
            <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete"><i class="bi bi-trash"></i></button>
        </form>
        <a href="edit-return-history.jsp?borrowing_id=<%= borrowingId %>" class="btn btn-outline-primary btn-sm" title="Edit">
            <i class="bi bi-pencil-square"></i>
        </a>
    </td>
</tr>
<%
    }
} catch (Exception e) {
%>
<tr>
    <td colspan="7" class="text-danger">Error: <%= e.getMessage() %></td>
</tr>
<%
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
}
%>
                </tbody>
            </table>

<%
    String Add = request.getParameter("Add");
    String success = request.getParameter("success");
    String deleted = request.getParameter("deleted");
    String error = request.getParameter("error");

    if ("true".equals(success)) {
%>
        <div class="alert alert-success text-center fade-out">✅ Record updated successfully!</div>
<% } else if (deleted != null) { %>
        <div class="alert alert-success text-center fade-out">✅ Deleted <%= deleted %> record(s) successfully.</div>
<% } else if (Add != null) { %>
        <div class="alert alert-success text-center fade-out">✅ Added <%= Add %> record(s) successfully.</div>
<% } else if (error != null) { %>
        <div class="alert alert-danger text-center fade-out">❌ Error: <%= error %></div>
<% } %>

        </div>
    </div>
</div>
</main>
<!-- Filtering Script -->
<script>
    
    window.addEventListener("DOMContentLoaded", () => {
        filterStatus('returned');
    });
    
function filterStatus(status) {
    const rows = document.querySelectorAll("tbody tr");
    rows.forEach(row => {
        if (status === "all") {
            row.style.display = "";
        } else if (row.classList.contains(status)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>

<!-- Clear URL parameters after 3 seconds -->
<script>
    setTimeout(() => {
        if (window.history.replaceState) {
            const cleanUrl = window.location.origin + window.location.pathname;
            window.history.replaceState({}, document.title, cleanUrl);
        }
    }, 3000);
</script>

<!-- Bootstrap JS -->
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>




    <!-- Footer -->
    <footer class="text-center fooder">
        <div class="container">
            <p class="mb-1">&copy; 2025 G4 Library Management System. All rights reserved.</p>
            <small>Designed by G4 Team - Powered by JSP + Servlet + MySQL</small>
        </div>
    </footer>
</body>
</html>
