<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="layouts/header.jsp"%>
<%@include file="layouts/sidebar.jsp"%>
<%@include file="layouts/mainHeader.jsp"%>

<!-- Dashboard Cards -->
<main>
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
            <c:forEach var="speciality" items="${specialities}">
                <tr>
                    <td class="py-4 px-6">${speciality.nom}</td>
                    <td class="py-4 px-6">${speciality.description}</td>
                    <td class="py-4 px-6">${speciality.code}</td>
                    <td class="py-4 px-6">${speciality.departement.nom}</td>
                    <td class="py-4 px-6">
            <span class="${speciality.is_active ? 'text-green-600' : 'text-red-600'} font-semibold">
                    ${speciality.is_active ? 'Active' : 'Inactive'}
            </span>
                    </td>
                    <td class="py-4 px-6 flex gap-2">
                        <button class="text-gray hover:text-primary transition-colors duration-200 edit-btn"
                                data-id="${speciality.id}"
                                data-name="${speciality.nom}"
                                data-code="${speciality.code}"
                                data-description="${speciality.description}"
                                data-department="${speciality.departement.id}"
                                data-status="${speciality.is_active}">
                            <i class="fas fa-edit"></i>
                        </button>
                        <a href="specialities?action=delete&id=${speciality.id}"
                           class="text-red-600 hover:underline"
                           onclick="return confirm('Are you sure you want to delete this specialty?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
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



<%--        <form action="${pageContext.request.contextPath}/admin/specialities" method="post">--%>
            <form id="specialty-form" action="${pageContext.request.contextPath}/admin/specialities?action=create" method="post">

            <input type="hidden" name="action" value="create" id="action">
                <input type="hidden" name="id" id="specialty-id">

            <div class="p-4">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium mb-1">Specialty Name *</label>
                        <input type="text" name="name" id="specialty-name" required
                               class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-1">Specialty Code *</label>
                        <input type="text" name="code" id="specialty-code" required
                               class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                    </div>
                </div>

                <div class="mt-4">
                    <label class="block text-sm font-medium mb-1">Department *</label>
                    <select name="departmentId" id="specialty-department"
                            class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary" required>
                        <option value="">Select Departement</option>
                        <c:forEach var="dep" items="${departements}">
                            <option value="${dep.id}" >${dep.nom}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mt-4">
                    <label class="block text-sm font-medium mb-1">Description</label>
                    <textarea name="description" id="specialty-description"
                              class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary"
                              rows="3"></textarea>
                </div>

                <div class="mt-4">
                    <label class="block text-sm font-medium mb-1">Status</label>
                    <div class="flex gap-4">
                        <label class="flex items-center text-sm">
                            <input type="radio" name="status" value="active" class="mr-2" checked>
                            <span class="flex items-center"><span class="w-2.5 h-2.5 bg-success rounded-full mr-1.5"></span>Active</span>
                        </label>
                        <label class="flex items-center text-sm">
                            <input type="radio" name="status" value="inactive" class="mr-2">
                            <span class="flex items-center"><span class="w-2.5 h-2.5 bg-danger rounded-full mr-1.5"></span>Inactive</span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="flex justify-end gap-3 p-4 border-t border-gray-light bg-gray-50 sticky bottom-0">
                <button type="button" class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium hover:bg-gray-100 transition-colors duration-300" id="cancel-btn">Cancel</button>
                <button type="submit" class="bg-primary text-white px-4 py-2 rounded-lg font-medium hover:bg-green-500 transition-colors duration-300">Save Specialty</button>
            </div>
        </form>

    </div>
</div>
</main>
<%@include file="layouts/footer.jsp"%>
<script>
    // Récupération des éléments
    const modal = document.getElementById("specialtyModal");
    const openBtn = document.getElementById("add-specialty-btn");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");
    const form = document.getElementById("specialty-form");
    const modalTitle = document.getElementById("modal-title");
    const formActionInput = document.getElementById("action");

    const idInput = document.getElementById("specialty-id");

    // Inputs du formulaire
    const nameInput = document.getElementById("specialty-name");
    const codeInput = document.getElementById("specialty-code");
    const departmentInput = document.getElementById("specialty-department");
    const descriptionInput = document.getElementById("specialty-description");

    // 🔹 Ouvrir le modal pour ajouter
    openBtn.addEventListener("click", () => {
        modal.classList.remove("hidden");
        modalTitle.textContent = "Add New Specialty";
        formActionInput.value = "create";
        idInput.value = "";

        // Réinitialiser les inputs
        nameInput.value = "";
        codeInput.value = "";
        departmentInput.value = "";
        descriptionInput.value = "";
        form.querySelector('input[name="status"][value="active"]').checked = true;
    });

    // 🔹 Ouvrir le modal pour éditer
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", () => {
            modal.classList.remove("hidden");
            modalTitle.textContent = "Edit Specialty";

            // Remplir le formulaire avec les données de la ligne
            idInput.value = button.dataset.id;
            nameInput.value = button.dataset.name;
            codeInput.value = button.dataset.code;
            descriptionInput.value = button.dataset.description;
            departmentInput.value = button.dataset.department;
            const status = button.dataset.status === "true" ? "active" : "inactive";
            form.querySelector(`input[name="status"][value="${status}"]`).checked = true;

            formActionInput.value = "update";
            form.action = window.location.pathname + "?action=update";

        });
    });

    // 🔹 Fermer le modal
    [closeBtn, cancelBtn].forEach(btn => {
        btn.addEventListener("click", () => modal.classList.add("hidden"));
    });

    // 🔹 Fermer si clic à l’extérieur du modal
    window.addEventListener("click", (e) => {
        if (e.target === modal) modal.classList.add("hidden");
    });

</script>


