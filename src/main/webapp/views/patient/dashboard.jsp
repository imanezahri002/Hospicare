<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HospiCare - Trouvez votre Docteur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background: #3dd1a8;
            min-height: 100vh;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .slot-btn {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .slot-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(61, 209, 168, 0.3);
        }

        .slot-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(61, 209, 168, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .slot-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .doctor-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 2px solid transparent;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .doctor-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3dd1a8, #667eea);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .doctor-card:hover::before {
            transform: scaleX(1);
        }

        .doctor-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(61, 209, 168, 0.2);
            border-color: #3dd1a8;
        }

        .search-section {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.9));
            backdrop-filter: blur(20px);
            border: 2px solid rgba(61, 209, 168, 0.3);
        }

        .input-container input,
        .input-container select {
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .input-container input:focus,
        .input-container select:focus {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(61, 209, 168, 0.15);
        }

        .search-btn {
            background: linear-gradient(135deg, #3dd1a8, #2ba88a);
            position: relative;
            overflow: hidden;
        }

        .search-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .search-btn:hover::before {
            left: 100%;
        }

        .search-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(61, 209, 168, 0.4);
        }

        .header-gradient {
            background: #3dd1a8;
        }

        .doctor-avatar {
            position: relative;
            border: 3px solid #3dd1a8;
            box-shadow: 0 5px 15px rgba(61, 209, 168, 0.3);
        }

        .doctor-avatar::after {
            content: '✓';
            position: absolute;
            bottom: -2px;
            right: -2px;
            width: 24px;
            height: 24px;
            background: #3dd1a8;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
            border: 2px solid white;
        }

        .badge {
            background: linear-gradient(135deg, #3dd1a8, #2ba88a);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .empty-state {
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-enter {
            animation: cardEnter 0.5s ease forwards;
        }

        @keyframes cardEnter {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .pulse-badge {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
    </style>
</head>
<body>

<header class="header-gradient text-white py-6 shadow-2xl">
    <div class="max-w-7xl mx-auto px-4 flex justify-between items-center">
        <div class="flex items-center gap-3">
            <div class="bg-white/20 p-3 rounded-xl backdrop-blur">
                <i class="fas fa-heartbeat text-2xl"></i>
            </div>
            <div>
                <h1 class="text-3xl font-bold">HospiCare</h1>
                <p class="text-sm text-white/80">Votre santé, notre priorité</p>
            </div>
        </div>
        <div class="flex gap-4 items-center">
            <div class="flex items-center gap-3 bg-white/10 px-4 py-2 rounded-xl backdrop-blur">
                <i class="fas fa-user-circle text-2xl"></i>
                <span class="font-medium">Patient</span>
            </div>
            <button class="bg-white/20 hover:bg-white/30 px-5 py-2.5 rounded-xl flex items-center gap-2 transition-all hover:scale-105">
                <i class="fas fa-sign-out-alt"></i>
                <span class="font-medium">Déconnexion</span>
            </button>
        </div>
    </div>
</header>

<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">

    <!-- Formulaire de recherche -->
    <section class="search-section mb-12 p-8 rounded-3xl shadow-2xl">
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800 flex items-center gap-3">
                <i class="fas fa-search text-[#3dd1a8]"></i>
                Rechercher un médecin
            </h2>
            <p class="text-gray-600 mt-2">Trouvez le spécialiste qu'il vous faut en quelques clics</p>
        </div>

        <form action="patient" method="post" class="flex flex-col sm:flex-row gap-5 items-end">
            <div class="input-container flex-1">
                <label for="specialtySelect" class="block text-sm font-semibold text-gray-700 mb-2 flex items-center gap-2">
                    <i class="fas fa-stethoscope text-[#3dd1a8]"></i>
                    Spécialité
                </label>
                <select id="specialtySelect" name="specialityId" class="w-full px-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#3dd1a8] focus:border-transparent">
                    <option value="">-- Sélectionnez une spécialité --</option>
                    <c:forEach var="sp" items="${specialities}">
                        <option value="${sp.nom}">${sp.nom}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="input-container flex-1">
                <label for="dateSelect" class="block text-sm font-semibold text-gray-700 mb-2 flex items-center gap-2">
                    <i class="fas fa-calendar-alt text-[#3dd1a8]"></i>
                    Date du rendez-vous
                </label>
                <input type="date" id="dateSelect" name="dateSelect" value="<%= java.time.LocalDate.now() %>" class="w-full px-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#3dd1a8] focus:border-transparent">
            </div>
            <button type="submit" class="search-btn text-white font-bold px-8 py-3.5 rounded-xl transition-all flex items-center gap-3 shadow-lg">
                <i class="fas fa-search"></i>
                <span>Rechercher</span>
            </button>
        </form>
    </section>

    <!-- Résultats -->
    <c:choose>
        <c:when test="${empty availibilityDoctor}">
            <div class="empty-state text-center py-20">
                <div class="glass-effect inline-block p-10 rounded-3xl shadow-xl">
                    <div class="bg-gradient-to-br from-[#3dd1a8] to-[#2ba88a] w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6 shadow-lg">
                        <i class="fas fa-search text-5xl text-white"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-800 mb-3">Commencez votre recherche</h3>
                    <p class="text-gray-600 max-w-md mx-auto">Sélectionnez une spécialité et une date pour découvrir les médecins disponibles près de chez vous.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="mb-6">
                <h3 class="text-xl font-bold text-white flex items-center gap-3 glass-effect inline-block px-6 py-3 rounded-2xl shadow-lg">
                    <i class="fas fa-user-md text-[#3dd1a8]"></i>
                    Médecins disponibles
                    <span class="badge pulse-badge ml-2">${availibilityDoctor.size()}</span>
                </h3>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="entry" items="${availibilityDoctor}" varStatus="status">
                    <c:set var="doctor" value="${entry.key}" />
                    <c:set var="slots" value="${entry.value}" />
                    <div class="doctor-card card-enter" style="animation-delay: ${status.index * 0.1}s">
                        <div class="flex items-center gap-4 mb-6">
                            <div class="relative">
                                <img src="/assets/images/doctor1.png" class="doctor-avatar w-20 h-20 rounded-full object-cover">
                            </div>
                            <div class="flex-1">
                                <h3 class="text-xl font-bold text-gray-800 mb-1">${doctor.fullName}</h3>
                                <p class="text-sm font-medium text-[#3dd1a8] flex items-center gap-2">
                                    <i class="fas fa-stethoscope"></i>
                                        ${doctor.speciality.nom}
                                </p>
                            </div>
                        </div>

                        <div class="bg-gradient-to-br from-gray-50 to-gray-100 p-4 rounded-xl mb-4">
                            <div class="flex items-center gap-2 text-sm text-gray-600 mb-2">
                                <i class="fas fa-clock text-[#3dd1a8]"></i>
                                <span class="font-semibold">${slots.size()} créneaux disponibles</span>
                            </div>
                        </div>

                        <div>
                            <h4 class="text-sm font-bold text-gray-700 mb-3 flex items-center gap-2">
                                <i class="fas fa-calendar-check text-[#3dd1a8]"></i>
                                Choisissez votre créneau :
                            </h4>
                            <div class="flex flex-wrap gap-2">
                                <c:forEach var="slot" items="${slots}">
                                    <button type="button"
                                            class="slot-btn px-4 py-2 text-sm rounded-xl bg-[#3dd1a8]/10 text-[#3dd1a8] font-semibold hover:bg-[#3dd1a8] hover:text-white transition-all cursor-pointer border-2 border-transparent hover:border-[#3dd1a8]"
                                            data-doctor-name="${doctor.fullName}"
                                            data-doctor-id="${doctor.id}"
                                            data-slot="${slot}"
                                            data-date="${param.dateSelect != null ? param.dateSelect : ''}">
                                        <i class="fas fa-clock mr-1"></i>${slot}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<script>
    document.querySelectorAll('.slot-btn').forEach(button => {
        button.addEventListener('click', () => {
            const doctorName = button.dataset.doctorName;
            const doctorId = button.dataset.doctorId;
            const slot = button.dataset.slot;
            const date = button.dataset.date;

            Swal.fire({
                title: 'Confirmer le rendez-vous',
                html: `Voulez-vous confirmer un rendez-vous avec <b>${doctorName}</b> pour le créneau <b>${slot}</b> le <b>${date}</b> ?`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3dd1a8',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmer',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = '/addAppointment';

                    const inputDoctor = document.createElement('input');
                    inputDoctor.type = 'hidden';
                    inputDoctor.name = 'doctorId';
                    inputDoctor.value = doctorId;

                    const inputSlot = document.createElement('input');
                    inputSlot.type = 'hidden';
                    inputSlot.name = 'slot';
                    inputSlot.value = slot;

                    const inputDate = document.createElement('input');
                    inputDate.type = 'hidden';
                    inputDate.name = 'date';
                    inputDate.value = date;

                    form.appendChild(inputDoctor);
                    form.appendChild(inputSlot);
                    form.appendChild(inputDate);

                    document.body.appendChild(form);
                    form.submit();
                }
            });
        });
    });
</script>

</body>
</html>