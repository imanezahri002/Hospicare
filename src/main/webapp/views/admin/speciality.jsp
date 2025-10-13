<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Entete--->
<!-- Page Header -->
<div class="flex justify-between items-center mb-6">
    <div>
        <h1 class="text-3xl font-bold">Specialties Management</h1>
        <p class="text-gray mt-2">Manage medical specialties and their configurations</p>
    </div>
    <button id="add-specialty-btn" class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
        <i class="fas fa-plus"></i>
        Add Specialty
    </button>
</div>

<!-- Specialties Table -->
<div class="bg-white rounded-xl shadow-card overflow-hidden">
    <div class="flex justify-between items-center p-6 border-b border-gray-light">
        <h3 class="text-lg font-semibold">Medical Specialties</h3>
        <div class="flex gap-3">
            <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                <i class="fas fa-filter"></i>
                Filter
            </button>
            <button class="border border-gray-light text-gray px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-gray-50 transition-colors duration-300">
                <i class="fas fa-download"></i>
                Export
            </button>
        </div>
    </div>
    <div class="overflow-x-auto">
        <table class="w-full">
            <thead>
            <tr class="bg-gray-50">
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Specialty</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Code</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Department</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Specialists</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Consultation Time</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-light" id="specialties-table-body">
            <!-- Les données des spécialités seront chargées ici dynamiquement -->
            </tbody>
        </table>
    </div>
</div>

<!-- Specialty Modal -->
<div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="specialtyModal">
    <div class="bg-white rounded-xl w-full max-w-2xl shadow-2xl">
        <div class="flex justify-between items-center p-6 border-b border-gray-light">
            <h3 class="text-xl font-semibold" id="modal-title">Add New Specialty</h3>
            <button class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
        </div>
        <div class="p-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Specialty Name *</label>
                    <input type="text" id="specialty-name" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty name">
                </div>
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Specialty Code *</label>
                    <input type="text" id="specialty-code" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty code">
                </div>
            </div>
            <div class="mb-5">
                <label class="block text-sm font-medium mb-2">Department *</label>
                <select id="specialty-department" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                    <option value="">Select Department</option>
                    <option value="Cardiology">Cardiology</option>
                    <option value="Orthopedics">Orthopedics</option>
                    <option value="Pediatrics">Pediatrics</option>
                    <option value="Neurology">Neurology</option>
                    <option value="Dermatology">Dermatology</option>
                    <option value="Oncology">Oncology</option>
                    <option value="Surgery">Surgery</option>
                </select>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Number of Specialists *</label>
                    <input type="number" id="specialists-count" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter number of specialists">
                </div>
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Consultation Time (minutes) *</label>
                    <input type="number" id="consultation-time" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter consultation time">
                </div>
            </div>
            <div class="mb-5">
                <label class="block text-sm font-medium mb-2">Description</label>
                <textarea id="specialty-description" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter specialty description" rows="3"></textarea>
            </div>
            <div class="mb-5">
                <label class="block text-sm font-medium mb-2">Status</label>
                <div class="flex gap-4">
                    <div class="flex items-center">
                        <input type="radio" id="status-active" name="status" value="active" class="mr-2" checked>
                        <label for="status-active" class="flex items-center">
                            <span class="w-3 h-3 bg-success rounded-full mr-2"></span>
                            Active
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="radio" id="status-inactive" name="status" value="inactive" class="mr-2">
                        <label for="status-inactive" class="flex items-center">
                            <span class="w-3 h-3 bg-danger rounded-full mr-2"></span>
                            Inactive
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex justify-end gap-3 p-6 border-t border-gray-light">
            <button class="border border-gray-light text-gray px-6 py-2 rounded-lg font-medium hover:bg-gray-50 transition-colors duration-300" id="cancel-btn">Cancel</button>
            <button class="bg-primary text-white px-6 py-2 rounded-lg font-medium hover:bg-green-500 transition-colors duration-300" id="save-btn">Save Specialty</button>
        </div>
    </div>
</div>
