<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinic Management - Doctor Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3dd1a8',
                        'primary-light': '#a8f0dc',
                        secondary: '#8338ec',
                        success: '#06d6a0',
                        warning: '#ffd166',
                        danger: '#ef476f',
                        dark: '#1a1a2e',
                        light: '#f8f9fa',
                        gray: {
                            DEFAULT: '#6c757d',
                            light: '#e9ecef'
                        }
                    },
                    boxShadow: {
                        'card': '0 4px 12px rgba(0, 0, 0, 0.08)',
                        'card-hover': '0 8px 16px rgba(0, 0, 0, 0.1)'
                    }
                }
            }
        }
    </script>

</head>
<body class="bg-gray-50 font-sans text-dark">
<div class="flex min-h-screen">
