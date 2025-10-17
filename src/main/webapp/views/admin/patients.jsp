<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="layouts/header.jsp"%>
<%@include file="layouts/sidebar.jsp"%>
<%@include file="layouts/mainHeader.jsp"%>

<!-- Dashboard Cards -->
<main>
    <!-- En-tête -->
    <div class="flex justify-between items-center mb-6">
        <div>
            <h1 class="text-3xl font-bold">Patients Management</h1>
            <p class="text-gray mt-2">Manage patients and their information</p>
        </div>
        <button id="add-patient-btn"
                class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
            <i class="fas fa-plus"></i>
            Add Patient
        </button>
    </div>

    <!-- Tableau des patients -->
    <div class="bg-white rounded-xl shadow-card overflow-hidden">
        <div class="flex justify-between items-center p-6 border-b border-gray-light">
            <h3 class="text-lg font-semibold">Patients List</h3>
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
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">FullName</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">CIN</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Email</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Tél</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Date de Naissance</th>

                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Groupe sanguin</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Sexe</th>

                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                    <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
                </tr>
                </thead>

                <tbody class="divide-y divide-gray-light" id="patients-table-body">
                <c:forEach var="patient" items="${patients}">
                    <tr>
                        <td class="py-4 px-6">${patient.full_name}</td>
                        <td class="py-4 px-6">${patient.cin}</td>
                        <td class="py-4 px-6">${patient.email}</td>
                        <td class="py-4 px-6">${patient.telephone}</td>
                        <td class="py-4 px-6">${patient.birthdate}</td>
                        <td class="py-4 px-6">${patient.groupe_sanguin}</td>
                        <td class="py-4 px-6">${patient.sexe}</td>


                        <td class="py-4 px-6">
                            <span class="${patient.is_active ? 'text-green-600' : 'text-red-600'} font-semibold">
                                    ${patient.is_active ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td class="py-4 px-6 flex gap-2">
                            <button class="text-gray hover:text-primary transition-colors duration-200 edit-btn"
                                    data-id="${patient.id}"
                                    data-nom="${patient.nom}"
                                    data-prenom="${patient.prenom}"
                                    data-email="${patient.email}"
                                    data-telephone="${patient.telephone}"
                                    data-date="${patient.dateNaissance}"
                                    data-status="${patient.is_active}">
                                <i class="fas fa-edit"></i>
                            </button>
                            <a href="patients?action=delete&id=${patient.id}"
                               class="text-red-600 hover:underline"
                               onclick="return confirm('Are you sure you want to delete this patient?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Patient -->
    <div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="patientModal">
        <div class="bg-white rounded-xl w-[90%] max-w-xl max-h-[90vh] shadow-2xl">
            <!-- Header -->
            <div class="flex justify-between items-center p-4 border-b border-gray-light">
                <h3 class="text-lg font-semibold" id="modal-title">Add New Patient</h3>
                <button class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
            </div>

            <!-- Formulaire d'inscription -->
            <div class="p-6 md:p-8 mobile-padding">
                <form id="registerForm" class="space-y-4 md:space-y-6 mobile-space" action="/register" method="post">
                    <!-- Champs communs -->
                    <div>
                        <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Nom complet</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-medical-400"></i>
                            </div>
                            <input type="text" id="fullName" name="fullName" required
                                   class="form-input block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="Votre nom complet">
                        </div>
                    </div>

                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Adresse email</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-medical-400"></i>
                            </div>
                            <input type="email" id="email" name="email" required
                                   class="form-input block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="votre@email.com">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mobile-grid">
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mot de passe</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-lock text-medical-400"></i>
                                </div>
                                <input type="password" id="password" name="password" required
                                       class="form-input block w-full pl-10 pr-10 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                       placeholder="Votre mot de passe">

                                <input type="hidden" name="role" value="PATIENT">

                                <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                    <i class="fas fa-eye text-medical-400"></i>
                                </button>
                            </div>
                        </div>

                    </div>

                    <!-- Champs spécifiques au patient (toujours visibles) -->
                    <h3 class="text-lg font-medium text-medical-600 border-b pb-2">Informations personnelles</h3>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="cin" class="block text-sm font-medium text-gray-700 mb-1">CIN</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-id-card text-medical-400"></i>
                                </div>
                                <input type="text" id="cin" name="cin"
                                       class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                       placeholder="Votre CIN">
                            </div>
                        </div>

                        <div>
                            <label for="birthDate" class="block text-sm font-medium text-gray-700 mb-1">Date de naissance</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-calendar-alt text-medical-400"></i>
                                </div>
                                <input type="date" id="birthDate" name="birthDate"
                                       class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all">
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="bloodGroup" class="block text-sm font-medium text-gray-700 mb-1">Groupe sanguin</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-tint text-medical-400"></i>
                                </div>
                                <select id="bloodGroup" name="bloodGroup"
                                        class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all appearance-none">
                                    <option value="">Sélectionnez votre groupe</option>
                                    <option value="A_POSITIF">A+</option>
                                    <option value="A_NEGATIF">A-</option>
                                    <option value="B_POSITIF">B+</option>
                                    <option value="B_NEGATIF">B-</option>
                                    <option value="AB_POSITIF">AB+</option>
                                    <option value="AB_NEGATIF">AB-</option>
                                    <option value="O_POSITIF">O+</option>
                                    <option value="O_NEGATIF">O-</option>
                                </select>
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                    <i class="fas fa-chevron-down text-medical-400"></i>
                                </div>
                            </div>
                        </div>

                        <div>
                            <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Sexe</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-venus-mars text-medical-400"></i>
                                </div>
                                <select id="sexe" name="sexe"
                                        class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all appearance-none">
                                    <option value="">Sélectionnez votre sexe</option>
                                    <option value="MASCULIN">Masculin</option>
                                    <option value="FEMININ">Féminin</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Adresse</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-home text-medical-400"></i>
                            </div>
                            <input type="text" id="address" name="address"
                                   class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="Votre adresse complète">
                        </div>
                    </div>

                    <div>
                        <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Téléphone</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-phone text-medical-400"></i>
                            </div>
                            <input type="tel" id="phone" name="phone"
                                   class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="Votre numéro de téléphone">
                        </div>
                    </div>

                    <!-- Termes et soumission -->
                    <div class="flex items-start pt-2">
                        <input id="terms" name="terms" type="checkbox" required
                               class="h-4 w-4 text-medical-400 focus:ring-medical-300 border-gray-300 rounded mt-1">
                        <label for="terms" class="ml-2 block text-sm text-gray-700">
                            J'accepte les <a href="#" class="text-medical-500 hover:text-medical-400 transition-all underline">conditions d'utilisation</a>
                        </label>
                    </div>

                    <div class="pt-2">
                        <button type="submit"
                                class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-medical-400 hover:bg-medical-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-medical-300 transition-all transform hover:-translate-y-0.5">
                            <i class="fas fa-user-plus mr-2"></i>
                            Créer un compte
                        </button>
                    </div>
                </form>

                <div class="mt-6">
                    <div class="relative">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-gray-300"></div>
                        </div>
                        <div class="relative flex justify-center text-sm">
                            <span class="px-2 bg-white text-gray-500">Déjà inscrit ?</span>
                        </div>
                    </div>

                    <div class="mt-4">
                        <a href="/login" class="w-full flex justify-center py-3 px-4 border border-medical-300 rounded-lg shadow-sm text-sm font-medium text-medical-600 bg-medical-50 hover:bg-medical-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-medical-300 transition-all">
                            <i class="fas fa-sign-in-alt mr-2"></i>
                            Se connecter
                        </a>
                    </div>
                </div>
            </div>  </div>
    </div>

</main>
<%@include file="layouts/footer.jsp"%>
<script>
    const modal = document.getElementById("patientModal");
    const openBtn = document.getElementById("add-patient-btn");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");
    const form = document.getElementById("patient-form");
    const modalTitle = document.getElementById("modal-title");
    const formActionInput = document.getElementById("action");
    const idInput = document.getElementById("patient-id");

    const nomInput = document.getElementById("patient-nom");
    const prenomInput = document.getElementById("patient-prenom");
    const emailInput = document.getElementById("patient-email");
    const telInput = document.getElementById("patient-telephone");
    const dateInput = document.getElementById("patient-date");

    // 🔹 Ajouter un patient
    openBtn.addEventListener("click", () => {
        modal.classList.remove("hidden");
        modalTitle.textContent = "Add New Patient";
        formActionInput.value = "create";
        idInput.value = "";

        nomInput.value = "";
        prenomInput.value = "";
        emailInput.value = "";
        telInput.value = "";
        dateInput.value = "";
        form.querySelector('input[name="status"][value="active"]').checked = true;
    });

    // 🔹 Modifier un patient
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", () => {
            modal.classList.remove("hidden");
            modalTitle.textContent = "Edit Patient";

            idInput.value = button.dataset.id;
            nomInput.value = button.dataset.nom;
            prenomInput.value = button.dataset.prenom;
            emailInput.value = button.dataset.email;
            telInput.value = button.dataset.telephone;
            dateInput.value = button.dataset.date;

            const status = button.dataset.status === "true" ? "active" : "inactive";
            form.querySelector(`input[name="status"][value="${status}"]`).checked = true;

            formActionInput.value = "update";
            form.action = window.location.pathname + "?action=update";
        });
    });

    // 🔹 Fermer le modal
    [closeBtn, cancelBtn].forEach(btn => btn.addEventListener("click", () => modal.classList.add("hidden")));

    // 🔹 Fermer si clic à l’extérieur
    window.addEventListener("click", (e) => {
        if (e.target === modal) modal.classList.add("hidden");
    });
</script>
