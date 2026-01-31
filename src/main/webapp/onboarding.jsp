<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Integer userIdObj = (Integer) session.getAttribute("userId");
    if (userIdObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Onboarding – Garbh Sakhi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/modern-style.css">

    <style>
        body.auth-bg {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background: linear-gradient(135deg, #f6a7d4, #a9d6f7);
            padding-top: 90px;
        }
        .auth-card {
            width: 100%;
            max-width: 820px;
            background: #fff;
            border-radius: 14px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(12,20,30,0.08);
        }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .field { display: flex; flex-direction: column; gap: 6px; }
        label { font-weight: 600; font-size: 14px; }
        input, textarea {
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #e6e6ee;
        }
        textarea { resize: vertical; height: 90px; }
        .btn-primary {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            background: linear-gradient(180deg,#ffb3cf,#ff7aa6);
            color: #fff;
            border: none;
            font-weight: 700;
        }
        @media (max-width: 800px) {
            .row { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body class="auth-bg">
<div class="auth-card">

    <h2 style="text-align:center;">Complete Your Profile</h2>
    <p style="text-align:center;color:#475569;">
        Help us personalize your pregnancy journey.
    </p>

    <form action="<%= request.getContextPath() %>/onboarding" method="post">

        <div class="row">
            <div class="field">
                <label>Full Name</label>
                <input type="text" name="full_name" required>
            </div>
            <div class="field">
                <label>Age</label>
                <input type="number" name="age" required>
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Due Date</label>
                <input type="date" name="due_date" required>
            </div>
            <div class="field">
                <label>Doctor Name</label>
                <input type="text" name="doctor_name">
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Hospital Name</label>
                <input type="text" name="hospital_name">
            </div>
        </div>

        <div class="field" style="margin-top:12px;">
            <label>Complications (if any)</label>
            <textarea name="complications"></textarea>
        </div>

        <button class="btn-primary" type="submit">Finish Setup</button>
    </form>

</div>
</body>
</html>
