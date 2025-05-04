<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="dao.dbConnection" %>

<%
    String borrowingIdStr = request.getParameter("borrowing_id");
    int borrowingId = Integer.parseInt(borrowingIdStr);

    String returnDate = "";
    int staffId = 0;
    String borrowerName = "";
    String title = "";
    String borrowDate = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = dbConnection.getConnection();
        String query = "SELECT " +
                       "br.borrowing_id, " +
                       "u.name AS borrower_name, " +
                       "b.title AS book_title, " +
                       "br.borrow_date, " +
                       "rh.return_date, " +
                       "rh.returned_by_staff_id " +
                       "FROM borrowings br " +
                       "JOIN users u ON br.borrower_id = u.user_id " +
                       "JOIN books b ON br.book_id = b.book_id " +
                       "LEFT JOIN return_history rh ON br.borrowing_id = rh.borrowing_id " +
                       "WHERE br.borrowing_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, borrowingId);
        rs = ps.executeQuery();

        if (rs.next()) {
            returnDate = rs.getString("return_date") != null ? rs.getString("return_date") : "";
            staffId = rs.getInt("returned_by_staff_id");
            borrowerName = rs.getString("borrower_name");
            title = rs.getString("book_title");
            borrowDate = rs.getString("borrow_date");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Return Record</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../fonts/fonts.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

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
            margin: 40px 0 20px;
            color: #1e3a8a;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            background-color: #ffffff;
        }
        .form-label i {
            margin-right: 5px;
            
        table thead {
            background-color: #1e3a8a;
            color: white;
        }

        table tbody tr:hover {
            background-color: #eef4ff;
            transition: background-color 0.3s ease;
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
<body >

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
                    <li class="nav-item">
                        <a class="nav-link" href="return_history.jsp">Return History</a>
                    </li>
<!--                    <li class="nav-item">
                        <a class="nav-link" href="#">Reports</a>
                    </li>
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
        <div class="container mt-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="../index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="return_history.jsp">Return History</a></li>
            <li class="breadcrumb-item active" aria-current="page">Edit Record</li>
        </ol>
    </nav>

    <!-- Page Title -->
    <h3 class="history-title text-center ">📅 Edit Return Record</h3>

    <!-- Card Form -->
    <div class="card mt-3">
        <h4 class="section-title"><i class="bi bi-people-fill"></i>Borrow Info</h4>
        
        <table class="table table-hover table-bordered align-middle text-center">
            <thead>
            <tr>
              <th>👤 Borrower:</th>
              <th>📚 Book Title:</th>
              <th>📆 Borrowed On:</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= borrowerName %></td>
                    <td><%= title %></td>
                    <td><%= borrowDate %></td>
                </tr>
            </tbody>
        </table>

        <!-- Form Start -->
        <form action="../UpdateReturnHistoryServlet" method="post" class="row g-3 needs-validation" novalidate>
            <input type="hidden" name="borrowing_id" value="<%= borrowingId %>">

            <div class="col-md-6">
                <label class="form-label"><i class="bi bi-calendar-event"></i> Return Date</label>
                <input type="date" name="return_date" class="form-control" value="<%= returnDate %>" required>
                <div class="invalid-feedback">Please enter the return date.</div>
            </div>

            <div class="col-md-6">
                <label class="form-label"><i class="bi bi-person-badge"></i> Returned By Staff</label>
                <select name="staff_id" class="form-select" required>
                    <option value="">-- Select Staff --</option>
                    <%
                        Connection conn2 = null;
                        PreparedStatement ps2 = null;
                        ResultSet rs2 = null;
                        try {
                            conn2 = dbConnection.getConnection();
                            ps2 = conn2.prepareStatement("SELECT staff_id, name FROM staff");
                            rs2 = ps2.executeQuery();
                            while (rs2.next()) {
                                int sid = rs2.getInt("staff_id");
                                String name = rs2.getString("name");
                                String selected = (sid == staffId) ? "selected" : "";
                    %>
                    <option value="<%= sid %>" <%= selected %>><%= name %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs2 != null) rs2.close(); } catch (Exception ignored) {}
                            try { if (ps2 != null) ps2.close(); } catch (Exception ignored) {}
                            try { if (conn2 != null) conn2.close(); } catch (Exception ignored) {}
                        }
                    %>
                </select>
                <div class="invalid-feedback">Please select a staff member.</div>
            </div>

            <!-- Buttons -->
            <div class="col-12 d-flex justify-content-between mt-3">
                <button type="submit" class="btn btn-primary" id="submitBtn">💾 Update Record</button>
                <a href="return_history.jsp" class="btn btn-secondary">❌ Cancel</a>
            </div>
        </form>
    </div>
        </div>
</main>
                
    <!-- Footer -->
    <footer class="text-center fooder">
        <div class="container">
            <p class="mb-1">&copy; 2025 G4 Library Management System. All rights reserved.</p>
            <small>Designed by G4 Team - Powered by JSP + Servlet + MySQL</small>
        </div>
    </footer>                
                
    <script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Bootstrap form validation
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    } else {
                        document.getElementById("submitBtn").disabled = true;
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
