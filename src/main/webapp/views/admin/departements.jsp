<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 13/10/2025
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Page Header -->
<div class="flex justify-between items-center mb-6">
    <div>
        <h1 class="text-3xl font-bold">Departments Management</h1>
        <p class="text-gray mt-2">Manage hospital departments and medical specialties</p>
    </div>
    <button id="add-department-btn" class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-500 transition-colors duration-300">
        <i class="fas fa-plus"></i>
        Add Department
    </button>
</div>

<!-- Departments Table -->
<div class="bg-white rounded-xl shadow-card overflow-hidden">
    <div class="flex justify-between items-center p-6 border-b border-gray-light">
        <h3 class="text-lg font-semibold">Hospital Departments</h3>
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
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Department</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Head of Department</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Specialties</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Staff Count</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Beds</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Status</th>
                <th class="text-left py-4 px-6 text-gray text-xs font-semibold uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-light" id="departments-table-body">
            <!-- Les données des départements seront chargées ici dynamiquement -->
            </tbody>
        </table>
    </div>
</div>

<!-- Department Modal -->
<div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden" id="departmentModal">
    <div class="bg-white rounded-xl w-full max-w-2xl shadow-2xl">
        <div class="flex justify-between items-center p-6 border-b border-gray-light">
            <h3 class="text-xl font-semibold" id="modal-title">Add New Department</h3>
            <button class="text-gray text-2xl hover:text-dark transition-colors duration-200" id="close-modal">&times;</button>
        </div>
        <div class="p-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Department Name</label>
                    <input type="text" id="dept-name" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter department name">
                </div>
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Department Code</label>
                    <input type="text" id="dept-code" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter department code">
                </div>
            </div>
            <div class="mb-5">
                <label class="block text-sm font-medium mb-2">Head of Department</label>
                <select id="dept-head" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary">
                    <option value="">Select Head of Department</option>
                    <option value="Dr. Sarah Johnson">Dr. Sarah Johnson</option>
                    <option value="Dr. Robert Williams">Dr. Robert Williams</option>
                    <option value="Dr. Amanda Lee">Dr. Amanda Lee</option>
                    <option value="Dr. Michael Chen">Dr. Michael Chen</option>
                </select>
            </div>
            <div class="mb-5">
                <label class="block text-sm font-medium mb-2">Specialties</label>
                <div class="border border-gray-light rounded-lg p-4 max-h-40 overflow-y-auto">
                    <div class="grid grid-cols-2 gap-3">
                        <div class="flex items-center">
                            <input type="checkbox" id="cardiology" class="mr-2" value="Cardiology">
                            <label for="cardiology">Cardiology</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="orthopedics" class="mr-2" value="Orthopedics">
                            <label for="orthopedics">Orthopedics</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="pediatrics" class="mr-2" value="Pediatrics">
                            <label for="pediatrics">Pediatrics</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="neurology" class="mr-2" value="Neurology">
                            <label for="neurology">Neurology</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="dermatology" class="mr-2" value="Dermatology">
                            <label for="dermatology">Dermatology</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="oncology" class="mr-2" value="Oncology">
                            <label for="oncology">Oncology</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="surgery" class="mr-2" value="Surgery">
                            <label for="surgery">Surgery</label>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="radiology" class="mr-2" value="Radiology">
                            <label for="radiology">Radiology</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Staff Count</label>
                    <input type="number" id="staff-count" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter staff count">
                </div>
                <div class="mb-5">
                    <label class="block text-sm font-medium mb-2">Available Beds</label>
                    <input type="number" id="available-beds" class="w-full border border-gray-light rounded-lg px-4 py-3 outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="Enter available beds">
                </div>
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
            <button class="bg-primary text-white px-6 py-2 rounded-lg font-medium hover:bg-green-500 transition-colors duration-300" id="save-btn">Save Department</button>
        </div>
    </div>
</div>
