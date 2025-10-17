<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 09/10/2025
  Time: 23:42
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Clinique Digitale</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Configuration Tailwind -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'medical': {
                            50: '#f0fdfa',
                            100: '#ccfbef',
                            200: '#99f6e4',
                            300: '#68e4c2',
                            400: '#3dd1a8',
                            500: '#16a78c',
                            600: '#0d8c73',
                            700: '#0a705d',
                            800: '#085a4a',
                            900: '#06493c',
                        }
                    }
                }
            }
        }
    </script>

    <style>
        .floating-card {
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .medical-icon {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }
        .transition-all {
            transition: all 0.3s ease;
        }

        /* Améliorations pour mobile */
        @media (max-width: 640px) {
            .mobile-padding {
                padding: 1.5rem;
            }
            .mobile-space {
                margin-bottom: 1rem;
            }
            .mobile-grid {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }
        }

        /* Amélioration de l'accessibilité */
        .form-input:focus {
            outline: 2px solid #3dd1a8;
            outline-offset: 2px;
        }

        /* Animation pour l'apparition des champs */
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-medical-50 to-medical-100">
<div class="w-full max-w-2xl mx-auto">
    <div class="bg-white rounded-2xl shadow-xl overflow-hidden floating-card">
        <!-- En-tête -->
        <div class="p-6 bg-gradient-to-r from-medical-300 to-medical-500 text-white text-center">
            <div class="flex justify-center mb-4">
                <div class="medical-icon w-16 h-16 rounded-full flex items-center justify-center shadow-lg">
                    <i class="fas fa-user-plus text-2xl"></i>
                </div>
            </div>
            <h1 class="text-2xl font-bold">Clinique Digitale</h1>
            <p class="text-medical-100 mt-2">Créez votre compte médical sécurisé</p>
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
        </div>

        <!-- Pied de page -->
        <div class="bg-gray-50 px-6 md:px-8 py-4 border-t border-gray-200">
            <div class="flex justify-center space-x-6">
                <a href="#" class="text-gray-400 hover:text-medical-400 transition-all transform hover:-translate-y-1">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#" class="text-gray-400 hover:text-medical-400 transition-all transform hover:-translate-y-1">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="#" class="text-gray-400 hover:text-medical-400 transition-all transform hover:-translate-y-1">
                    <i class="fab fa-linkedin-in"></i>
                </a>
            </div>
            <p class="mt-3 text-center text-xs text-gray-500">
                &copy; 2025 Clinique Digitale. Tous droits réservés.
            </p>
        </div>
    </div>
</div>

<!-- === IMPORTATION DES SCRIPTS === -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<%--<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>--%>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // ======= Toggle password =======
        const togglePassword = document.getElementById('togglePassword');
        togglePassword.addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            passwordInput.type = passwordInput.type === 'password' ? 'text' : 'password';
            icon.classList.toggle('fa-eye-slash');
            icon.classList.toggle('fa-eye');
        });
    });

</script>


</body>
</html>