<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 22:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Dashboard Cards -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
    <!-- Total Appointments Card -->
    <div class="bg-white rounded-xl shadow-card p-6 transition-all duration-300 hover:shadow-card-hover hover:-translate-y-1">
        <div class="flex justify-between items-center mb-4">
            <div class="text-gray text-sm font-medium">Total Appointments</div>
            <div class="w-12 h-12 rounded-xl bg-primary/10 text-primary flex items-center justify-center text-xl">
                <i class="fas fa-calendar-check"></i>
            </div>
        </div>
        <div class="text-3xl font-bold mb-2">1,248</div>
        <div class="text-success text-sm flex items-center gap-1">
            <i class="fas fa-arrow-up"></i>
            12% from last week
        </div>
    </div>

    <%--                <!-- Cancellations Card -->--%>
    <div class="bg-white rounded-xl shadow-card p-6 transition-all duration-300 hover:shadow-card-hover hover:-translate-y-1">
        <div class="flex justify-between items-center mb-4">
            <div class="text-gray text-sm font-medium">Cancellations</div>
            <div class="w-12 h-12 rounded-xl bg-danger/10 text-danger flex items-center justify-center text-xl">
                <i class="fas fa-times-circle"></i>
            </div>
        </div>
        <div class="text-3xl font-bold mb-2">47</div>
        <div class="text-danger text-sm flex items-center gap-1">
            <i class="fas fa-arrow-down"></i>
            5% from last week
        </div>
    </div>

    <!-- Occupancy Rate Card -->
    <div class="bg-white rounded-xl shadow-card p-6 transition-all duration-300 hover:shadow-card-hover hover:-translate-y-1">
        <div class="flex justify-between items-center mb-4">
            <div class="text-gray text-sm font-medium">Occupancy Rate</div>
            <div class="w-12 h-12 rounded-xl bg-success/10 text-success flex items-center justify-center text-xl">
                <i class="fas fa-bed"></i>
            </div>
        </div>
        <div class="text-3xl font-bold mb-2">78%</div>
        <div class="text-success text-sm flex items-center gap-1">
            <i class="fas fa-arrow-up"></i>
            3% from last week
        </div>
    </div>

    <!-- Active Users Card -->
    <div class="bg-white rounded-xl shadow-card p-6 transition-all duration-300 hover:shadow-card-hover hover:-translate-y-1">
        <div class="flex justify-between items-center mb-4">
            <div class="text-gray text-sm font-medium">Active Users</div>
            <div class="w-12 h-12 rounded-xl bg-secondary/10 text-secondary flex items-center justify-center text-xl">
                <i class="fas fa-user-md"></i>
            </div>
        </div>
        <div class="text-3xl font-bold mb-2">84</div>
        <div class="text-success text-sm flex items-center gap-1">
            <i class="fas fa-arrow-up"></i>
            2 new this month
        </div>
    </div>
</div>

<!-- Charts -->
<div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
    <!-- Appointment Trends Chart -->
    <div class="bg-white rounded-xl shadow-card p-6 lg:col-span-2">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-lg font-semibold">Appointment Trends</h3>
            <select class="border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                <option>Last 7 days</option>
                <option>Last 30 days</option>
                <option>Last 3 months</option>
            </select>
        </div>
        <canvas id="appointmentsChart" height="250"></canvas>
    </div>

    <!-- Department Distribution Chart -->
    <div class="bg-white rounded-xl shadow-card p-6">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-lg font-semibold">Department Distribution</h3>
        </div>
        <canvas id="departmentsChart" height="250"></canvas>
    </div>
</div>

</body>
</html>
