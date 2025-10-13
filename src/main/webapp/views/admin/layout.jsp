<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinic Management - Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3dd1a8',
                        'primary-light': '#a8f0dc',
                        secondary: '#8338ec',
                        success: '#06d6a0',
                        warning: '#ffd166',
                        danger: '#ef476f',
                        dark: '#1a1a2e',
                        light: '#f8f9fa',
                        gray: {
                            DEFAULT: '#6c757d',
                            light: '#e9ecef'
                        }
                    },
                    boxShadow: {
                        'card': '0 4px 12px rgba(0, 0, 0, 0.08)',
                        'card-hover': '0 8px 16px rgba(0, 0, 0, 0.1)'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 font-sans text-dark">
<div class="flex min-h-screen">
    <!-- Sidebar -->
    <div class="w-64 bg-dark text-white fixed h-screen overflow-y-auto z-50 transition-all duration-300">
        <div class="p-6 border-b border-white/10 flex items-center gap-3">
            <i class="fas fa-clinic-medical text-primary text-xl"></i>
            <h2 class="text-xl font-semibold">ClinicAdmin</h2>
        </div>
        <nav class="py-4">
            <ul>
                <li class="mb-1">
                    <a href="${pageContext.request.contextPath}/controller?page=dashboard" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-primary bg-white/10 text-white transition-all duration-300">
                        <i class="fas fa-tachometer-alt w-5 text-center mr-3"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="mb-1">
                    <a href="controller?page=users" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                        <i class="fas fa-users w-5 text-center mr-3"></i>
                        <span>User Management</span>
                    </a>
                </li>
                <li class="mb-1">
                    <a href="controller?page=departements" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                        <i class="fas fa-sitemap w-5 text-center mr-3"></i>
                        <span>Departments</span>
                    </a>
                </li>
                <li class="mb-1">
                    <a href="${pageContext.request.contextPath}/controller?page=speciality" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                        <i class="fas fa-calendar-alt w-5 text-center mr-3"></i>
                        <span>Spécialités</span>
                    </a>
                </li>
                <li class="mb-1">
                    <a href="#" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                        <i class="fas fa-cog w-5 text-center mr-3"></i>
                        <span>Deconnecter</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 ml-64 transition-all duration-300">
        <!-- Topbar -->
        <div class="bg-white p-4 flex justify-between items-center shadow-sm sticky top-0 z-40">
            <div class="flex items-center bg-light rounded-lg px-4 py-2 w-80">
                <i class="fas fa-search text-gray mr-3"></i>
                <input type="text" placeholder="Search..." class="bg-transparent border-none outline-none w-full">
            </div>
            <div class="flex items-center gap-4">
                <div class="relative">
                    <i class="fas fa-bell text-gray cursor-pointer"></i>
                    <span class="absolute -top-1 -right-1 bg-danger text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">3</span>
                </div>
                <div class="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-semibold">AD</div>
            </div>
        </div>

        <!-- Content -->
        <div class="p-6">
            <!-- Alert -->
<%--            <div class="bg-green-50 text-success p-4 rounded-lg mb-6 flex items-center gap-3 border-l-4 border-success">--%>
<%--                <i class="fas fa-check-circle"></i>--%>
<%--                <p>System updated successfully. 3 new appointments scheduled today.</p>--%>
<%--            </div>--%>

            <!-- Page Header -->
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold">Admin Dashboard</h1>
<%--                <button class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">--%>
<%--                    <i class="fas fa-plus"></i>--%>
<%--                    New User--%>
<%--                </button>--%>
            </div>
            <main>
                <jsp:include page="${contentPage}" />

            </main>

        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/js/adminDashboard.js"></script>

</body>
</html>
