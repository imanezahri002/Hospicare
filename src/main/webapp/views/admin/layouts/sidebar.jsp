<!-- Sidebar -->
<div class="w-64 bg-dark text-white fixed h-screen overflow-y-auto z-50 transition-all duration-300">
    <div class="p-6 border-b border-white/10 flex items-center gap-3">
        <i class="fas fa-clinic-medical text-primary text-xl"></i>
        <h2 class="text-xl font-semibold">ClinicAdmin</h2>
    </div>
    <nav class="py-4">
        <ul>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-primary bg-white/10 text-white transition-all duration-300">
                    <i class="fas fa-tachometer-alt w-5 text-center mr-3"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/admin/users" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-users w-5 text-center mr-3"></i>
                    <span>User Management</span>
                </a>
            </li>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/admin/departements" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-sitemap w-5 text-center mr-3"></i>
                    <span>Departments</span>
                </a>
            </li>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/admin/speciality" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-calendar-alt w-5 text-center mr-3"></i>
                    <span>Specialites</span>
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