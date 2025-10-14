<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Entete--->
<!-- Page Header -->
<div class="flex justify-between items-center mb-6">
    <div>
        <h1 class="text-3xl font-bold">Specialties Management</h1>
        <p class="text-gray mt-2">Manage medical specialties and their configurations</p>
    </div>
    <button id="add-specialty-btn" class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
        <i class="fas fa-plus"></i>
        Add Specialty
    </button>
</div>

<!-- Specialties Table -->
<div class="bg-white rounded-xl shadow-card overflow-hidden">
    <div class="flex justify-between items-center p-6 border-b border-gray-light">
        <h3 class="text-lg font-semibold">Medical Specialties</h3>
        <div class="flex gap-3">
            <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                <i class="fas fa-filter"></i>
                Filter
            </button>
            <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                <i class="fas fa-download"></i>
                Export
            </button>
        </div>
    </div>
    <div class="overflow-x-auto">
        <table class="w-full">
            <thead>
            <tr class="bg-gray-50">
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Nom</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Description</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Code</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Departement</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-light" id="specialties-table-body">
            <!-- Les données des spécialités seront chargées ici dynamiquement -->
            </tbody>
        </table>
    </div>
</div>

<!-- Specialty Modal -->
<div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="specialtyModal">
    <div class="bg-white rounded-xl w-[90%] max-w-xl max-h-[90vh] shadow-2xl">
        <!-- Header -->
        <div class="flex justify-between items-center p-4 border-b border-gray-light">
            <h3 class="text-lg font-semibold" id="modal-title">Add New Specialty</h3>
            <button class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
        </div>

        <!-- Body -->
        <div class="p-4">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium mb-1">Specialty Name *</label>
                    <input type="text" id="specialty-name" class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty name">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Specialty Code *</label>
                    <input type="text" id="specialty-code" class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty code">
                </div>
            </div>

            <div class="mt-4">
                <label class="block text-sm font-medium mb-1">Department *</label>
                <select id="specialty-department" class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                    <option value="">Select Department</option>
                    <option value="Cardiology">Cardiology</option>
                    <option value="Orthopedics">Orthopedics</option>
                    <option value="Pediatrics">Pediatrics</option>
                    <option value="Neurology">Neurology</option>
                    <option value="Dermatology">Dermatology</option>
                    <option value="Oncology">Oncology</option>
                    <option value="Surgery">Surgery</option>
                </select>
            </div>
            <div class="mt-4">
                <label class="block text-sm font-medium mb-1">Description</label>
                <textarea id="specialty-description" class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty description" rows="3"></textarea>
            </div>

            <div class="mt-4">
                <label class="block text-sm font-medium mb-1">Status</label>
                <div class="flex gap-4">
                    <label class="flex items-center text-sm">
                        <input type="radio" id="status-active" name="status" value="active" class="mr-2" checked>
                        <span class="flex items-center"><span class="w-2.5 h-2.5 bg-success rounded-full mr-1.5"></span>Active</span>
                    </label>
                    <label class="flex items-center text-sm">
                        <input type="radio" id="status-inactive" name="status" value="inactive" class="mr-2">
                        <span class="flex items-center"><span class="w-2.5 h-2.5 bg-danger rounded-full mr-1.5"></span>Inactive</span>
                    </label>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="flex justify-end gap-3 p-4 border-t border-gray-light bg-gray-50 sticky bottom-0">
            <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium hover:bg-gray-100 transition-colors duration-300" id="cancel-btn">Cancel</button>
            <button class="bg-primary text-white px-4 py-2 rounded-lg font-medium hover:bg-green-500 transition-colors duration-300" id="save-btn">Save Specialty</button>
        </div>
    </div>
</div>

<script>
    // Récupérer les éléments
    const modal = document.getElementById("specialtyModal");
    const openBtn = document.getElementById("add-specialty-btn");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");

    // 🔹 Ouvrir le modal
    openBtn.addEventListener("click", () => {
        modal.classList.remove("hidden");
    });

    // 🔹 Fermer le modal avec le bouton "x"
    closeBtn.addEventListener("click", () => {
        modal.classList.add("hidden");
    });

    // 🔹 Fermer le modal avec le bouton "Cancel"
    cancelBtn.addEventListener("click", () => {
        modal.classList.add("hidden");
    });

    // 🔹 Fermer le modal si on clique à l’extérieur du contenu
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.classList.add("hidden");
        }
    });
</script>
