<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 17/10/2025
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="layouts/header.jsp"%>
<%@include file="layouts/sidebar.jsp"%>
<%@include file="layouts/mainHeader.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<main class="bg-gray-50">
<div class="min-h-screen p-8">
    <div class="max-w-6xl mx-auto">
        <!-- Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Gestion des Disponibilités</h1>
            <p class="text-gray-600">Dr. Jean Dupont</p>
        </div>

        <!-- Bouton Ajouter -->
        <div class="mb-6">
            <button  onclick="openModal()" class="bg-[#3dd1a8] hover:bg-[#36b793] text-white font-semibold py-2 px-6 rounded-lg flex items-center gap-2 transition">
                <i class="fas fa-plus"></i>
                Ajouter une disponibilité
            </button>
        </div>

        <!-- Table des disponibilités -->
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <table class="w-full">
                <thead class="bg-gray-100 border-b border-gray-200">
                <tr>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Jour</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Heure Début</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Heure Fin</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Date Début</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Date Fin</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Statut</th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                <c:forEach var="avail" items="${availibilities}">
                    <tr class="hover:bg-gray-50 transition ${avail.statut eq 'UNAVAILABLE' ? 'bg-gray-50' : ''}">
                        <!-- Jour -->
                        <td class="px-6 py-4 text-sm text-gray-900 font-medium">
                                ${avail.jour}
                        </td>

                        <!-- Heure Début -->
                        <td class="px-6 py-4 text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${avail.statut eq 'AVAILABLE'}">
                                    ${avail.heureDebut}
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </td>

                        <!-- Heure Fin -->
                        <td class="px-6 py-4 text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${avail.statut eq 'AVAILABLE'}">
                                    ${avail.heureFin}
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </td>

                        <!-- Date Début -->
                        <td class="px-6 py-4 text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${not empty avail.dateDebut}">
                                    ${avail.dateDebut}
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </td>

                        <!-- Date Fin -->
                        <td class="px-6 py-4 text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${not empty avail.dateFin}">
                                    ${avail.dateFin}
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </td>



                        <!-- Statut -->
                        <td class="px-6 py-4">
                            <c:choose>
                                <c:when test="${avail.statut eq 'AVAILABLE'}">
                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                            <i class="fas fa-check-circle text-xs"></i> Disponible
                        </span>
                                </c:when>
                                <c:otherwise>
                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                            <i class="fas fa-ban text-xs"></i> Congé
                        </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <!-- Actions -->
                        <!-- Actions -->
                        <td class="px-6 py-4">
                            <div class="flex items-center gap-3 justify-center">
                                <!-- Bouton Éditer -->
                                <button
                                        class="text-blue-600 hover:text-blue-800 transition edit-btn"
                                        title="Éditer"
                                        data-id="${avail.id}"
                                        data-jour="${avail.jour}"
                                        data-heuredebut="${avail.heureDebut}"
                                        data-heurefin="${avail.heureFin}"
                                        data-datedebut="${avail.dateDebut}"
                                        data-datefin="${avail.dateFin}"
                                        data-statut="${avail.statut}">
                                    <i class="fas fa-edit text-lg"></i>
                                </button>

                                <!-- Bouton de changement de statut -->
                                <c:choose>
                                    <c:when test="${avail.statut eq 'AVAILABLE'}">
                                        <button
                                                type="button"
                                                class="text-red-600 hover:text-red-800 transition toggle-status-btn"
                                                data-id="${avail.id}"
                                                data-status="UNAVAILABLE"
                                                title="Marquer indisponible">
                                            <i class="fas fa-times-circle text-lg"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button
                                                type="button"
                                                class="text-green-600 hover:text-green-800 transition toggle-status-btn"
                                                data-id="${avail.id}"
                                                data-status="AVAILABLE"
                                                title="Marquer disponible">
                                            <i class="fas fa-check-circle text-lg"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>

                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>

    </div>
    <!--  Modal pour ajouter une disponibilité -->
    <div id="availabilityModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <!-- Header du modal -->
            <div class="flex justify-between items-center p-6 border-b">
                <h2 id="modal-title" class="text-xl font-bold text-gray-900">Ajouter une disponibilité</h2>
                <button id="close-modal" onclick="closeModal()" class="text-gray-500 hover:text-gray-700 transition">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>

            <form id="availability-form" action="${pageContext.request.contextPath}/doctor/availibility?action=create" method="post" class="p-6 space-y-4">
                <input type="hidden" id="availability-id" name="id">
                <!-- Type de disponibilité -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Type</label>
                    <select id="typeSelect" name="statut" onchange="toggleDateRange()" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="AVAILABLE">Disponible</option>
                        <option value="UNAVAILABLE">Congé</option>
                    </select>
                </div>

                <!-- Jour -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Jour</label>
                    <select id="jour" name="jour" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="LUNDI">LUNDI</option>
                        <option value="MARDI">MARDI</option>
                        <option value="MERCREDI">MERCREDI</option>
                        <option value="JEUDI">JEUDI</option>
                        <option value="VENDREDI">VENDREDI</option>

                    </select>
                </div>
                <!-- Heures début et fin alignées côte à côte -->
                <div class="grid grid-cols-2 gap-4">
                    <div id="heureDebut">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure Début</label>
                        <input type="time" id="heure_debut" name="heureDebut" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div id="heureFin">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure Fin</label>
                        <input type="time" id="heure_fin" name="heureFin" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Date Début</label>
                        <input type="date" id="date_debut" name="dateDebut" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Date Fin</label>
                        <input type="date" id="date_fin" name="dateFin" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <!-- Boutons -->
                <div class="flex gap-3 pt-4">
                    <button id="cancel-btn" type="button" onclick="closeModal()" class="flex-1 px-4 py-2 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                        Annuler
                    </button>
                    <button id="submit-btn" type="submit" class="flex-1 px-4 py-2 bg-[#3dd1a8] hover:bg-[#30A67F] text-white font-semibold rounded-lg transition">
                        Ajouter
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<%@include file="layouts/footer.jsp"%>
<script>
    const path="${pageContext.request.contextPath}";

    const submitBtn = document.getElementById("submit-btn");
    const modal = document.getElementById("availabilityModal");
    const openBtn = document.querySelector("button[onclick='openModal()']");
    const closeBtn = document.getElementById("close-modal");
    const cancelBtn = document.getElementById("cancel-btn");
    const form = document.getElementById("availability-form");
    const modalTitle = document.getElementById("modal-title");
    const idInput = document.getElementById("availability-id");

    // Inputs
    const jourInput = document.getElementById("jour");
    const heureDebutInput = document.getElementById("heure_debut");
    const heureFinInput = document.getElementById("heure_fin");
    const dateDebutInput = document.getElementById("date_debut");
    const dateFinInput = document.getElementById("date_fin");
    const statutSelect = document.getElementById("typeSelect");

    // 🔹 Ouvrir modal pour ajouter
    openBtn.addEventListener("click", () => {
        modal.classList.remove("hidden");
        modalTitle.textContent = "Ajouter une disponibilité";
        form.reset();
        idInput.value = "";
        form.action = `${window.location.pathname}?action=create`;
    });

    // 🔹 Ouvrir modal pour modifier
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", () => {
            modal.classList.remove("hidden");
            submitBtn.textContent = "Modifier";
            modalTitle.textContent = "Modifier une disponibilité";

            // Remplir le formulaire avec les data-*
            idInput.value = button.dataset.id;
            jourInput.value = button.dataset.jour;
            heureDebutInput.value = button.dataset.heuredebut;
            heureFinInput.value = button.dataset.heurefin;
            dateDebutInput.value = button.dataset.datedebut;
            dateFinInput.value = button.dataset.datefin;
            statutSelect.value = button.dataset.statut;

            toggleDateRange(); // ajuster l'affichage selon le statut
            form.action = `${window.location.pathname}?action=update`;
        });
    });

    // 🔹 Fermer modal
    [closeBtn, cancelBtn].forEach(btn => btn.addEventListener("click", () => modal.classList.add("hidden")));
    window.addEventListener("click", (e) => { if (e.target === modal) modal.classList.add("hidden"); });

    // 🔹 Gérer affichage des champs
    function toggleDateRange() {
        const typeSelect = document.getElementById('typeSelect');
        const dateRange = document.getElementById('dateRange');
        const heureDebut = document.getElementById('heureDebut');
        const heureFin = document.getElementById('heureFin');

        if (typeSelect.value === 'UNAVAILABLE') {
            dateRange.classList.remove('hidden');
            heureDebut.classList.add('hidden');
            heureFin.classList.add('hidden');
        } else {
            dateRange.classList.add('hidden');
            heureDebut.classList.remove('hidden');
            heureFin.classList.remove('hidden');
        }
    }
    // 🔹 Changement de statut de disponibilité
    document.querySelectorAll(".toggle-status-btn").forEach(btn => {
        const contextPath = "${pageContext.request.contextPath}";

        btn.addEventListener("click", (e) => {
            e.preventDefault();
            console.log("hi");
            const id = btn.dataset.id;
            const newStatus = btn.dataset.status;
            console.log(id);

            // Redirige vers le servlet avec l’action appropriée
            window.location.href = `${path}?action=toggleStatus&id=${id}&status=${newStatus}`;
        });
    });
</script>

