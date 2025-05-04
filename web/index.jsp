<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Management System Dashboard</title>
    
    <!-- Bootstrap CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Google Font -->
    <link href="fonts/fonts.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

    <style>
        
        
        
        html,body {
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

        .navbar {
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .dashboard-title {
            font-weight: 700;
            font-size: 2.5rem;
            padding: 50px 0 20px;
            color: #1e3a8a;
        }

        .section-title {
            font-weight: 600;
            font-size: 1.5rem;
            margin-bottom: 30px;
            color: #374151;
        }

        .card-button {
            background-color: #ffffff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .card-button:hover {
            background-color: #e0f0ff;
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        footer {
            background-color: #e5e7eb;
            font-size: 0.9rem;
            color: #4b5563;
            padding: 20px 0;
            margin-top: 60px;
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
                        <a class="nav-link active" aria-current="page" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Reports</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Settings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="#">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main>
    <!-- Title -->
    <div class="container text-center">
        <h1 class="dashboard-title">📚 Dashboard</h1>
    </div>

    <!-- Dashboard Cards -->
    <div class="container">
        <h3 class="section-title">👥 List of Us</h3>
        <div class="row gx-4 gy-4 text-center">
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">📘 Members</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">📚 Books</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">📝 Reservations</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">🔁 Borrow Book</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="returnHistory/return_history.jsp" class="card-button d-block text-decoration-none text-dark fw-semibold">📥 Return History</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">💰 Fine</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">👤 Staff</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">🖊️ Authors</a>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <a href="#" class="card-button d-block text-decoration-none text-dark fw-semibold">📎 Book Author</a>
            </div>
        </div>
    </div>
</main>
    <!-- Bootstrap JS -->
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p class="mb-1">&copy; 2025 G4 Library Management System. All rights reserved.</p>
            <small>Designed by G4 Team - Powered by JSP + Servlet + MySQL</small>
        </div>
    </footer>

</body>
</html>
