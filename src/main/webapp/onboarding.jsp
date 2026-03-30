<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>

<%
    // ✅ AUTH CHECK
    Integer userIdObj = (Integer) session.getAttribute("userId");
    User user = (User) session.getAttribute("user");

    if (userIdObj == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ SKIP IF ALREADY COMPLETED
    if (user.isProfileComplete()) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Onboarding – Garbh Sakhi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/modern-style.css">

    <style>
        body.auth-bg {
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            background: linear-gradient(135deg, #f6a7d4, #a9d6f7);
            font-family: 'Poppins', system-ui, sans-serif;
            padding: 40px 16px 60px;
            box-sizing: border-box;
        }

        .auth-card {
            width: 100%;
            max-width: 820px;
            background: #fff;
            border-radius: 20px;
            padding: 36px 32px 32px;
            box-shadow: 0 16px 40px rgba(12,20,30,0.10);
            box-sizing: border-box;
            text-align: center;
        }

        .auth-card h2 {
            font-size: 24px;
            font-weight: 700;
            color: #243041;
            margin: 0 0 6px;
        }

        .auth-card > p {
            color: #475569;
            font-size: 14px;
            margin: 0 0 28px;
        }

        .auth-card form {
            text-align: left;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        @media (max-width: 640px) {
            .row {
                grid-template-columns: 1fr;
            }
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 16px;
        }

        .field label {
            font-weight: 600;
            font-size: 14px;
            color: #374151;
        }

        .field input,
        .field textarea {
            padding: 11px 13px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            font-size: 14px;
            outline: none;
            transition: border .15s, box-shadow .15s;
            width: 100%;
            box-sizing: border-box;
            font-family: inherit;
        }

        .field input:focus,
        .field textarea:focus {
            border-color: #d16aa7;
            box-shadow: 0 0 0 3px rgba(209,106,167,0.12);
        }

        textarea {
            resize: vertical;
            height: 90px;
        }

        .btn-primary {
            margin-top: 8px;
            width: 100%;
            padding: 13px;
            border-radius: 12px;
            background: linear-gradient(135deg, #ffb3cf, #ff7aa6);
            color: #fff;
            border: none;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 6px 18px rgba(255,122,150,0.18);
            transition: transform .15s, box-shadow .15s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(255,122,150,0.28);
        }
    </style>
</head>

<body class="auth-bg">

<div class="auth-card">
    <h2>Complete Your Profile 🌸</h2>
    <p>Help us personalise your pregnancy journey.</p>

    <form action="<%= request.getContextPath() %>/onboarding" method="post">

        <div class="row">
            <div class="field">
                <label>Full Name</label>
                <input type="text" name="full_name" placeholder="Your full name" required>
            </div>

            <div class="field">
                <label>Age</label>
                <input type="number" name="age" placeholder="Your age" required>
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Username</label>
                <input type="text" name="username" placeholder="Choose a username" required>
            </div>

            <div class="field">
                <label>Phone Number</label>
                <input type="tel" name="phone" placeholder="Mobile number" required>
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Due Date</label>
                <input type="date" name="due_date" required>
            </div>

            <div class="field">
                <label>Doctor Name</label>
                <input type="text" name="doctor_name" placeholder="Doctor's name">
            </div>
        </div>

        <div class="field">
            <label>Hospital / Clinic</label>
            <input type="text" name="hospital_name" placeholder="Hospital or clinic name">
        </div>

        <div class="field">
            <label>Complications (if any)</label>
            <textarea name="complications" placeholder="Leave blank if none"></textarea>
        </div>

        <button class="btn-primary" type="submit">
            Finish Setup →
        </button>

    </form>
</div>

</body>
</html>