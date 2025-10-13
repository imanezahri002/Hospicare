document.addEventListener('DOMContentLoaded', function() {
    // ======= Gestion des champs spécifiques au rôle =======
    const roleSelect = document.getElementById('role');
    const roleSpecificFields = document.getElementById('roleSpecificFields');

    const specialities = [
        { id: 1, name: "Cardiologie" },
        { id: 2, name: "Dermatologie" },
        { id: 3, name: "Gynécologie" },
        { id: 4, name: "Neurologie" },
        { id: 5, name: "Pédiatrie" },
        { id: 6, name: "Psychiatrie" },
        { id: 7, name: "Radiologie" },
        { id: 8, name: "Chirurgie" }
    ];

    roleSelect.addEventListener('change', function() {
        const role = this.value;
        roleSpecificFields.innerHTML = '';

        if (role === 'DOCTOR') {
            roleSpecificFields.classList.remove('hidden');
            roleSpecificFields.innerHTML = `
                <h3 class="text-lg font-medium text-medical-600 border-b pb-2">Informations professionnelles</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Titre</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user-md text-medical-400"></i>
                            </div>
                            <input type="text" id="title" name="title"
                                   class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="Dr. ...">
                        </div>
                    </div>
                    <div>
                        <label for="matricule" class="block text-sm font-medium text-gray-700 mb-1">Matricule</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-id-card text-medical-400"></i>
                            </div>
                            <input type="text" id="matricule" name="matricule"
                                   class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all"
                                   placeholder="Votre matricule">
                        </div>
                    </div>
                </div>
                <div>
                    <label for="speciality" class="block text-sm font-medium text-gray-700 mb-1">Spécialité</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-stethoscope text-medical-400"></i>
                        </div>
                        <select id="speciality" name="speciality"
                                class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all appearance-none">
                            <option value="">Sélectionnez votre spécialité</option>
                            ${specialities.map(spec => `<option value="${spec.id}">${spec.name}</option>`).join('')}
                        </select>
                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                            <i class="fas fa-chevron-down text-medical-400"></i>
                        </div>
                    </div>
                </div>
            `;
        } else if (role === 'PATIENT')  {
            roleSpecificFields.classList.remove('hidden');

            // Ajouter les champs pour le patient
            roleSpecificFields.innerHTML = `
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
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
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
                                <select id="gender" name="gender"
                                        class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-300 focus:border-medical-300 transition-all appearance-none">
                                    <option value="">Sélectionnez votre sexe</option>
                                    <option value="MALE">Masculin</option>
                                    <option value="FEMALE">Féminin</option>
                                </select>
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                    <i class="fas fa-chevron-down text-medical-400"></i>
                                </div>
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
                `;
        }
        else {
            roleSpecificFields.classList.add('hidden');
        }
    });

    // ======= Toggle password =======
    const togglePassword = document.getElementById('togglePassword');
    const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');

    togglePassword.addEventListener('click', function() {
        const passwordInput = document.getElementById('password');
        const icon = this.querySelector('i');
        passwordInput.type = passwordInput.type === 'password' ? 'text' : 'password';
        icon.classList.toggle('fa-eye-slash');
        icon.classList.toggle('fa-eye');
    });

    toggleConfirmPassword.addEventListener('click', function() {
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const icon = this.querySelector('i');
        confirmPasswordInput.type = confirmPasswordInput.type === 'password' ? 'text' : 'password';
        icon.classList.toggle('fa-eye-slash');
        icon.classList.toggle('fa-eye');
    });

    // ======= Validation du formulaire =======
    const registerForm = document.getElementById('registerForm');
    registerForm.addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Les mots de passe ne correspondent pas.');
            return false;
        }
    });

    // ======= Test si JS fonctionne =======
    console.log("register.js chargé ✅");
});
