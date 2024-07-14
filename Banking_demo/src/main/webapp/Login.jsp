<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interactive Banking Dashboard</title>
</head>

<style>
    :root {
        --primary-color: #007bff;
        --secondary-color: #6c757d;
        --bg-color: #f8f9fa;
        --text-color: #333;
        --card-bg: #ffffff;
    }

    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        transition: all 0.3s ease;
    }

    @keyframes gradientBG {
        0% {
            background-position: 0% 50%;
        }

        50% {
            background-position: 100% 50%;
        }

        100% {
            background-position: 0% 50%;
        }
    }

    .container {
        perspective: 1000px;
    }

    .login-card {
        background-color: var(--card-bg);
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0, 0, 0, 0.23);
        transform-style: preserve-3d;
        transition: all 0.3s ease;
    }

    h1 {
        color: var(--primary-color);
        text-align: center;
        margin-bottom: 1.5rem;
    }

    .form-group {
        margin-bottom: 1rem;
    }

    label {
        display: block;
        margin-bottom: 0.5rem;
        color: var(--text-color);
    }

    input,
    select {
        width: 100%;
        padding: 0.5rem;
        border: 1px solid var(--secondary-color);
        border-radius: 4px;
        transition: all 0.3s ease;
    }

    input:focus,
    select:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
    }

    button {
        width: 100%;
        padding: 0.75rem;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    button:hover {
        background-color: #0056b3;
    }

    .password-strength {
        height: 5px;
        margin-top: 5px;
        border-radius: 2px;
        transition: all 0.3s ease;
    }

    .theme-toggle {
        position: fixed;
        top: 20px;
        right: 20px;
        font-size: 24px;
        cursor: pointer;
    }

    body.dark-theme {
        --primary-color: #61dafb;
        --secondary-color: #8a8d91;
        --bg-color: #282c34;
        --text-color: #ffffff;
        --card-bg: #363a43;
    }
</style>

<body>
    <div class="container">
        <div class="login-card">
            <h1> Banking Dashboard </h1>
            <form id="loginForm" action="login" method="get">
                <div class="form-group">
                    <label for="userType">User Type:</label>
                    <select id="userType" name="role">
                        <option value="admin">Admin</option>
                        <option value="customer">User</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="usr" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <div id="passwordStrength" class="password-strength"></div>
                </div>
                <button type="submit" id="submitBtn">Submit</button>
            </form>
        </div>
    </div>
    <div id="themeToggle" class="theme-toggle">🌓</div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const loginForm = document.getElementById('loginForm');
            const passwordInput = document.getElementById('password');
            const passwordStrength = document.getElementById('passwordStrength');
            const submitBtn = document.getElementById('submitBtn');
            const themeToggle = document.getElementById('themeToggle');
            const loginCard = document.querySelector('.login-card');

           56+
            passwordInput.addEventListener('input', function () {
                const strength = calculatePasswordStrength(this.value);
                passwordStrength.style.width = `${strength}%`;
                passwordStrength.style.backgroundColor = getStrengthColor(strength);
            });

         
            

       
            themeToggle.addEventListener('click', function () {
                document.body.classList.toggle('dark-theme');
            });

            function calculatePasswordStrength(password) {
                // Simple password strength calculation
                return Math.min(100, password.length * 10);
            }

            function getStrengthColor(strength) {
                if (strength < 30) return '#ff4d4d';
                if (strength < 60) return '#ffa64d';
                return '#4CAF50';
            }
        });
    </script>
</body>

</html>