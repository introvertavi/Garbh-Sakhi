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

    <!-- App CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/modern-style.css">

    <style>
        :root { --top-header-h: 90px; }

        body.auth-bg {
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
            font-family: system-ui, -apple-system, "Segoe UI", Roboto;
            padding-top: calc(var(--top-header-h) + 18px);
            box-sizing: border-box;
        }

        .auth-card {
            width: 100%;
            max-width: 820px;
            background: #fff;
            border-radius: 14px;
            padding: 38px 36px;
            box-shadow: 0 10px 30px rgba(12, 20, 30, 0.08);
            margin-bottom: 40px;
            box-sizing: border-box;
        }

        .auth-top {
            text-align: center;
            margin-bottom: 12px;
        }

        .auth-logo {
            width: 110px;
            height: 110px;
            object-fit: contain;
            display: inline-block;
            margin-bottom: 12px;
            border-radius: 16px;
            padding: 10px;
        }

        .auth-title {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            color: #243041;
        }

        .auth-sub {
            color: #475569;
            margin-top: 8px;
            margin-bottom: 8px;
        }

        form .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-top: 12px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            color: #243041;
            font-weight: 600;
            font-size: 14px;
        }

        input, textarea {
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #e6e6ee;
            font-size: 15px;
        }

        textarea {
            resize: vertical;
            height: 90px;
        }

        .btn-primary {
            width: 100%;
            background: linear-gradient(180deg, #ffb3cf, #ff7aa6);
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 20px;
        }

        @media (max-width: 900px) {
            .auth-card {
                max-width: 92%;
                padding: 20px;
            }
            form .row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body class="auth-bg">

<div class="auth-card">

    <div class="auth-top">
        <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png"
             class="auth-logo"
             alt="Garbh Sakhi Logo">

        <div class="auth-title">Complete Your Profile</div>
        <div class="auth-sub">Help us personalize your wellness journey.</div>
    </div>

    <form action="<%= request.getContextPath() %>/onboarding" method="post">

        <div class="row">
            <div class="field">
                <label>Full Name</label>
                <input type="text" name="full_name" required>
            </div>
            <div class="field">
                <label>Phone</label>
                <input type="text" name="phone" required>
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Age</label>
                <input type="number" name="age" required>
            </div>
            <div class="field">
                <label>Due Date</label>
                <input type="date" name="due_date" required>
            </div>
        </div>

        <div class="row">
            <div class="field">
                <label>Doctor Name</label>
                <input type="text" name="doctor_name">
            </div>
            <div class="field">
                <label>Hospital Name</label>
                <input type="text" name="hospital_name">
            </div>
        </div>

        <div class="field" style="margin-top:12px;">
            <label>Complications</label>
            <textarea name="complications"></textarea>
        </div>

        <h3 style="margin-top:18px;">Emergency Contacts</h3>

        <div class="row">
            <div class="field"><input name="ec1_name" placeholder="Name" required></div>
            <div class="field"><input name="ec1_phone" placeholder="Phone" required></div>
        </div>

        <div class="row">
            <div class="field"><input name="ec2_name" placeholder="Name" required></div>
            <div class="field"><input name="ec2_phone" placeholder="Phone" required></div>
        </div>

        <div class="row">
            <div class="field"><input name="ec3_name" placeholder="Name" required></div>
            <div class="field"><input name="ec3_phone" placeholder="Phone" required></div>
        </div>

        <button class="btn-primary" type="submit">Finish Setup</button>
    </form>

</div>
</body>
</html>
