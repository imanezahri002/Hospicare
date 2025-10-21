<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediSearch - Trouvez votre Docteur</title>
    <script src="https://cdn.tailwindcss.com"></script>
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

        * {
            --tw-ring-color: var(--primary);
        }

        .btn-primary {
            @apply bg-[#3dd1a8] hover:bg-[#2ba88a] text-white font-semibold py-3 px-6 rounded-lg transition-all duration-300 shadow-md hover:shadow-lg;
        }

        .stat-card {
            @apply bg-white rounded-xl p-6 shadow-sm border border-[#e2e8f0] hover:shadow-md transition-all;
        }

        .doctor-card {
            @apply bg-white rounded-xl p-5 shadow-sm border border-[#e2e8f0] hover:shadow-lg transition-all duration-300 hover:border-[#3dd1a8];
        }

        .badge-specialty {
            @apply inline-block bg-[#e0f7f4] text-[#2ba88a] px-3 py-1 rounded-full text-sm font-medium;
        }

        .badge-available {
            @apply inline-block bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-medium;
        }

        .badge-unavailable {
            @apply inline-block bg-red-100 text-red-700 px-3 py-1 rounded-full text-sm font-medium;
        }

        .input-field {
            @apply w-full px-4 py-3 border border-[#e2e8f0] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#3dd1a8] focus:border-transparent transition-all;
        }

        .header-gradient {
            background: linear-gradient(135deg, #3dd1a8 0%, #2ba88a 100%);
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

        /* Styles améliorés pour les champs de saisie */
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

        .input-container input:hover,
        .input-container select:hover {
            border-color: var(--primary-light);
        }

        .input-container .input-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-container.focused label {
            color: var(--primary);
        }

        .input-container.focused .input-icon {
            color: var(--primary);
        }

        .input-container.error input,
        .input-container.error select {
            border-color: #f56565;
            box-shadow: 0 0 0 3px rgba(245, 101, 101, 0.2);
        }

        .input-container.error label {
            color: #f56565;
        }

        .error-message {
            color: #f56565;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }

        .input-container.error .error-message {
            display: block;
        }

        /* Style personnalisé pour le bouton de recherche */
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
        }

        .search-btn:hover {
            background-color: #2ba88a;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            transform: translateY(-2px);
        }

        .search-btn:active {
            transform: translateY(0);
        }

        /* Style pour l'icône de calendrier dans le champ date */
        .date-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-container.focused .date-icon {
            color: var(--primary);
        }

        /* Style pour la flèche du select */
        .select-arrow {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-gray);
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-container.focused .select-arrow {
            color: var(--primary);
        }
        @media (min-width: 768px) {
            .md\:w-auto {
                width: auto;
                margin-top: 27px;
            }
        }


    </style>
</head>
<body class="bg-[#f8fafb]">
<!-- Header -->
<header class="header-gradient text-white py-8 shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between mb-6">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                    <span class="text-[#3dd1a8] font-bold text-xl">M</span>
                </div>
                <h1 class="text-3xl font-bold">MediSearch</h1>
            </div>
            <div class="flex items-center gap-4">
                <span class="text-sm opacity-90">Bienvenue, Patient</span>
                <button class="bg-white bg-opacity-20 hover:bg-opacity-30 px-4 py-2 rounded-lg transition-all">
                    Déconnexion
                </button>
            </div>
        </div>
        <p class="text-opacity-90 text-white">Trouvez le docteur parfait selon votre spécialité et disponibilité</p>
    </div>
</header>

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <!-- Statistics Section -->
    <section class="mb-12">
        <h2 class="text-2xl font-bold text-[#1a202c] mb-6">Statistiques</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div class="stat-card">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-[#718096] text-sm font-medium mb-2">Docteurs Disponibles</p>
                        <p class="text-4xl font-bold text-[#3dd1a8]">247</p>
                    </div>
                    <div class="w-12 h-12 bg-[#e0f7f4] rounded-lg flex items-center justify-center text-2xl">👨‍⚕️</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-[#718096] text-sm font-medium mb-2">Spécialités</p>
                        <p class="text-4xl font-bold text-[#3dd1a8]">32</p>
                    </div>
                    <div class="w-12 h-12 bg-[#e0f7f4] rounded-lg flex items-center justify-center text-2xl">🏥</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-[#718096] text-sm font-medium mb-2">Rendez-vous Aujourd'hui</p>
                        <p class="text-4xl font-bold text-[#3dd1a8]">156</p>
                    </div>
                    <div class="w-12 h-12 bg-[#e0f7f4] rounded-lg flex items-center justify-center text-2xl">📅</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-[#718096] text-sm font-medium mb-2">Satisfaction</p>
                        <p class="text-4xl font-bold text-[#3dd1a8]">4.8/5</p>
                    </div>
                    <div class="w-12 h-12 bg-[#e0f7f4] rounded-lg flex items-center justify-center text-2xl">⭐</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Search Section -->
    <section class="relative bg-gradient-to-br from-white via-[#f0fdf9] to-white rounded-2xl shadow-xl p-8 mb-12 overflow-hidden border border-[#3dd1a8]/20">
        <!-- Animated Background Elements -->
        <div class="absolute top-0 right-0 w-64 h-64 bg-[#3dd1a8]/5 rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-0 left-0 w-48 h-48 bg-[#2ba88a]/5 rounded-full blur-3xl animate-pulse" style="animation-delay: 1s;"></div>

        <div class="relative z-10">
            <div class="flex items-center gap-3 mb-6">
                <div class="w-10 h-10 bg-gradient-to-br from-[#3dd1a8] to-[#2ba88a] rounded-lg flex items-center justify-center shadow-lg">
                    <span class="text-white text-xl">🔍</span>
                </div>
                <h2 class="text-2xl font-bold text-[#1a202c]">Rechercher un Docteur</h2>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-end mb-6">
                <form action="patient" method="post">
                <!-- Spécialité -->
                <div class="input-container">
                    <label for="specialtySelect" class="flex items-center gap-2">
                        <span class="w-6 h-6 bg-[#3dd1a8]/10 rounded-full flex items-center justify-center text-sm">🏥</span>
                        Spécialité
                    </label>
                    <div class="relative">
                        <select id="specialtySelect" name="specialityId"
                                class="input-field appearance-none cursor-pointer pr-10">
                            <option value="">-- Sélectionnez une spécialité --</option>

                            <c:forEach var="sp" items="${specialities}">
                                <option value="${sp.nom}">
                                        ${sp.nom}
                                </option>
                            </c:forEach>
                        </select>

                        <div class="select-arrow">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Date -->
                <div class="input-container">
                    <label for="dateSelect" class="flex items-center gap-2">
                        <span class="w-6 h-6 bg-[#3dd1a8]/10 rounded-full flex items-center justify-center text-sm">📅</span>
                        Date
                    </label>
                    <div class="relative">
                        <input type="date" id="dateSelect" class="input-field cursor-pointer pr-10" name="dateSelect">
                    </div>
                </div>

                <!-- Bouton rechercher -->
                <div class="flex flex-col justify-center h-full">
                    <button id="searchBtn" class="search-btn w-full md:w-auto">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                        </svg>
                        <span>Rechercher</span>
                    </button>
                </div>
                </form>
            </div>


            <!-- Filter Tags -->
            <div id="filterTags" class="flex flex-wrap gap-3 hidden animate-fadeIn">
                <div class="flex items-center gap-2 bg-gradient-to-r from-[#e0f7f4] to-[#d0f0ea] text-[#2ba88a] px-4 py-2 rounded-full text-sm font-medium shadow-sm">
                    <span class="w-6 h-6 bg-white rounded-full flex items-center justify-center text-xs">🏥</span>
                    <span>Spécialité: <span id="tagSpecialty" class="font-bold"></span></span>
                </div>
                <div class="flex items-center gap-2 bg-gradient-to-r from-[#e0f7f4] to-[#d0f0ea] text-[#2ba88a] px-4 py-2 rounded-full text-sm font-medium shadow-sm">
                    <span class="w-6 h-6 bg-white rounded-full flex items-center justify-center text-xs">📅</span>
                    <span>Date: <span id="tagDate" class="font-bold"></span></span>
                </div>
                <button id="clearBtn" class="flex items-center gap-2 bg-gradient-to-r from-red-100 to-red-50 text-red-700 px-4 py-2 rounded-full text-sm font-medium hover:from-red-200 hover:to-red-100 transition-all shadow-sm hover:shadow-md transform hover:scale-105">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                    Effacer
                </button>
            </div>
        </div>
    </section>

    <!-- Results Section -->
    <section>
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-[#1a202c]">Docteurs Disponibles</h2>
            <span id="resultCount" class="text-[#718096] font-medium">0 résultats</span>
        </div>

        <!-- No Results Message -->
        <div id="noResults" class="bg-white rounded-xl p-12 text-center">
            <p class="text-[#718096] text-lg">Effectuez une recherche pour voir les docteurs disponibles</p>
        </div>

        <!-- Doctors Grid -->
        <div id="doctorsGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 hidden">
            <!-- Doctor cards will be inserted here -->
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="bg-[#1a202c] text-white py-8 mt-16">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
            <div>
                <h3 class="font-bold mb-4">À propos</h3>
                <p class="text-[#a0aec0] text-sm">MediSearch vous aide à trouver les meilleurs docteurs près de vous.</p>
            </div>
            <div>
                <h3 class="font-bold mb-4">Liens Rapides</h3>
                <ul class="text-[#a0aec0] text-sm space-y-2">
                    <li><a href="#" class="hover:text-[#3dd1a8] transition-all">Accueil</a></li>
                    <li><a href="#" class="hover:text-[#3dd1a8] transition-all">Docteurs</a></li>
                    <li><a href="#" class="hover:text-[#3dd1a8] transition-all">Contact</a></li>
                </ul>
            </div>
            <div>
                <h3 class="font-bold mb-4">Contact</h3>
                <p class="text-[#a0aec0] text-sm">Email: info@medisearch.com</p>
                <p class="text-[#a0aec0] text-sm">Tél: +33 1 23 45 67 89</p>
            </div>
        </div>
        <div class="border-t border-[#2d3748] pt-8 text-center text-[#a0aec0] text-sm">
            <p>&copy; 2025 MediSearch. Tous droits réservés.</p>
        </div>
    </div>
</footer>

<%--<script>--%>
<%--    // Mock data for doctors--%>
<%--    const doctorsData = [--%>
<%--        {--%>
<%--            id: 1,--%>
<%--            name: "Dr. Ahmed Bennani",--%>
<%--            specialty: "cardiologue",--%>
<%--            rating: 4.9,--%>
<%--            reviews: 128,--%>
<%--            experience: "15 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-21", "2025-10-22", "2025-10-23", "2025-10-24"],--%>
<%--            availableTimes: ["09:00", "10:30", "14:00", "15:30"],--%>
<%--            image: "👨‍⚕️",--%>
<%--            location: "Casablanca",--%>
<%--            price: "250 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 2,--%>
<%--            name: "Dr. Fatima Alaoui",--%>
<%--            specialty: "dermatologue",--%>
<%--            rating: 4.8,--%>
<%--            reviews: 95,--%>
<%--            experience: "12 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-21", "2025-10-23", "2025-10-25"],--%>
<%--            availableTimes: ["10:00", "11:30", "16:00"],--%>
<%--            image: "👩‍⚕️",--%>
<%--            location: "Rabat",--%>
<%--            price: "200 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 3,--%>
<%--            name: "Dr. Hassan Khoury",--%>
<%--            specialty: "neurologue",--%>
<%--            rating: 4.7,--%>
<%--            reviews: 112,--%>
<%--            experience: "18 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-22", "2025-10-24", "2025-10-25"],--%>
<%--            availableTimes: ["08:30", "13:00", "15:00"],--%>
<%--            image: "👨‍⚕️",--%>
<%--            location: "Fès",--%>
<%--            price: "300 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 4,--%>
<%--            name: "Dr. Leila Mansouri",--%>
<%--            specialty: "pediatre",--%>
<%--            rating: 4.9,--%>
<%--            reviews: 156,--%>
<%--            experience: "14 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-21", "2025-10-22", "2025-10-24"],--%>
<%--            availableTimes: ["09:30", "11:00", "14:30"],--%>
<%--            image: "👩‍⚕️",--%>
<%--            location: "Marrakech",--%>
<%--            price: "180 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 5,--%>
<%--            name: "Dr. Mohamed Saidi",--%>
<%--            specialty: "ophtalmologue",--%>
<%--            rating: 4.6,--%>
<%--            reviews: 87,--%>
<%--            experience: "11 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-23", "2025-10-24", "2025-10-25"],--%>
<%--            availableTimes: ["10:00", "12:00", "15:30"],--%>
<%--            image: "👨‍⚕️",--%>
<%--            location: "Agadir",--%>
<%--            price: "220 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 6,--%>
<%--            name: "Dr. Nadia Bennani",--%>
<%--            specialty: "dentiste",--%>
<%--            rating: 4.8,--%>
<%--            reviews: 134,--%>
<%--            experience: "13 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-21", "2025-10-23", "2025-10-25"],--%>
<%--            availableTimes: ["08:00", "10:00", "14:00", "16:00"],--%>
<%--            image: "👩‍⚕️",--%>
<%--            location: "Casablanca",--%>
<%--            price: "150 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 7,--%>
<%--            name: "Dr. Karim Aziz",--%>
<%--            specialty: "cardiologue",--%>
<%--            rating: 4.7,--%>
<%--            reviews: 98,--%>
<%--            experience: "16 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-22", "2025-10-23", "2025-10-24"],--%>
<%--            availableTimes: ["09:00", "11:00", "15:00"],--%>
<%--            image: "👨‍⚕️",--%>
<%--            location: "Tangier",--%>
<%--            price: "280 DH"--%>
<%--        },--%>
<%--        {--%>
<%--            id: 8,--%>
<%--            name: "Dr. Samira Riad",--%>
<%--            specialty: "generaliste",--%>
<%--            rating: 4.9,--%>
<%--            reviews: 201,--%>
<%--            experience: "20 ans",--%>
<%--            available: true,--%>
<%--            availableDays: ["2025-10-21", "2025-10-22", "2025-10-23", "2025-10-24", "2025-10-25"],--%>
<%--            availableTimes: ["08:00", "09:30", "11:00", "14:00", "15:30", "17:00"],--%>
<%--            image: "👩‍⚕️",--%>
<%--            location: "Casablanca",--%>
<%--            price: "120 DH"--%>
<%--        }--%>
<%--    ];--%>

<%--    // DOM Elements--%>
<%--    const specialtySelect = document.getElementById('specialtySelect');--%>
<%--    const dateSelect = document.getElementById('dateSelect');--%>
<%--    const searchBtn = document.getElementById('searchBtn');--%>
<%--    const clearBtn = document.getElementById('clearBtn');--%>
<%--    const doctorsGrid = document.getElementById('doctorsGrid');--%>
<%--    const noResults = document.getElementById('noResults');--%>
<%--    const resultCount = document.getElementById('resultCount');--%>
<%--    const filterTags = document.getElementById('filterTags');--%>
<%--    const tagSpecialty = document.getElementById('tagSpecialty');--%>
<%--    const tagDate = document.getElementById('tagDate');--%>
<%--    const specialtyContainer = document.getElementById('specialtyContainer');--%>
<%--    const dateContainer = document.getElementById('dateContainer');--%>

<%--    // Set minimum date to today--%>
<%--    const today = new Date().toISOString().split('T')[0];--%>
<%--    dateSelect.setAttribute('min', today);--%>

<%--    // Initialize date input with today's date--%>
<%--    dateSelect.value = today;--%>

<%--    // Add focus/blur events for input styling--%>
<%--    specialtySelect.addEventListener('focus', () => {--%>
<%--        specialtyContainer.classList.add('focused');--%>
<%--    });--%>

<%--    specialtySelect.addEventListener('blur', () => {--%>
<%--        specialtyContainer.classList.remove('focused');--%>
<%--        validateField(specialtySelect, specialtyContainer);--%>
<%--    });--%>

<%--    dateSelect.addEventListener('focus', () => {--%>
<%--        dateContainer.classList.add('focused');--%>
<%--    });--%>

<%--    dateSelect.addEventListener('blur', () => {--%>
<%--        dateContainer.classList.remove('focused');--%>
<%--        validateField(dateSelect, dateContainer);--%>
<%--    });--%>

<%--    // Search functionality--%>
<%--    searchBtn.addEventListener('click', performSearch);--%>
<%--    clearBtn.addEventListener('click', clearSearch);--%>

<%--    // Allow Enter key to search--%>
<%--    dateSelect.addEventListener('keypress', (e) => {--%>
<%--        if (e.key === 'Enter') performSearch();--%>
<%--    });--%>

<%--    function validateField(field, container) {--%>
<%--        if (!field.value) {--%>
<%--            container.classList.add('error');--%>
<%--            return false;--%>
<%--        } else {--%>
<%--            container.classList.remove('error');--%>
<%--            return true;--%>
<%--        }--%>
<%--    }--%>

<%--    function performSearch() {--%>
<%--        const specialty = specialtySelect.value;--%>
<%--        const date = dateSelect.value;--%>

<%--        // Validate fields--%>
<%--        const isSpecialtyValid = validateField(specialtySelect, specialtyContainer);--%>
<%--        const isDateValid = validateField(dateSelect, dateContainer);--%>

<%--        if (!isSpecialtyValid || !isDateValid) {--%>
<%--            return;--%>
<%--        }--%>

<%--        // Filter doctors--%>
<%--        const filtered = doctorsData.filter(doctor => {--%>
<%--            return doctor.specialty === specialty && doctor.availableDays.includes(date);--%>
<%--        });--%>

<%--        // Display results--%>
<%--        displayResults(filtered, specialty, date);--%>
<%--    }--%>

<%--    function displayResults(doctors, specialty, date) {--%>
<%--        // Update filter tags--%>
<%--        tagSpecialty.textContent = specialty.charAt(0).toUpperCase() + specialty.slice(1);--%>
<%--        tagDate.textContent = new Date(date).toLocaleDateString('fr-FR');--%>
<%--        filterTags.classList.remove('hidden');--%>

<%--        // Update result count--%>
<%--        resultCount.textContent = `${doctors.length} résultat${doctors.length !== 1 ? 's' : ''}`;--%>

<%--        if (doctors.length === 0) {--%>
<%--            doctorsGrid.classList.add('hidden');--%>
<%--            noResults.classList.remove('hidden');--%>
<%--            noResults.innerHTML = `--%>
<%--                    <div class="text-center">--%>
<%--                        <p class="text-4xl mb-4">😔</p>--%>
<%--                        <p class="text-[#718096] text-lg">Aucun docteur disponible pour cette date</p>--%>
<%--                        <p class="text-[#a0aec0] text-sm mt-2">Essayez une autre date ou spécialité</p>--%>
<%--                    </div>--%>
<%--                `;--%>
<%--            return;--%>
<%--        }--%>

<%--        noResults.classList.add('hidden');--%>
<%--        doctorsGrid.classList.remove('hidden');--%>
<%--        doctorsGrid.innerHTML = '';--%>

<%--        doctors.forEach((doctor, index) => {--%>
<%--            const card = createDoctorCard(doctor, date);--%>
<%--            card.style.animation = `fadeIn 0.5s ease-in ${index * 0.1}s both`;--%>
<%--            doctorsGrid.appendChild(card);--%>
<%--        });--%>
<%--    }--%>

<%--    function createDoctorCard(doctor, selectedDate) {--%>
<%--        const card = document.createElement('div');--%>
<%--        card.className = 'doctor-card';--%>

<%--        const availableTimes = doctor.availableTimes.join(', ');--%>

<%--        card.innerHTML = `--%>
<%--                <div class="flex items-start justify-between mb-4">--%>
<%--                    <div class="flex items-center gap-4">--%>
<%--                        <div class="w-16 h-16 bg-[#e0f7f4] rounded-lg flex items-center justify-center text-4xl">--%>
<%--                            ${doctor.image}--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            <h3 class="text-lg font-bold text-[#1a202c]">${doctor.name}</h3>--%>
<%--                            <p class="text-[#718096] text-sm">${doctor.location}</p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="text-right">--%>
<%--                        <div class="flex items-center gap-1 mb-1">--%>
<%--                            <span class="text-yellow-400">⭐</span>--%>
<%--                            <span class="font-bold text-[#1a202c]">${doctor.rating}</span>--%>
<%--                        </div>--%>
<%--                        <p class="text-[#718096] text-xs">${doctor.reviews} avis</p>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="mb-4 pb-4 border-b border-[#e2e8f0]">--%>
<%--                    <span class="badge-specialty">${doctor.specialty}</span>--%>
<%--                </div>--%>

<%--                <div class="grid grid-cols-2 gap-3 mb-4">--%>
<%--                    <div>--%>
<%--                        <p class="text-[#718096] text-xs font-medium mb-1">Expérience</p>--%>
<%--                        <p class="text-[#1a202c] font-semibold">${doctor.experience}</p>--%>
<%--                    </div>--%>
<%--                    <div>--%>
<%--                        <p class="text-[#718096] text-xs font-medium mb-1">Tarif</p>--%>
<%--                        <p class="text-[#3dd1a8] font-semibold">${doctor.price}</p>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="mb-4">--%>
<%--                    <p class="text-[#718096] text-xs font-medium mb-2">Créneaux disponibles</p>--%>
<%--                    <div class="flex flex-wrap gap-2">--%>
<%--                        ${doctor.availableTimes.map(time => `--%>
<%--                            <span class="bg-[#e0f7f4] text-[#2ba88a] px-2 py-1 rounded text-xs font-medium">--%>
<%--                                ${time}--%>
<%--                            </span>--%>
<%--                        `).join('')}--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="flex gap-3">--%>
<%--                    <button class="flex-1 btn-primary text-sm py-2">--%>
<%--                        📅 Prendre RDV--%>
<%--                    </button>--%>
<%--                    <button class="flex-1 bg-[#e0f7f4] text-[#2ba88a] hover:bg-[#c8ede8] font-semibold py-2 px-4 rounded-lg transition-all">--%>
<%--                        💬 Message--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            `;--%>

<%--        return card;--%>
<%--    }--%>

<%--    function clearSearch() {--%>
<%--        specialtySelect.value = '';--%>
<%--        dateSelect.value = today;--%>

<%--        // Reset validation states--%>
<%--        specialtyContainer.classList.remove('error', 'focused');--%>
<%--        dateContainer.classList.remove('error', 'focused');--%>

<%--        filterTags.classList.add('hidden');--%>
<%--        doctorsGrid.classList.add('hidden');--%>
<%--        noResults.classList.remove('hidden');--%>
<%--        noResults.innerHTML = `--%>
<%--                <p class="text-[#718096] text-lg">Effectuez une recherche pour voir les docteurs disponibles</p>--%>
<%--            `;--%>
<%--        resultCount.textContent = '0 résultats';--%>
<%--    }--%>
<%--</script>--%>
</body>
</html>
