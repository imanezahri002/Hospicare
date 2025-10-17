<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 16/10/2025
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="layouts/header.jsp"%>
<style>
    .input-focus:focus {
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.2);
    }
    .radio-dot {
        transition: all 0.2s ease;
    }
    .form-section {
        transition: all 0.3s ease;
    }
    .form-section:hover {
        transform: translateY(-2px);
    }
</style>
<%@include file="layouts/sidebar.jsp"%>
<%@include file="layouts/mainHeader.jsp"%>

<main>
    <!-- En-tête -->
    <div class="flex justify-between items-center mb-6">
        <div>
            <h1 class="text-3xl font-bold">Doctors Management</h1>
            <p class="text-gray mt-2">Manage doctors and their information</p>
        </div>
        <button id="add-doctor-btn"
                class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
            <i class="fas fa-plus"></i>
            Add Doctor
        </button>
    </div>

    <!-- Tableau des docteurs -->
    <div class="bg-white rounded-xl shadow-card overflow-hidden">
        <div class="flex justify-between items-center p-6 border-b border-gray-light">
            <h3 class="text-lg font-semibold">Doctors List</h3>
            <div class="flex gap-3">
                <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                    <i class="fas fa-filter"></i> Filter
                </button>
                <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-gray-50">
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Full Name</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Email</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Phone</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">matricule</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Speciality</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
                </tr>
                </thead>

                <tbody class="divide-y divide-gray-light">
                <c:forEach var="doctor" items="${doctors}">

                    <tr>
                        <td class="py-4 px-6">${doctor.fullName}</td>
                        <td class="py-4 px-6">${doctor.email}</td>
                        <td class="py-4 px-6">${doctor.tel}</td>
                        <td class="py-4 px-6">${doctor.matricule}
                        </td>
                        <td class="py-4 px-6">
                            <c:choose>
                                <c:when test="${doctor.speciality != null}">
                                    ${doctor.speciality.nom}
                                </c:when>
                                <c:otherwise>
                                    ----
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="py-4 px-6"><c:choose>
                            <c:when test="${doctor.is_active}">
            <span class="bg-green-100 text-green-800 font-semibold px-3 py-1 rounded-full border border-green-200">
                Active
            </span>
                            </c:when>
                            <c:otherwise>
            <span class="bg-red-100 text-red-800 font-semibold px-3 py-1 rounded-full border border-red-200">
                Inactive
            </span>
                            </c:otherwise>
                        </c:choose></td>
                        <td class="py-4 px-6">
                        <div class="flex gap-2">
                            <button class="text-gray hover:text-primary transition-colors duration-200 edit-btn"
                                    data-id="${doctor.id}"
                                    data-name="${doctor.fullName}"
                                    data-email="${doctor.email}"
                                    data-titre="${doctor.titre}"
                                    data-tel="${doctor.tel}"
                                    data-matricule="${doctor.matricule}"
                                    data-speciali="${doctor.speciality.nom}"
                                    data-status="${doctor.is_active}">

                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="text-gray hover:text-danger transition-colors duration-200 delete-btn">
                                <a href="/admin/doctors?action=delete&id=${doctor.id}">
                                <i class="fas fa-trash"></i>
                                </a>
                            </button>
                        </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Docteur -->
    <div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="doctorModal">
        <div class="bg-white rounded-xl w-[90%] max-w-xl max-h-[90vh] shadow-2xl">
            <!-- Header -->
            <div class="flex justify-between items-center p-4 border-b border-gray-light">
                <h3 class="text-lg font-semibold" id="modal-title">Add New Doctor</h3>
                <button class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
            </div>

            <!-- Formulaire -->
            <div class="p-6 bg-gradient-to-b from-gray-50 to-white rounded-2xl max-h-[80vh] overflow-y-auto pr-3">
                <h2 class="text-xl font-semibold text-gray-800 flex items-center gap-2 mb-4">
                    <i class="fas fa-user-md text-green-500"></i>
                    Gestion des médecins
                </h2>

                <form id="doctor-form" class="space-y-6" action="${pageContext.request.contextPath}/admin/doctors?action=create" method="post">
                    <input type="hidden" id="doctor-id" name="id">

                    <!-- Informations personnelles -->
                    <div class="form-section bg-white p-4 rounded-lg border border-gray-200 shadow-sm">
                        <h3 class="text-base font-medium text-gray-800 mb-3 flex items-center gap-2">
                            <i class="fas fa-id-card text-green-500"></i>
                            Informations personnelles
                        </h3>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Nom complet -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Nom complet *</label>
                                <div class="relative">
                                    <i class="fas fa-user absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="text" id="doctor-name" name="full_name" required
                                           class="pl-9 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Matricule*</label>
                                <div class="relative">
                                    <i class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="text" id="matricule" name="matricule" required
                                           class="pl-1 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Titre*</label>
                                <div class="relative">
                                    <i class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="text" id="titre" name="titre" required
                                           class="pl-1 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>
                            </div>

                            <!-- Email -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                                <div class="relative">
                                    <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="email" id="doctor-email" name="email" required
                                           class="pl-9 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>
                            </div>

                            <!-- Téléphone -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Téléphone</label>
                                <div class="relative">
                                    <i class="fas fa-phone absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="tel" id="doctor-phone" name="telephone"
                                           class="pl-9 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>

                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="password" id="password" name="password" required
                                           class="pl-9 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Informations professionnelles -->
                    <div class="form-section bg-white p-4 rounded-lg border border-gray-200 shadow-sm">
                        <h3 class="text-base font-medium text-gray-800 mb-3 flex items-center gap-2">
                            <i class="fas fa-stethoscope text-green-500"></i>
                            Informations professionnelles
                        </h3>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Spécialité -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Spécialité</label>
                                <div class="relative">
                                    <i class="fas fa-heartbeat absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <select id="speciality" name="speciality_id"
                                            class="pl-9 w-full border border-gray-300 rounded-md py-2 focus:border-green-500 focus:ring-1 focus:ring-green-200 transition duration-200 text-sm appearance-none">

                                        <c:forEach var="speciality" items="${specialities}">
                                            <option value="${speciality.id}">${speciality.nom}</option>
                                        </c:forEach>

                                    </select>
                                    <i class="fas fa-chevron-down absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                                </div>
                            </div>

                            <!-- Statut -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Statut</label>
                                <div class="flex items-center gap-4 mt-1">
                                    <label class="flex items-center gap-1 cursor-pointer">
                                        <input type="radio" name="status" value="active" checked class="accent-green-500 text-sm">
                                        <span class="text-gray-700 text-sm">Actif</span>
                                    </label>
                                    <label class="flex items-center gap-1 cursor-pointer">
                                        <input type="radio" name="status" value="inactive" class="accent-red-500 text-sm">
                                        <span class="text-gray-700 text-sm">Inactif</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Boutons -->
                    <div class="flex justify-end gap-3 pt-2">
                        <button type="button" id="cancel-btn"
                                class="px-4 py-2 rounded-md border border-gray-300 text-gray-700 hover:bg-gray-50 transition duration-200 text-sm">
                            <i class="fas fa-times mr-1"></i> Annuler
                        </button>
                        <button type="submit"
                                class="bg-green-500 text-white px-5 py-2 rounded-md font-medium hover:bg-green-600 transition duration-200 text-sm shadow-sm">
                            <i class="fas fa-save mr-1"></i> Enregistrer
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<%@include file="layouts/footer.jsp"%>

<script>
    const modal = document.getElementById("doctorModal");
    const openBtn = document.getElementById("add-doctor-btn");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");
    const form = document.getElementById("doctor-form");
    const modalTitle = document.getElementById("modal-title");
    const idInput = document.getElementById("doctor-id");
    const nameInput = document.getElementById("doctor-name");
    const emailInput = document.getElementById("doctor-email");
    const phoneInput = document.getElementById("doctor-phone");
    const matriculeInput = document.getElementById("matricule");
    const titreInput = document.getElementById("titre");
    const specialityInput = document.getElementById("speciality");
    const statusRadios = form.querySelectorAll('input[name="status"]');

    // Ouvrir modal pour ajouter un nouveau docteur
    openBtn.addEventListener("click", () => {
        modal.classList.remove("hidden");
        modalTitle.textContent = "Add New Doctor";
        idInput.value = "";
        form.reset();
        form.action = `${window.location.pathname}?action=create`; // définit l'action create
    });

    // Ouvrir modal pour modifier un docteur
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", () => {
            modal.classList.remove("hidden");
            modalTitle.textContent = "Edit Doctor";

            // Remplir les inputs
            idInput.value = button.dataset.id;
            nameInput.value = button.dataset.name;
            emailInput.value = button.dataset.email;
            phoneInput.value = button.dataset.tel;
            matriculeInput.value = button.dataset.matricule;
            titreInput.value = button.dataset.titre || "";
            specialityInput.value = button.dataset.speciali;

            // Statut actif/inactif
            const status = button.dataset.status === "true" || button.dataset.status === "1" ? "active" : "inactive";
            statusRadios.forEach(radio => radio.checked = radio.value === status);

            // Définir l'action du formulaire

            form.action = `${window.location.pathname}?action=update`;

        });
    });


    // Fermer le modal
    [closeBtn, cancelBtn].forEach(btn => btn.addEventListener("click", () => modal.classList.add("hidden")));

    window.addEventListener("click", (e) => {
        if (e.target === modal) modal.classList.add("hidden");
    });

</script>

