<!-- Sidebar -->
<div class="w-64 bg-dark text-white fixed h-screen overflow-y-auto z-50 transition-all duration-300">
    <div class="p-6 border-b border-white/10 flex items-center gap-3">
        <i class="fas fa-clinic-medical text-primary text-xl"></i>
        <h2 class="text-xl font-semibold">ClinicDoctor</h2>
    </div>
    <nav class="py-4">
        <ul>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-primary bg-white/10 text-white transition-all duration-300">
                    <i class="fas fa-tachometer-alt w-5 text-center mr-3"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/doctor/patients" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-users w-5 text-center mr-3"></i>
                    <span>Patient Management</span>
                </a>
            </li>
            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/doctor/availibility" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-circle w-5 text-center mr-3"></i>
                    <span>Availibility Management</span>
                </a>
            </li>


            <li class="mb-1">
                <a href="${pageContext.request.contextPath}/logout" class="flex items-center px-6 py-3 text-white/80 hover:text-white hover:bg-white/10 border-l-4 border-transparent transition-all duration-300">
                    <i class="fas fa-cog w-5 text-center mr-3"></i>
                    <span>Deconnecter</span>
                </a>
            </li>
        </ul>
    </nav>
</div>