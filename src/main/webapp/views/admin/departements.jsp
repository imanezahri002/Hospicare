<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Page Header -->
<div class="flex justify-between items-center mb-6">
    <div>
        <h1 class="text-3xl font-bold">Departments Management</h1>
        <p class="text-gray mt-2">Manage hospital departments and medical specialties</p>
    </div>
    <button id="add-department-btn" class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
        <i class="fas fa-plus"></i>
        Add Department
    </button>
</div>

<!-- Departments Table -->
<div class="bg-white rounded-xl shadow-card overflow-hidden">
    <div class="flex justify-between items-center p-6 border-b border-gray-light">
        <h3 class="text-lg font-semibold">Hospital Departments</h3>
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
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-light" id="departments-table-body">
            <!-- Les données des départements seront chargées ici dynamiquement -->
            <c:forEach var="departement" items="${departements}">
                <tr>
                    <td class="py-4 px-6 px-6 text-gray text-s">${departement.nom}</td>
                    <td class="py-4 px-6 px-6 text-gray text-s">${departement.code}</td>
                    <td class="py-4 px-6 px-6 text-gray text-s">${departement.description}</td>
                    <td class="py-4 px-6 text-gray text-s"><c:choose>
                        <c:when test="${departement.is_active}">
                            <span class="px-2 py-1 rounded-full bg-green-500 text-white">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="px-2 py-1 rounded-full bg-red-500 text-white">Inactive</span>
                        </c:otherwise>
                    </c:choose></td>
                    <td class="py-4 px-6">
                        <div class="flex gap-2">
                            <button class="text-gray hover:text-primary transition-colors duration-200 edit-btn"
                                    data-id="${departement.id}"
                                    data-name="${departement.nom}"
                                    data-code="${departement.code}"
                                    data-description="${departement.description}"
                                    data-status="${departement.is_active}">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="text-gray hover:text-danger transition-colors duration-200 delete-btn" data-id="${departement.id}">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Department Modal -->
<div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="departementModal">
    <div class="bg-white rounded-xl w-[90%] max-w-xl max-h-[90vh] overflow-y-auto shadow-2xl">

        <!-- 🧾 Formulaire -->
        <form action="/addDepartment" method="post" id="department-form">
            <input type="hidden" name="id" id="department-id">
            <!-- Header -->
            <div class="flex justify-between items-center p-4 border-b border-gray-light">
                <h3 class="text-lg font-semibold" id="modal-title">Add New Department</h3>
                <button type="button" class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
            </div>

            <!-- Body -->
            <div class="p-4">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="department-name" class="block text-sm font-medium mb-1">Department Name *</label>
                        <input type="text" name="name" id="department-name"
                               class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary"
                               placeholder="Enter department name" required>
                    </div>
                    <div>
                        <label for="department-code" class="block text-sm font-medium mb-1">Department Code *</label>
                        <input type="text" name="code" id="department-code"
                               class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary"
                               placeholder="Enter department code" required>
                    </div>
                </div>

                <div class="mt-4">
                    <label for="department-description" class="block text-sm font-medium mb-1">Description</label>
                    <textarea name="description" id="department-description"
                              class="w-full border border-gray-light rounded-lg px-3 py-2 outline-none focus:border-primary focus:ring-1 focus:ring-primary"
                              placeholder="Enter department description" rows="3"></textarea>
                </div>

                <div class="mt-4">
                    <label class="block text-sm font-medium mb-1">Status</label>
                    <div class="flex gap-4">
                        <label class="flex items-center text-sm">
                            <input type="radio" name="status" value="active" class="mr-2" checked>
                            <span class="flex items-center">
                                <span class="w-2.5 h-2.5 bg-success rounded-full mr-1.5"></span>Active
                            </span>
                        </label>
                        <label class="flex items-center text-sm">
                            <input type="radio" name="status" value="inactive" class="mr-2">
                            <span class="flex items-center">
                                <span class="w-2.5 h-2.5 bg-danger rounded-full mr-1.5"></span>Inactive
                            </span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="flex justify-end gap-3 p-4 border-t border-gray-light bg-gray-50 sticky bottom-0">
                <button type="button" class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium hover:bg-gray-100 transition-colors duration-300" id="cancel-btn">Cancel</button>
                <button  id="submit-btn" type="submit" class="bg-primary text-white px-4 py-2 rounded-lg font-medium hover:bg-green-500 transition-colors duration-300">Save Department</button>
            </div>
        </form>
    </div>
</div>

<script>
    const modal = document.getElementById("departementModal");
    const openBtn = document.getElementById("add-department-btn");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");

    const form = document.getElementById("department-form");
    const modalTitle = document.getElementById("modal-title");
    const submitBtn = document.getElementById("submit-btn");

    const idInput = document.getElementById("department-id");
    const nameInput = document.getElementById("department-name");
    const codeInput = document.getElementById("department-code");
    const descInput = document.getElementById("department-description");
    const statusInputs = document.querySelectorAll('input[name="status"]');

    // 🔹 Ouvrir le modal pour AJOUTER
    openBtn.addEventListener("click", () => {
        form.reset(); // vide les champs
        idInput.value = ""; // pas d'ID
        modalTitle.textContent = "Add New Department";
        submitBtn.textContent = "Save Department";
        form.action = "/addDepartment"; // action servlet d'ajout

        modal.classList.remove("hidden");
    });

    // 🔹 Fermer le modal
    [closeBtn, cancelBtn].forEach(btn => {
        btn.addEventListener("click", () => modal.classList.add("hidden"));
    });

    window.addEventListener("click", (e) => {
        if (e.target === modal) modal.classList.add("hidden");
    });

    // 🔹 Ouvrir le modal pour EDITER
    document.querySelectorAll(".edit-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.dataset.id;
            const name = btn.dataset.name;
            const code = btn.dataset.code;
            const description = btn.dataset.description;
            const status = btn.dataset.status === "true";

            // Remplir les champs
            idInput.value = id;
            nameInput.value = name;
            codeInput.value = code;
            descInput.value = description;

            // Sélectionner le bon statut
            statusInputs.forEach(input => {
                input.checked = (status && input.value === "active") ||
                    (!status && input.value === "inactive");
            });

            // Modifier le texte et action
            modalTitle.textContent = "Edit Department";
            submitBtn.textContent = "Update Department";
            form.action = "/addDepartment"; // servlet update

            modal.classList.remove("hidden");
        });
    });
    document.querySelectorAll(".delete-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.dataset.id;
            if (confirm("Are you sure you want to delete this department?")) {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "/deleteDepartment";

                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "id";
                input.value = id;

                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        });
    });

</script>

