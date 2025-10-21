<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediSearch - Trouvez votre Docteur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3dd1a8;
            --primary-dark: #2ba88a;
            --primary-light: #5fdbba;
            --bg-light: #f8fafb;
            --text-dark: #1a202c;
            --text-gray: #718096;
            --border-color: #e2e8f0;
        }

        .btn-primary {
            @apply bg-[#3dd1a8] hover:bg-[#2ba88a] text-white font-semibold py-3 px-6 rounded-lg transition-all duration-300 shadow-md hover:shadow-lg;
        }

        .doctor-card {
            @apply bg-white rounded-xl p-6 shadow-sm border border-[#e2e8f0] hover:shadow-lg transition-all duration-300 hover:border-[#3dd1a8];
        }

        .badge-specialty {
            @apply inline-block bg-[#e0f7f4] text-[#2ba88a] px-3 py-1 rounded-full text-sm font-medium;
        }

        .time-slot-btn {
            @apply bg-white border-2 border-[#e2e8f0] hover:border-[#3dd1a8] hover:bg-[#f0fdf9] text-[#1a202c] px-4 py-3 rounded-lg transition-all duration-200 cursor-pointer text-sm font-semibold text-center w-full;
        }

        .time-slot-btn.selected {
            @apply bg-[#3dd1a8] text-white border-[#3dd1a8] transform scale-105 shadow-md;
        }

        .time-slot-btn:active {
            @apply transform scale-95;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .input-container {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-container label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--text-dark);
            transition: all 0.3s ease;
        }

        .input-container input,
        .input-container select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: white;
        }

        .input-container input:focus,
        .input-container select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(61, 209, 168, 0.2);
        }

        .search-section {
            @apply relative bg-gradient-to-br from-white via-[#f0fdf9] to-white rounded-2xl shadow-xl p-8 mb-12 overflow-hidden border border-[#3dd1a8]/20;
        }

        .floating-action {
            @apply fixed bottom-8 right-8 w-14 h-14 bg-[#3dd1a8] text-white rounded-full flex items-center justify-center shadow-lg hover:shadow-xl transition-all duration-300 hover:bg-[#2ba88a] z-50;
        }

        .calendar-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            pointer-events: none;
        }

        .select-arrow {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            pointer-events: none;
        }

        .search-btn {
            background-color: #3dd1a8;
            color: white;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
            border: none;
            cursor: pointer;
            height: 48px;
        }

        .search-btn:hover {
            background-color: #2ba88a;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            transform: translateY(-2px);
        }

        /* Modal Styles */
        .modal-overlay {
            @apply fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 transition-opacity duration-300;
        }

        .modal-content {
            @apply bg-white rounded-2xl shadow-2xl max-w-md w-full mx-4 transform transition-all duration-300;
        }

        .modal-header {
            @apply bg-gradient-to-r from-[#3dd1a8] to-[#2ba88a] text-white p-6 rounded-t-2xl;
        }

        .modal-body {
            @apply p-6;
        }

        .modal-footer {
            @apply p-6 border-t border-[#e2e8f0] flex gap-3;
        }

        .duration-badge {
            @apply inline-flex items-center gap-1 bg-[#e0f7f4] text-[#2ba88a] px-3 py-2 rounded-full text-sm font-medium;
        }

        .time-slots-grid {
            @apply grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3;
        }

        .slot-duration {
            @apply text-xs text-[#718096] mt-1 font-normal;
        }
    </style>
</head>

<body class="bg-[#f8fafb]">
<!-- Header -->
<header class="bg-gradient-to-r from-[#3dd1a8] to-[#2ba88a] text-white py-6 shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                    <span class="text-[#3dd1a8] font-bold text-xl">M</span>
                </div>
                <h1 class="text-2xl font-bold">MediSearch</h1>
            </div>
            <div class="flex items-center gap-4">
                <span class="text-sm opacity-90">Bienvenue, Patient</span>
                <button class="bg-white bg-opacity-20 hover:bg-opacity-30 px-4 py-2 rounded-lg transition-all">
                    <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                </button>
            </div>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Search Section -->
    <section class="search-section">
        <!-- Animated Background Elements -->
        <div class="absolute top-0 right-0 w-64 h-64 bg-[#3dd1a8]/5 rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-0 left-0 w-48 h-48 bg-[#2ba88a]/5 rounded-full blur-3xl animate-pulse" style="animation-delay: 1s;"></div>

        <div class="relative z-10">
            <div class="flex items-center gap-3 mb-6">
                <div class="w-10 h-10 bg-gradient-to-br from-[#3dd1a8] to-[#2ba88a] rounded-lg flex items-center justify-center shadow-lg">
                    <span class="text-white text-xl"><i class="fas fa-search"></i></span>
                </div>
                <h2 class="text-2xl font-bold text-[#1a202c]">Rechercher un Docteur</h2>
            </div>

            <form action="patient" method="post" class="flex gap-4 items-end">
                <!-- Spécialité -->
                <div class="input-container flex-1">
                    <label for="specialtySelect" class="flex items-center gap-2 mb-2">
            <span class="w-6 h-6 bg-[#3dd1a8]/10 rounded-full flex items-center justify-center text-sm">
                <i class="fas fa-stethoscope"></i>
            </span>
                        Spécialité
                    </label>
                    <div class="relative">
                        <select id="specialtySelect" name="specialityId"
                                class="w-full px-4 py-3 border border-[#e2e8f0] rounded-lg appearance-none cursor-pointer pr-10 focus:outline-none focus:ring-2 focus:ring-[#3dd1a8] focus:border-transparent transition-all">
                            <option value="">-- Sélectionnez une spécialité --</option>
                            <c:forEach var="sp" items="${specialities}">
                                <option value="${sp.nom}">
                                        ${sp.nom}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="select-arrow absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Date -->
                <div class="input-container flex-1">
                    <label for="dateSelect" class="flex items-center gap-2 mb-2">
            <span class="w-6 h-6 bg-[#3dd1a8]/10 rounded-full flex items-center justify-center text-sm">
                <i class="fas fa-calendar-alt"></i>
            </span>
                        Date
                    </label>
                    <div class="relative">
                        <input type="date" id="dateSelect" name="date"
                               class="w-full px-4 py-3 border border-[#e2e8f0] rounded-lg cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#3dd1a8] focus:border-transparent transition-all">

                    </div>
                </div>

                <!-- Bouton rechercher -->

                <div class="flex flex-col justify-center h-full mb-[28px]">
                    <button type="submit" class="px-6 py-3 bg-[#3dd1a8] text-white rounded-lg font-medium hover:bg-[#2bc092] transition-all flex items-center gap-2">
                        <i class="fas fa-search"></i>
                        <span>Rechercher</span>
                    </button>
                </div>
            </form>
        </div>
    </section>

    <!-- Results Section -->
    <section id="resultsSection" class="hidden">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-[#1a202c]">Docteurs Disponibles</h2>
            <span id="resultCount" class="text-[#718096] font-medium">0 résultats</span>
        </div>

        <!-- Doctors Grid -->
        <div id="doctorsGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Doctor cards will be inserted here -->
        </div>

        <!-- No Results Message -->
        <div id="noResults" class="bg-white rounded-xl p-12 text-center hidden">
            <div class="text-center">
                <p class="text-4xl mb-4">😔</p>
                <p class="text-[#718096] text-lg">Aucun docteur disponible pour ces critères</p>
                <p class="text-[#a0aec0] text-sm mt-2">Essayez une autre date ou spécialité</p>
            </div>
        </div>
    </section>

    <!-- Initial State Message -->
    <section id="initialState" class="bg-white rounded-xl p-12 text-center">
        <div class="text-center">
            <p class="text-4xl mb-4">👨‍⚕️</p>
            <p class="text-[#718096] text-lg">Effectuez une recherche pour voir les docteurs disponibles</p>
            <p class="text-[#a0aec0] text-sm mt-2">Sélectionnez une spécialité et une date pour commencer</p>
        </div>
    </section>
</main>

<!-- Confirmation Modal -->
<div id="confirmationModal" class="modal-overlay hidden">
    <div class="modal-content">
        <div class="modal-header">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                    <i class="fas fa-calendar-check text-white"></i>
                </div>
                <div>
                    <h3 class="text-xl font-bold">Confirmer le rendez-vous</h3>
                    <p class="text-white text-opacity-90">Veuillez vérifier les détails de votre rendez-vous</p>
                </div>
            </div>
        </div>
        <div class="modal-body">
            <div class="space-y-4">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 bg-gradient-to-br from-[#3dd1a8] to-[#2ba88a] rounded-lg flex items-center justify-center text-white">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <div>
                        <h4 id="modalDoctorName" class="font-semibold text-[#1a202c]">Dr. Ahmed Bennani</h4>
                        <p id="modalDoctorSpecialty" class="text-[#718096] text-sm">Cardiologue</p>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <p class="text-[#718096] text-sm font-medium">Date</p>
                        <p id="modalDate" class="font-semibold text-[#1a202c]">Lundi 21 Octobre 2025</p>
                    </div>
                    <div>
                        <p class="text-[#718096] text-sm font-medium">Heure</p>
                        <p id="modalTime" class="font-semibold text-[#1a202c]">10:35</p>
                    </div>
                </div>

                <div class="bg-[#f8fafb] rounded-lg p-4">
                    <div class="flex items-center justify-between">
                        <span class="text-[#718096] text-sm">Durée du rendez-vous</span>
                        <span class="duration-badge">
                                <i class="fas fa-clock"></i>
                                <span>30 minutes</span>
                            </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="cancelModalBtn" class="flex-1 bg-white border border-[#e2e8f0] text-[#718096] hover:bg-gray-50 font-semibold py-3 px-6 rounded-lg transition-all duration-300">
                Annuler
            </button>
            <button id="confirmAppointmentBtn" class="flex-1 btn-primary">
                <i class="fas fa-calendar-check mr-2"></i>Confirmer
            </button>
        </div>
    </div>
</div>

<!-- Floating Action Button -->
<div class="floating-action" id="floatingActionBtn">
    <i class="fas fa-question"></i>
</div>

<%--<script>--%>
<%--    // Mock data for doctors and their availability--%>
<%--    const doctorsData = [--%>
<%--        {--%>
<%--            id: 1,--%>
<%--            name: "Dr. Ahmed Bennani",--%>
<%--            specialty: "cardiologue",--%>
<%--            rating: 4.9,--%>
<%--            reviews: 128,--%>
<%--            experience: "15 ans",--%>
<%--            location: "Casablanca",--%>
<%--            availability: {--%>
<%--                "2025-10-21": ["10:35", "14:30", "15:05", "15:40"],--%>
<%--                "2025-10-22": ["10:00", "11:30", "16:00"],--%>
<%--                "2025-10-23": ["08:30", "13:00", "15:00"],--%>
<%--                "2025-10-24": ["09:30", "11:00", "14:30"],--%>
<%--                "2025-10-25": ["10:00", "12:00", "15:30"]--%>
<%--            }--%>
<%--        },--%>
<%--        {--%>
<%--            id: 2,--%>
<%--            name: "Dr. Fatima Alaoui",--%>
<%--            specialty: "dermatologue",--%>
<%--            rating: 4.8,--%>
<%--            reviews: 95,--%>
<%--            experience: "12 ans",--%>
<%--            location: "Rabat",--%>
<%--            availability: {--%>
<%--                "2025-10-21": ["10:00", "11:30", "16:00"],--%>
<%--                "2025-10-23": ["09:00", "10:30", "14:00", "15:30"],--%>
<%--                "2025-10-25": ["08:30", "13:00", "15:00"]--%>
<%--            }--%>
<%--        },--%>
<%--        {--%>
<%--            id: 3,--%>
<%--            name: "Dr. Hassan Khoury",--%>
<%--            specialty: "neurologue",--%>
<%--            rating: 4.7,--%>
<%--            reviews: 112,--%>
<%--            experience: "18 ans",--%>
<%--            location: "Fès",--%>
<%--            availability: {--%>
<%--                "2025-10-22": ["09:00", "10:30", "14:00", "15:30"],--%>
<%--                "2025-10-24": ["10:00", "11:30", "16:00"],--%>
<%--                "2025-10-25": ["08:30", "13:00", "15:00"]--%>
<%--            }--%>
<%--        },--%>
<%--        {--%>
<%--            id: 4,--%>
<%--            name: "Dr. Leila Mansouri",--%>
<%--            specialty: "pediatre",--%>
<%--            rating: 4.9,--%>
<%--            reviews: 156,--%>
<%--            experience: "14 ans",--%>
<%--            location: "Marrakech",--%>
<%--            availability: {--%>
<%--                "2025-10-21": ["09:30", "11:00", "14:30"],--%>
<%--                "2025-10-22": ["10:00", "12:00", "15:30"],--%>
<%--                "2025-10-24": ["08:00", "10:00", "14:00", "16:00"]--%>
<%--            }--%>
<%--        }--%>
<%--    ];--%>

<%--    // DOM Elements--%>
<%--    const searchForm = document.getElementById('searchForm');--%>
<%--    const resultsSection = document.getElementById('resultsSection');--%>
<%--    const doctorsGrid = document.getElementById('doctorsGrid');--%>
<%--    const noResults = document.getElementById('noResults');--%>
<%--    const initialState = document.getElementById('initialState');--%>
<%--    const resultCount = document.getElementById('resultCount');--%>
<%--    const floatingActionBtn = document.getElementById('floatingActionBtn');--%>
<%--    const confirmationModal = document.getElementById('confirmationModal');--%>
<%--    const cancelModalBtn = document.getElementById('cancelModalBtn');--%>
<%--    const confirmAppointmentBtn = document.getElementById('confirmAppointmentBtn');--%>

<%--    // Modal elements--%>
<%--    const modalDoctorName = document.getElementById('modalDoctorName');--%>
<%--    const modalDoctorSpecialty = document.getElementById('modalDoctorSpecialty');--%>
<%--    const modalDate = document.getElementById('modalDate');--%>
<%--    const modalTime = document.getElementById('modalTime');--%>

<%--    // Current appointment data--%>
<%--    let currentAppointment = null;--%>

<%--    // Set minimum date to today--%>
<%--    const today = new Date().toISOString().split('T')[0];--%>
<%--    document.getElementById('dateSelect').setAttribute('min', today);--%>

<%--    // Initialize date input with today's date--%>
<%--    document.getElementById('dateSelect').value = today;--%>

<%--    // Add event listeners--%>
<%--    searchForm.addEventListener('submit', performSearch);--%>
<%--    floatingActionBtn.addEventListener('click', showHelp);--%>
<%--    cancelModalBtn.addEventListener('click', closeModal);--%>
<%--    confirmAppointmentBtn.addEventListener('click', confirmAppointment);--%>

<%--    // Close modal when clicking outside--%>
<%--    confirmationModal.addEventListener('click', (e) => {--%>
<%--        if (e.target === confirmationModal) {--%>
<%--            closeModal();--%>
<%--        }--%>
<%--    });--%>

<%--    // Perform search--%>
<%--    function performSearch(e) {--%>
<%--        e.preventDefault();--%>

<%--        const specialty = document.getElementById('specialtySelect').value;--%>
<%--        const date = document.getElementById('dateSelect').value;--%>

<%--        if (!specialty || !date) {--%>
<%--            alert('Veuillez sélectionner une spécialité et une date');--%>
<%--            return;--%>
<%--        }--%>

<%--        // Filter doctors based on specialty and date--%>
<%--        const filteredDoctors = doctorsData.filter(doctor => {--%>
<%--            return doctor.specialty === specialty && doctor.availability[date];--%>
<%--        });--%>

<%--        // Display results--%>
<%--        displayResults(filteredDoctors, date);--%>
<%--    }--%>

<%--    // Display search results--%>
<%--    function displayResults(doctors, date) {--%>
<%--        // Hide initial state--%>
<%--        initialState.classList.add('hidden');--%>

<%--        // Show results section--%>
<%--        resultsSection.classList.remove('hidden');--%>

<%--        // Update result count--%>
<%--        resultCount.textContent = `${doctors.length} résultat${doctors.length !== 1 ? 's' : ''}`;--%>

<%--        if (doctors.length === 0) {--%>
<%--            doctorsGrid.classList.add('hidden');--%>
<%--            noResults.classList.remove('hidden');--%>
<%--            return;--%>
<%--        }--%>

<%--        noResults.classList.add('hidden');--%>
<%--        doctorsGrid.classList.remove('hidden');--%>
<%--        doctorsGrid.innerHTML = '';--%>

<%--        // Format date for display--%>
<%--        const formattedDate = new Date(date).toLocaleDateString('fr-FR', {--%>
<%--            weekday: 'long',--%>
<%--            year: 'numeric',--%>
<%--            month: 'long',--%>
<%--            day: 'numeric'--%>
<%--        });--%>

<%--        // Create doctor cards--%>
<%--        doctors.forEach((doctor, index) => {--%>
<%--            const card = createDoctorCard(doctor, date, formattedDate);--%>
<%--            card.style.animation = `fadeIn 0.5s ease-in ${index * 0.1}s both`;--%>
<%--            doctorsGrid.appendChild(card);--%>
<%--        });--%>
<%--    }--%>

<%--    // Create doctor card--%>
<%--    function createDoctorCard(doctor, date, formattedDate) {--%>
<%--        const card = document.createElement('div');--%>
<%--        card.className = 'doctor-card';--%>

<%--        const availableTimes = doctor.availability[date];--%>

<%--        card.innerHTML = `--%>
<%--                <div class="flex items-start justify-between mb-4">--%>
<%--                    <div class="flex items-center gap-4">--%>
<%--                        <div class="w-16 h-16 bg-gradient-to-br from-[#3dd1a8] to-[#2ba88a] rounded-lg flex items-center justify-center text-2xl text-white">--%>
<%--                            <i class="fas fa-user-md"></i>--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            <h3 class="text-lg font-bold text-[#1a202c]">${doctor.name}</h3>--%>
<%--                            <p class="text-[#718096] text-sm">${doctor.location}</p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="text-right">--%>
<%--                        <div class="flex items-center gap-1 mb-1">--%>
<%--                            <span class="text-yellow-400"><i class="fas fa-star"></i></span>--%>
<%--                            <span class="font-bold text-[#1a202c]">${doctor.rating}</span>--%>
<%--                        </div>--%>
<%--                        <p class="text-[#718096] text-xs">${doctor.reviews} avis</p>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="mb-4 pb-4 border-b border-[#e2e8f0]">--%>
<%--                    <span class="badge-specialty">${doctor.specialty}</span>--%>
<%--                    <span class="text-[#718096] text-sm ml-2">${doctor.experience} d'expérience</span>--%>
<%--                </div>--%>

<%--                <div class="mb-4">--%>
<%--                    <p class="text-[#718096] text-xs font-medium mb-3">Créneaux disponibles le ${formattedDate}</p>--%>
<%--                    <div class="time-slots-grid">--%>
<%--                        ${availableTimes.map(time => `--%>
<%--                            <button class="time-slot-btn group" data-time="${time}">--%>
<%--                                <div class="font-semibold">${time}</div>--%>
<%--                                <div class="slot-duration">30 min</div>--%>
<%--                            </button>--%>
<%--                        `).join('')}--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            `;--%>

<%--        // Add event listeners to time slot buttons--%>
<%--        const timeSlotBtns = card.querySelectorAll('.time-slot-btn');--%>

<%--        timeSlotBtns.forEach(btn => {--%>
<%--            btn.addEventListener('click', () => {--%>
<%--                // Remove selected class from all buttons--%>
<%--                timeSlotBtns.forEach(b => b.classList.remove('selected'));--%>

<%--                // Add selected class to clicked button--%>
<%--                btn.classList.add('selected');--%>

<%--                // Store appointment data--%>
<%--                currentAppointment = {--%>
<%--                    doctor: doctor,--%>
<%--                    date: date,--%>
<%--                    time: btn.dataset.time,--%>
<%--                    formattedDate: formattedDate--%>
<%--                };--%>

<%--                // Show confirmation modal after a short delay for visual feedback--%>
<%--                setTimeout(() => {--%>
<%--                    showConfirmationModal();--%>
<%--                }, 300);--%>
<%--            });--%>
<%--        });--%>

<%--        return card;--%>
<%--    }--%>

<%--    // Show confirmation modal--%>
<%--    function showConfirmationModal() {--%>
<%--        if (!currentAppointment) return;--%>

<%--        // Update modal content--%>
<%--        modalDoctorName.textContent = currentAppointment.doctor.name;--%>
<%--        modalDoctorSpecialty.textContent = currentAppointment.doctor.specialty;--%>
<%--        modalDate.textContent = currentAppointment.formattedDate;--%>
<%--        modalTime.textContent = currentAppointment.time;--%>

<%--        // Show modal--%>
<%--        confirmationModal.classList.remove('hidden');--%>
<%--        document.body.style.overflow = 'hidden';--%>
<%--    }--%>

<%--    // Close modal--%>
<%--    function closeModal() {--%>
<%--        confirmationModal.classList.add('hidden');--%>
<%--        document.body.style.overflow = 'auto';--%>
<%--        currentAppointment = null;--%>
<%--    }--%>

<%--    // Confirm appointment--%>
<%--    function confirmAppointment() {--%>
<%--        if (!currentAppointment) return;--%>

<%--        // In a real application, this would send data to the server--%>
<%--        alert(`Rendez-vous confirmé avec ${currentAppointment.doctor.name} le ${currentAppointment.formattedDate} à ${currentAppointment.time}`);--%>

<%--        // Close modal--%>
<%--        closeModal();--%>
<%--    }--%>

<%--    // Show help--%>
<%--    function showHelp() {--%>
<%--        alert("Recherchez des médecins par spécialité et date. Cliquez sur un créneau horaire pour réserver un rendez-vous.");--%>
<%--    }--%>
<%--</script>--%>
</body>
</html>