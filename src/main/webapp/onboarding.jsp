<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        /*
         * NOTE: The site header (top-header) is fixed on other pages and
         * sits at the top. Rather than hiding it, we move this onboarding
         * card below the header so the logo is always visible.
         *
         * If you prefer to hide the header on onboarding replace the
         * .page-padding rule with `.top-header { display:none !important; }`
         * but this approach preserves the header and just moves the card down.
         */

        /* Estimate of the header's height (adjust if header height changes) */
        :root { --top-header-h: 90px; }

        body.auth-bg {
            min-height: 100vh;
            margin: 0;
            /* don't vertically center so we can position below header */
            display: flex;
            align-items: flex-start;
            justify-content: center;
            background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
            font-family: system-ui, -apple-system, "Segoe UI", Roboto;
            /* Make room for the fixed header at the top */
            padding-top: calc(var(--top-header-h) + 18px);
            box-sizing: border-box;
        }

        /* Center card horizontally and limit width */
        .auth-card {
            width: 100%;
            max-width: 820px;           /* slightly wider for nicer spacing */
            background: #fff;
            border-radius: 14px;
            padding: 38px 36px;
            box-shadow: 0 10px 30px rgba(12, 20, 30, 0.08);
            margin-bottom: 40px;
            box-sizing: border-box;
        }

        /* top area inside the card */
        .auth-top {
            text-align: center;
            margin-bottom: 12px;
        }

        /* visible logo inside the card */
        .auth-logo {
            width: 110px;
            height: 110px;
            object-fit: contain;
            display: inline-block;
            margin-bottom: 12px;
            border-radius: 16px;
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.35), rgba(255,255,255,0.1));
            padding: 10px;
        }

        .auth-title {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            color: #243041;
            line-height: 1;
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

        input,
        select,
        textarea {
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #e6e6ee;
            font-size: 15px;
            outline: none;
            background: #fff;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            height: 90px;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #d16aa7;
            box-shadow: 0 4px 18px rgba(209, 106, 167, 0.10);
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
            box-shadow: 0 6px 18px rgba(255, 122, 150, 0.14);
        }

        /* smaller devices: single column + smaller card */
        @media (max-width: 900px) {
            body.auth-bg {
                padding-top: calc(var(--top-header-h) + 10px);
            }
            .auth-card {
                max-width: 92%;
                padding: 20px;
            }
            form .row {
                grid-template-columns: 1fr;
            }
            .auth-logo { width: 88px; height: 88px; }
            .auth-title { font-size: 22px; }
        }
        /* 📱 Mobile Optimization */
@media (max-width: 600px) {

    .auth-card {
        width: 95%;
        padding: 18px 16px;
        border-radius: 12px;
        margin-top: 10px;
    }

    .auth-top {
        margin-bottom: 12px;
    }

    .auth-logo {
        width: 70px;
        height: 70px;
        margin-bottom: 10px;
    }

    .auth-title {
        font-size: 20px;
    }

    .auth-sub {
        font-size: 14px;
        margin-bottom: 12px;
    }

    form .row {
        grid-template-columns: 1fr !important; /* Stack fields */
        gap: 10px;
    }

    input, select, textarea {
        font-size: 14px;
        padding: 9px 10px;
    }

    .btn-primary {
        font-size: 15px;
        padding: 12px;
        border-radius: 8px;
        margin-top: 18px;
    }

    h3 {
        font-size: 17px;
        margin-top: 18px;
    }
}

    </style>
</head>

<body class="auth-bg">

    <div class="auth-card">

        <!-- LOGO + HEADING -->
        <div class="auth-top">
            <!-- correct context-aware path for the logo -->
            <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png"
                 class="auth-logo"
                 alt="Garbh Sakhi Logo">

            <div class="auth-title">Complete Your Profile</div>

            <div class="auth-sub">Help us personalize your wellness journey.</div>
        </div>

        <form action="<%= request.getContextPath() %>/onboarding" method="post">

            <!-- Row 1 -->
            <div class="row">
                <div class="field">
                    <label for="full_name">Full Name</label>
                    <input id="full_name" type="text" name="full_name" required placeholder="Your full name">
                </div>

                <div class="field">
                    <label for="phone">Phone Number</label>
                    <input id="phone" type="text" name="phone" required placeholder="1234567890">
                </div>
            </div>

            <!-- Row 2 -->
            <div class="row">
                <div class="field">
                    <label for="age">Age</label>
                    <input id="age" type="number" name="age" required min="13" max="60" placeholder="Your age">
                </div>

                <div class="field">
                    <label for="due_date">Due Date</label>
                    <input id="due_date" type="date" name="due_date" required>
                </div>
            </div>

            <!-- Row 3 -->
            <div class="row">
                <div class="field">
                    <label for="doctor_name">Doctor Name</label>
                    <input id="doctor_name" type="text" name="doctor_name" placeholder="Dr. Rahul Sharma">
                </div>

                <div class="field">
                    <label for="hospital_name">Hospital Name</label>
                    <input id="hospital_name" type="text" name="hospital_name" placeholder="Hospital / Clinic Name">
                </div>
            </div>

            <!-- Complications -->
            <div class="field" style="margin-top:12px;">
                <label for="complications">Complications (optional)</label>
                <textarea id="complications" name="complications" placeholder="Mention any complications..."></textarea>
            </div>

            <!-- Emergency Contacts -->
            <h3 style="margin-top: 18px; color:#243041;">Emergency Contacts (min 3)</h3>

            <div class="row">
                <div class="field">
                    <label>Contact 1 Name</label>
                    <input type="text" name="ec1_name" required>
                </div>
                <div class="field">
                    <label>Contact 1 Phone</label>
                    <input type="text" name="ec1_phone" required>
                </div>
            </div>

            <div class="row">
                <div class="field">
                    <label>Contact 2 Name</label>
                    <input type="text" name="ec2_name" required>
                </div>
                <div class="field">
                    <label>Contact 2 Phone</label>
                    <input type="text" name="ec2_phone" required>
                </div>
            </div>

            <div class="row">
                <div class="field">
                    <label>Contact 3 Name</label>
                    <input type="text" name="ec3_name" required>
                </div>
                <div class="field">
                    <label>Contact 3 Phone</label>
                    <input type="text" name="ec3_phone" required>
                </div>
            </div>

            <button type="submit" class="btn-primary">Finish Setup</button>

        </form>

    </div>

</body>

</html>
