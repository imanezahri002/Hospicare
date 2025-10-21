
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous - HospiCare</title>
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

        .header-gradient {
            background: #3dd1a8;
        }

        .appointment-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 2px solid transparent;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .appointment-card::before {
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

        .appointment-card:hover::before {
            transform: scaleX(1);
        }

        .appointment-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(61, 209, 168, 0.2);
            border-color: #3dd1a8;
        }

        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-en-attente {
            background: #fef3c7;
            color: #92400e;
        }

        .status-confirme {
            background: #d1fae5;
            color: #065f46;
        }

        .status-annule {
            background: #fee2e2;
            color: #991b1b;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            padding: 8px 20px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
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

            <a href="#" class="bg-white/20 hover:bg-white/30 px-5 py-2.5 rounded-xl flex items-center gap-2 transition-all hover:scale-105">
                <i class="fas fa-search"></i>
                <span class="font-medium">Rechercher</span>
            </a>

            <button class="bg-white/20 hover:bg-white/30 px-5 py-2.5 rounded-xl flex items-center gap-2 transition-all hover:scale-105">
                <i class="fas fa-sign-out-alt"></i>
                <span class="font-medium">Déconnexion</span>
            </button>
        </div>
    </div>
</header>

<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">

    <!-- Titre de la page -->
    <div class="glass-effect p-8 rounded-3xl shadow-2xl mb-8">
        <h2 class="text-3xl font-bold text-gray-800 flex items-center gap-3">
            <i class="fas fa-calendar-check text-[#3dd1a8]"></i>
            Mes Rendez-vous
        </h2>
        <p class="text-gray-600 mt-2">Consultez et gérez vos rendez-vous médicaux</p>
    </div>

    <!-- Messages -->
    <div class="glass-effect p-4 rounded-2xl mb-6 border-l-4 border-green-500">
        <p class="text-gray-800 font-medium">
            <i class="fas fa-check-circle text-green-500 mr-2"></i>
            Votre rendez-vous a été confirmé avec succès
        </p>
    </div>

    <!-- Liste des rendez-vous -->
<%--    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">--%>
        <!-- Rendez-vous 1 -->

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

            <c:forEach var="a" items="${appointments}">
                <div class="appointment-card card-enter">
                    <!-- En-tête avec médecin -->
                    <div class="flex items-center gap-4 mb-6">
                        <div class="w-16 h-16 rounded-full border-3 border-[#3dd1a8] shadow-lg bg-gray-200 flex items-center justify-center">
                            <i class="fas fa-user-md text-gray-500 text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-lg font-bold text-gray-800">
                                Dr. ${a.doctor.titre}
                            </h3>
                            <p class="text-sm text-[#3dd1a8] font-medium">
                                <i class="fas fa-stethoscope mr-1"></i>
                                    ${a.doctor.speciality.nom}
                            </p>
                        </div>
                    </div>

                    <!-- Informations du rendez-vous -->
                    <div class="bg-gradient-to-br from-gray-50 to-gray-100 p-4 rounded-xl mb-4 space-y-3">
                        <div class="flex items-center gap-3 text-gray-700">
                            <i class="fas fa-calendar text-[#3dd1a8]"></i>
                            <span class="font-semibold">
                                    ${a.dateDebut}
                            </span>
                        </div>

                        <div class="flex items-center gap-3 text-gray-700">
                            <i class="fas fa-clock text-[#3dd1a8]"></i>
                            <span class="font-semibold">
                        ${a.heureDebut} - ${a.heureFin}
                    </span>
                        </div>

                        <div class="flex items-center gap-3">
                            <i class="fas fa-info-circle text-[#3dd1a8]"></i>
                            <c:choose>
                                <c:when test="${a.statut == 'COMPLETED'}">
                            <span class="status-badge status-confirme">
                                <i class="fas fa-check-circle"></i> Confirmé
                            </span>
                                </c:when>
                                <c:when test="${a.statut == 'PENDING'}">
                            <span class="status-badge status-en-attente">
                                <i class="fas fa-hourglass-half"></i> En attente
                            </span>
                                </c:when>
                                <c:otherwise>
                            <span class="status-badge status-annule">
                                <i class="fas fa-times-circle"></i> Annulé
                            </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Bouton d'annulation si statut != annulé -->
                    <c:if test="${a.statut == 'PENDING'}">
                        <button onclick="cancelAppointment('${a.id}')"
                                class="btn-cancel w-full flex items-center justify-center gap-2">
                            <i class="fas fa-times"></i>
                            Annuler le rendez-vous
                        </button>
                    </c:if>
                </div>
            </c:forEach>
        </div>


    <%--        <div class="appointment-card card-enter" style="animation-delay: 0s">--%>
<%--            <!-- En-tête avec médecin -->--%>
<%--            <div class="flex items-center gap-4 mb-6">--%>
<%--                <div class="relative">--%>
<%--                    <div class="w-16 h-16 rounded-full border-3 border-[#3dd1a8] shadow-lg bg-gray-200 flex items-center justify-center">--%>
<%--                        <i class="fas fa-user-md text-gray-500 text-xl"></i>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="flex-1">--%>
<%--                    <h3 class="text-lg font-bold text-gray-800">Dr. Martin Dubois</h3>--%>
<%--                    <p class="text-sm text-[#3dd1a8] font-medium">--%>
<%--                        <i class="fas fa-stethoscope mr-1"></i>--%>
<%--                        Cardiologie--%>
<%--                    </p>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Informations du rendez-vous -->--%>
<%--            <div class="bg-gradient-to-br from-gray-50 to-gray-100 p-4 rounded-xl mb-4 space-y-3">--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-calendar text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">15 Mars 2024</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-clock text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">10:30 - 11:00</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3">--%>
<%--                    <i class="fas fa-info-circle text-[#3dd1a8]"></i>--%>
<%--                    <span class="status-badge status-confirme">--%>
<%--                        <i class="fas fa-check-circle"></i>--%>
<%--                        Confirmé--%>
<%--                    </span>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Actions -->--%>
<%--            <button onclick="cancelAppointment(1)"--%>
<%--                    class="btn-cancel w-full flex items-center justify-center gap-2">--%>
<%--                <i class="fas fa-times"></i>--%>
<%--                Annuler le rendez-vous--%>
<%--            </button>--%>
<%--        </div>--%>

        <!-- Rendez-vous 2 -->
<%--        <div class="appointment-card card-enter" style="animation-delay: 0.1s">--%>
<%--            <!-- En-tête avec médecin -->--%>
<%--            <div class="flex items-center gap-4 mb-6">--%>
<%--                <div class="relative">--%>
<%--                    <div class="w-16 h-16 rounded-full border-3 border-[#3dd1a8] shadow-lg bg-gray-200 flex items-center justify-center">--%>
<%--                        <i class="fas fa-user-md text-gray-500 text-xl"></i>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="flex-1">--%>
<%--                    <h3 class="text-lg font-bold text-gray-800">Dr. Sophie Laurent</h3>--%>
<%--                    <p class="text-sm text-[#3dd1a8] font-medium">--%>
<%--                        <i class="fas fa-stethoscope mr-1"></i>--%>
<%--                        Dermatologie--%>
<%--                    </p>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Informations du rendez-vous -->--%>
<%--            <div class="bg-gradient-to-br from-gray-50 to-gray-100 p-4 rounded-xl mb-4 space-y-3">--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-calendar text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">18 Mars 2024</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-clock text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">14:15 - 14:45</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3">--%>
<%--                    <i class="fas fa-info-circle text-[#3dd1a8]"></i>--%>
<%--                    <span class="status-badge status-en-attente">--%>
<%--                        <i class="fas fa-hourglass-half"></i>--%>
<%--                        En attente--%>
<%--                    </span>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Actions -->--%>
<%--            <button onclick="cancelAppointment(2)"--%>
<%--                    class="btn-cancel w-full flex items-center justify-center gap-2">--%>
<%--                <i class="fas fa-times"></i>--%>
<%--                Annuler le rendez-vous--%>
<%--            </button>--%>
<%--        </div>--%>

        <!-- Rendez-vous 3 -->
<%--        <div class="appointment-card card-enter" style="animation-delay: 0.2s">--%>
<%--            <!-- En-tête avec médecin -->--%>
<%--            <div class="flex items-center gap-4 mb-6">--%>
<%--                <div class="relative">--%>
<%--                    <div class="w-16 h-16 rounded-full border-3 border-[#3dd1a8] shadow-lg bg-gray-200 flex items-center justify-center">--%>
<%--                        <i class="fas fa-user-md text-gray-500 text-xl"></i>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="flex-1">--%>
<%--                    <h3 class="text-lg font-bold text-gray-800">Dr. Pierre Moreau</h3>--%>
<%--                    <p class="text-sm text-[#3dd1a8] font-medium">--%>
<%--                        <i class="fas fa-stethoscope mr-1"></i>--%>
<%--                        Orthopédie--%>
<%--                    </p>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Informations du rendez-vous -->--%>
<%--            <div class="bg-gradient-to-br from-gray-50 to-gray-100 p-4 rounded-xl mb-4 space-y-3">--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-calendar text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">22 Mars 2024</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3 text-gray-700">--%>
<%--                    <i class="fas fa-clock text-[#3dd1a8]"></i>--%>
<%--                    <span class="font-semibold">09:00 - 09:30</span>--%>
<%--                </div>--%>
<%--                <div class="flex items-center gap-3">--%>
<%--                    <i class="fas fa-info-circle text-[#3dd1a8]"></i>--%>
<%--                    <span class="status-badge status-annule">--%>
<%--                        <i class="fas fa-times-circle"></i>--%>
<%--                        Annulé--%>
<%--                    </span>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Pas d'action pour un rendez-vous annulé -->--%>
<%--        </div>--%>
<%--    --%>
    </div>

</main>

<script>
    function cancelAppointment(appointmentId) {
        Swal.fire({
            title: 'Annuler le rendez-vous',
            text: 'Êtes-vous sûr de vouloir annuler ce rendez-vous ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#6b7280',
            confirmButtonText: 'Oui, annuler',
            cancelButtonText: 'Non, conserver'
        }).then((result) => {
            if (result.isConfirmed) {
                // Simulation d'annulation
                Swal.fire(
                    'Annulé!',
                    'Votre rendez-vous a été annulé.',
                    'success'
                );
            }
        });
    }
</script>

</body>
</html>