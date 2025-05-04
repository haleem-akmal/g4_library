<%@page import="java.util.*, java.sql.*,dao.dbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    List<Map<String, String>> borrowings = new ArrayList<>();
    List<Map<String, String>> staffList = new ArrayList<>();

    try {
        conn = dbConnection.getConnection();

        // Borrowing records (filter unreturned ones)
        String borrowQuery = "SELECT br.borrowing_id, u.name AS borrower_name, b.title, br.borrow_date " +
                             "FROM borrowings br " +
                             "JOIN users u ON br.borrower_id = u.user_id " +
                             "JOIN books b ON br.book_id = b.book_id " +
                             "LEFT JOIN return_history rh ON br.borrowing_id = rh.borrowing_id " +
                             "WHERE rh.return_date IS NULL";
        ps = conn.prepareStatement(borrowQuery);
        rs = ps.executeQuery();
        while(rs.next()) {
            Map<String, String> row = new HashMap<>();
            row.put("id", rs.getString("borrowing_id"));
            row.put("label", rs.getString("borrower_name") + " - " + rs.getString("title") + " (" + rs.getString("borrow_date") + ")");
            borrowings.add(row);
        }
        rs.close();
        ps.close();

        // Staff list
        String staffQuery = "SELECT staff_id, name FROM staff";
        ps = conn.prepareStatement(staffQuery);
        rs = ps.executeQuery();
        while(rs.next()) {
            Map<String, String> row = new HashMap<>();
            row.put("id", rs.getString("staff_id"));
            row.put("name", rs.getString("name"));
            staffList.add(row);
        }

    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Return History</title>
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    
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
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9fafb;
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
<body class="bg-light">
    
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
    <h2 class=" text-center history-title">📥 Add Return Record</h2>
    <div class="card">
     <h4 class="section-title mb-4 "><i class="bi bi-people-fill"></i>Borrow Info</h4>
    <form action="../AddReturnHistoryServlet" method="post" class="row g-3">

        <div class="col-md-6">
            <label for="borrowing_id" class="form-label">Borrowing Record</label>
            <select name="borrowing_id" class="form-select" required>
                <option value="" disabled selected>Select Borrowing</option>
                <% for(Map<String, String> b : borrowings) { %>
                    <option value="<%= b.get("id") %>"><%= b.get("label") %></option>
                <% } %>
            </select>
        </div>

        <div class="col-md-6">
            <label for="return_date" class="form-label">Return Date</label>
            <input type="date" name="return_date" class="form-control" required>
        </div>

        <div class="col-md-6">
            <label for="staff_id" class="form-label">Returned By Staff</label>
            <select name="staff_id" class="form-select" required>
                <option value="" disabled selected>Select Staff</option>
                <% for(Map<String, String> s : staffList) { %>
                    <option value="<%= s.get("id") %>"><%= s.get("name") %></option>
                <% } %>
            </select>
        </div>

        <div class="col-12 d-flex justify-content-between mt-4">

            
            <button type="submit" class="btn btn-primary" id="submitBtn">💾 Add Record</button>
            <a href="return_history.jsp" class="btn btn-secondary">❌ Cancel</a>
        </div>
    </form>
            
</div>
            
  </main>
            
                <!-- Footer -->
    <footer class="text-center fooder">
        <div class="container">
            <p class="mb-1">&copy; 2025 G4 Library Management System. All rights reserved.</p>
            <small>Designed by G4 Team - Powered by JSP + Servlet + MySQL</small>
        </div>
    </footer>
</body>
</html>


