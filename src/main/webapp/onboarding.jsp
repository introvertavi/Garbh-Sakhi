<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>

<%
    Integer userIdObj = (Integer) session.getAttribute("userId");
    User user = (User) session.getAttribute("user");

    if (userIdObj == null || user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (user.isProfileComplete()) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complete Your Profile – Garbh Sakhi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/modern-style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">

    <style>
        :root {
            --primary: #ff6f9f;
            --primary-dark: #ea5a8d;
            --secondary: #8fd3ff;
            --text-dark: #243041;
            --text-muted: #667085;
            --border: #e5e7eb;
            --input-bg: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 20px 50px rgba(17, 24, 39, 0.12);
            --soft-pink: #fff5f8;
            --soft-blue: #f2f9ff;
        }

        * {
            box-sizing: border-box;
        }

        body.auth-bg {
            min-height: 100vh;
            margin: 0;
            padding: 32px 16px 56px;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            font-family: "Poppins", system-ui, -apple-system, sans-serif;
            background:
                radial-gradient(circle at top left, rgba(255,255,255,0.30), transparent 35%),
                radial-gradient(circle at bottom right, rgba(255,255,255,0.24), transparent 32%),
                linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
        }

        .auth-card {
            width: 100%;
            max-width: 860px;
            background: var(--card-bg);
            border: 1px solid rgba(255,255,255,0.45);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 34px 30px 30px;
            box-shadow: var(--shadow);
            animation: fadeUp 0.45s ease;
        }

        .top-section {
            text-align: center;
            margin-bottom: 28px;
        }

        .auth-logo {
            width: 84px;
            height: 84px;
            object-fit: cover;
            border-radius: 18px;
            display: inline-block;
            background: #fff;
            padding: 6px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .title {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
            margin: 16px 0 8px;
            line-height: 1.2;
            text-align: center;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.7;
            margin: 0 auto;
            max-width: 560px;
            text-align: center;
        }

        .progress-wrap {
            margin: 24px 0 28px;
        }

        .progress-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 10px;
            font-size: 13px;
            color: #64748b;
        }

        .progress-bar {
            width: 100%;
            height: 10px;
            background: #e5e7eb;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress-fill {
            width: 70%;
            height: 100%;
            background: linear-gradient(90deg, #ffb3cf, #7cc7f7);
            border-radius: inherit;
        }

        form {
            text-align: left;
        }

        .section-card {
            background: rgba(255,255,255,0.72);
            border: 1px solid #eef2f7;
            border-radius: 18px;
            padding: 20px 18px 16px;
            margin-bottom: 18px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0 0 16px;
            font-size: 16px;
            font-weight: 700;
            color: #243041;
        }

        .section-title i {
            color: var(--primary);
            font-size: 18px;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .field {
            margin-bottom: 16px;
        }

        .field label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            font-size: 14px;
            color: #374151;
        }

        .field input,
        .field textarea {
            width: 100%;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid var(--border);
            background: var(--input-bg);
            font-size: 14px;
            color: #111827;
            outline: none;
            transition: border-color .2s ease, box-shadow .2s ease;
            font-family: inherit;
        }

        .field input::placeholder,
        .field textarea::placeholder {
            color: #9ca3af;
        }

        .field input:focus,
        .field textarea:focus {
            border-color: #d16aa7;
            box-shadow: 0 0 0 4px rgba(209,106,167,0.14);
        }

        .field small {
            display: block;
            margin-top: 6px;
            font-size: 12px;
            color: #6b7280;
            line-height: 1.4;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .note-box {
            margin-top: 8px;
            background: linear-gradient(135deg, var(--soft-pink), var(--soft-blue));
            border: 1px solid #e9edf5;
            border-radius: 14px;
            padding: 14px 16px;
            font-size: 13px;
            color: #475569;
            line-height: 1.6;
        }

        .actions {
            margin-top: 22px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-primary {
            width: 100%;
            border: none;
            border-radius: 14px;
            padding: 14px 16px;
            background: linear-gradient(135deg, #ffb3cf, #ff7aa6);
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 0.2px;
            cursor: pointer;
            box-shadow: 0 10px 24px rgba(255,122,150,0.22);
            transition: transform .18s ease, box-shadow .18s ease, filter .18s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 28px rgba(255,122,150,0.28);
            filter: brightness(1.02);
        }

        .privacy-note {
            text-align: center;
            font-size: 12px;
            color: #64748b;
            line-height: 1.6;
        }

        .privacy-note i {
            color: var(--primary);
            margin-right: 4px;
        }

        .field input:focus-visible,
        .field textarea:focus-visible,
        .btn-primary:focus-visible {
            outline: 3px solid rgba(124, 199, 247, 0.45);
            outline-offset: 2px;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(18px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .auth-card {
                padding: 24px 18px 22px;
                border-radius: 18px;
            }

            .row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .title {
                font-size: 22px;
            }

            .subtitle {
                font-size: 13px;
            }

            .section-card {
                padding: 18px 14px 14px;
            }
        }
    </style>
</head>

<body class="auth-bg">

<main class="auth-card" role="main" aria-labelledby="onboardingTitle">
    <div class="top-section">
        <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi logo" />
        <h1 id="onboardingTitle" class="title">Complete Your Profile 🌸</h1>
        <p class="subtitle">Help us personalise your pregnancy journey with details that support better guidance, tracking, and care.</p>
    </div>

    <div class="progress-wrap" aria-label="Profile setup progress">
        <div class="progress-head">
            <span>Profile setup</span>
            <span>Step 2 of 3</span>
        </div>
        <div class="progress-bar" aria-hidden="true">
            <div class="progress-fill"></div>
        </div>
    </div>

    <form action="<%= request.getContextPath() %>/onboarding" method="post">
        <section class="section-card">
            <h2 class="section-title">
                <i class="ri-user-heart-line" aria-hidden="true"></i>
                Personal Information
            </h2>

            <div class="row">
                <div class="field">
                    <label for="full_name">Full Name</label>
                    <input id="full_name" type="text" name="full_name" placeholder="Your full name" required autocomplete="name">
                </div>

                <div class="field">
                    <label for="age">Age</label>
                    <input id="age" type="number" name="age" placeholder="Your age" required min="12" max="60" inputmode="numeric">
                </div>
            </div>

            <div class="row">
                <div class="field">
                    <label for="username">Username</label>
                    <input id="username" type="text" name="username" placeholder="Choose a username" required autocomplete="username">
                    <small>This will help identify your profile inside the app.</small>
                </div>

                <div class="field">
                    <label for="phone">Phone Number</label>
                    <input id="phone" type="tel" name="phone" placeholder="Mobile number" required autocomplete="tel">
                </div>
            </div>
        </section>

        <section class="section-card">
            <h2 class="section-title">
                <i class="ri-heart-pulse-line" aria-hidden="true"></i>
                Pregnancy Details
            </h2>

            <div class="row">
                <div class="field">
                    <label for="due_date">Due Date</label>
                    <input id="due_date" type="date" name="due_date" required>
                    <small>This helps us personalise week-by-week support and reminders.</small>
                </div>

                <div class="field">
                    <label for="doctor_name">Doctor Name</label>
                    <input id="doctor_name" type="text" name="doctor_name" placeholder="Doctor's name" autocomplete="name">
                </div>
            </div>

            <div class="field">
                <label for="hospital_name">Hospital / Clinic</label>
                <input id="hospital_name" type="text" name="hospital_name" placeholder="Hospital or clinic name">
            </div>

            <div class="field">
                <label for="complications">Complications (if any)</label>
                <textarea id="complications" name="complications" placeholder="Leave blank if none"></textarea>
                <small>Only include what you are comfortable sharing.</small>
            </div>

            <div class="note-box">
                <i class="ri-information-line" aria-hidden="true"></i>
                Your information helps us provide a more personalised experience. You can update these details later from your profile settings.
            </div>
        </section>

        <div class="actions">
            <button class="btn-primary" type="submit">
                <i class="ri-check-line" aria-hidden="true"></i>
                Finish Setup
            </button>

            <div class="privacy-note">
                <i class="ri-shield-check-line" aria-hidden="true"></i>
                Your details are used to personalise your experience and support your care journey.
            </div>
        </div>
    </form>
</main>

</body>
</html>
