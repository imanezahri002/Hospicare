
    document.addEventListener('DOMContentLoaded', function() {
    // Appointments Chart
    const appointmentsCtx = document.getElementById('appointmentsChart').getContext('2d');
    const appointmentsChart = new Chart(appointmentsCtx, {
    type: 'line',
    data: {
    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    datasets: [{
    label: 'Appointments',
    data: [65, 78, 66, 84, 105, 90, 70],
    borderColor: '#3dd1a8',
    backgroundColor: 'rgba(61, 209, 168, 0.1)',
    tension: 0.4,
    fill: true
}, {
    label: 'Cancellations',
    data: [5, 8, 6, 10, 7, 4, 3],
    borderColor: '#ef476f',
    backgroundColor: 'rgba(239, 71, 111, 0.1)',
    tension: 0.4,
    fill: true
}]
},
    options: {
    responsive: true,
    plugins: {
    legend: {
    position: 'top',
}
},
    scales: {
    y: {
    beginAtZero: true
}
}
}
});

    // Departments Chart
    const departmentsCtx = document.getElementById('departmentsChart').getContext('2d');
    const departmentsChart = new Chart(departmentsCtx, {
    type: 'doughnut',
    data: {
    labels: ['Cardiology', 'Orthopedics', 'Pediatrics', 'Neurology', 'Dermatology'],
    datasets: [{
    data: [30, 25, 20, 15, 10],
    backgroundColor: [
    '#3dd1a8',
    '#8338ec',
    '#06d6a0',
    '#ffd166',
    '#ef476f'
    ],
    borderWidth: 0
}]
},
    options: {
    responsive: true,
    plugins: {
    legend: {
    position: 'bottom',
}
}
}
});

    // Modal functionality
    const modal = document.getElementById('userModal');
    const closeModal = document.querySelector('.close-modal');
    const newUserBtn = document.querySelector('.bg-primary');

    newUserBtn.addEventListener('click', function() {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
});

    document.querySelector('#userModal button.text-gray').addEventListener('click', function() {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
});

    window.addEventListener('click', function(event) {
    if (event.target === modal) {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
}
});
});
