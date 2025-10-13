<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digitale</title>

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

    <!-- CSS personnalisé (optionnel) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="min-h-screen flex items-center justify-center p-4" style="background: linear-gradient(135deg, #f0fdfa 0%, #ccfbef 100%);">

<div class="max-w-md w-full bg-white rounded-2xl shadow-xl overflow-hidden floating-card">
    <!-- En-tête -->
    <div class="p-6 bg-gradient-to-r from-medical-300 to-medical-500 text-white text-center">
        <div class="flex justify-center mb-4">
            <div class="medical-icon w-16 h-16 rounded-full flex items-center justify-center shadow-lg">
                <i class="fas fa-heartbeat text-2xl"></i>
            </div>
        </div>
        <h1 class="text-2xl font-bold">Clinique Digitale</h1>
        <p class="text-medical-100 mt-2">Accédez à votre espace médical sécurisé</p>
    </div>

    <!-- Formulaire de connexion -->
    <div class="p-8">
        <form id="loginForm" class="space-y-6" action="/login" method="post">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Adresse email</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-medical-400"></i>
                    </div>
                    <input type="email" id="email" name="email" required
                           class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition"
                           placeholder="votre@email.com">
                </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mot de passe</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-lock text-medical-400"></i>
                    </div>
                    <input type="password" id="password" name="password" required
                           class="block w-full pl-10 pr-10 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition"
                           placeholder="Votre mot de passe">
                    <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 pr-3 flex items-center">
                        <i class="fas fa-eye text-medical-400"></i>
                    </button>
                </div>
            </div>

            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <input id="remember-me" name="remember-me" type="checkbox"
                           class="h-4 w-4 text-medical-400 focus:ring-medical-300 border-gray-300 rounded">
                    <label for="remember-me" class="ml-2 block text-sm text-gray-700">Se souvenir de moi</label>
                </div>
                <a href="#" class="text-sm font-medium text-medical-500 hover:text-medical-400 transition">
                    Mot de passe oublié ?
                </a>
            </div>

            <div>
                <button type="submit"
                        class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-medical-400 hover:bg-medical-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-medical-300 transition transform hover:-translate-y-0.5">
                    <i class="fas fa-sign-in-alt mr-2"></i>
                    Se connecter
                </button>
            </div>
        </form>

        <div class="mt-6">
            <div class="relative">
                <div class="absolute inset-0 flex items-center">
                    <div class="w-full border-t border-gray-300"></div>
                </div>
                <div class="relative flex justify-center text-sm">
                    <span class="px-2 bg-white text-gray-500">Première visite ?</span>
                </div>
            </div>

            <div class="mt-4">
                <a href="/register" class="w-full flex justify-center py-3 px-4 border border-medical-300 rounded-lg shadow-sm text-sm font-medium text-medical-600 bg-medical-50 hover:bg-medical-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-medical-300 transition">
                    <i class="fas fa-user-plus mr-2"></i>
                    Créer un compte
                </a>
            </div>
        </div>
    </div>

    <!-- Pied de page -->
    <div class="bg-gray-50 px-8 py-4 border-t border-gray-200">
        <div class="flex justify-center space-x-6">
            <a href="#" class="text-gray-400 hover:text-medical-400 transition transform hover:-translate-y-1">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#" class="text-gray-400 hover:text-medical-400 transition transform hover:-translate-y-1">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="#" class="text-gray-400 hover:text-medical-400 transition transform hover:-translate-y-1">
                <i class="fab fa-linkedin-in"></i>
            </a>
        </div>
        <p class="mt-3 text-center text-xs text-gray-500">
            &copy; 2025 Clinique Digitale. Tous droits réservés.
        </p>
    </div>
</div>

<!-- === IMPORTATION DES SCRIPTS === -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
