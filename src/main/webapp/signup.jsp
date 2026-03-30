<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Create Account – Garbh Sakhi</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">
  <link rel="stylesheet" href="assets/css/style.css">
  <link rel="stylesheet" href="assets/css/modern-style.css">

  <style>
    :root {
      --primary: #ff6f9f;
      --primary-dark: #ea5a8d;
      --secondary: #8fd3ff;
      --text-dark: #243041;
      --text-muted: #667085;
      --border: #e5e7eb;
      --input-bg: #ffffff;
      --card-bg: rgba(255, 255, 255, 0.94);
      --danger-bg: #fff1f2;
      --danger-text: #be123c;
      --danger-border: #fecdd3;
      --shadow: 0 20px 50px rgba(17, 24, 39, 0.12);
    }

    * {
      box-sizing: border-box;
    }

    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      padding: 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: "Poppins", system-ui, -apple-system, sans-serif;
      background:
        radial-gradient(circle at top left, rgba(255,255,255,0.32), transparent 34%),
        radial-gradient(circle at bottom right, rgba(255,255,255,0.24), transparent 32%),
        linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
    }

    .auth-card {
      width: 100%;
      max-width: 540px;
      background: var(--card-bg);
      border: 1px solid rgba(255,255,255,0.45);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border-radius: 22px;
      padding: 34px 30px 28px;
      box-shadow: var(--shadow);
      text-align: center;
      animation: fadeUp 0.45s ease;
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

    .auth-title {
      margin: 16px 0 6px;
      color: var(--text-dark);
      font-size: 26px;
      font-weight: 700;
      line-height: 1.2;
    }

    .auth-sub {
      margin: 0 0 24px;
      color: var(--text-muted);
      font-size: 14px;
      line-height: 1.6;
    }

    form {
      text-align: left;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }

    .field {
      margin-bottom: 16px;
    }

    .field label {
      display: block;
      margin-bottom: 7px;
      font-size: 14px;
      font-weight: 600;
      color: #374151;
    }

    .field input {
      width: 100%;
      padding: 12px 14px;
      border-radius: 12px;
      border: 1px solid var(--border);
      background: var(--input-bg);
      font-size: 15px;
      color: #111827;
      outline: none;
      transition: border-color .2s ease, box-shadow .2s ease, transform .2s ease;
    }

    .field input::placeholder {
      color: #9ca3af;
    }

    .field input:focus {
      border-color: #d16aa7;
      box-shadow: 0 0 0 4px rgba(209,106,167,0.14);
    }

    .password-input-wrapper {
      position: relative;
    }

    .password-input-wrapper input {
      padding-right: 46px;
    }

    .toggle-eye {
      position: absolute;
      top: 50%;
      right: 14px;
      transform: translateY(-50%);
      font-size: 18px;
      color: #94a3b8;
      cursor: pointer;
      transition: color .2s ease;
    }

    .toggle-eye:hover {
      color: var(--primary);
    }

    .helper-text {
      margin-top: 6px;
      font-size: 12px;
      color: #6b7280;
      line-height: 1.4;
    }

    .strength-meter {
      margin: -2px 0 16px;
    }

    .strength-bar {
      width: 100%;
      height: 7px;
      border-radius: 999px;
      background: #e5e7eb;
      overflow: hidden;
    }

    .strength-fill {
      height: 100%;
      width: 0%;
      border-radius: inherit;
      transition: width .25s ease, background .25s ease;
    }

    .strength-text {
      margin-top: 6px;
      font-size: 12px;
      color: #6b7280;
    }

    .strength-weak {
      background: #ef4444;
    }

    .strength-medium {
      background: #f59e0b;
    }

    .strength-strong {
      background: #22c55e;
    }

    .btn-primary {
      width: 100%;
      border: none;
      border-radius: 14px;
      padding: 13px 16px;
      margin-top: 8px;
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

    .btn-primary:active {
      transform: translateY(0);
    }

    .btn-primary:focus-visible,
    .toggle-eye:focus-visible,
    .small-link a:focus-visible,
    .field input:focus-visible {
      outline: none;
    }

    .alert-inline {
      margin-top: 16px;
      padding: 12px 14px;
      border-radius: 12px;
      background: var(--danger-bg);
      color: var(--danger-text);
      border: 1px solid var(--danger-border);
      font-size: 14px;
      text-align: left;
    }

    .terms-note {
      margin-top: 14px;
      font-size: 12px;
      line-height: 1.5;
      color: #64748b;
      text-align: center;
    }

    .small-link {
      margin-top: 18px;
      font-size: 14px;
      color: #475569;
      text-align: center;
    }

    .small-link a,
    .terms-note a {
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .small-link a:hover,
    .terms-note a:hover {
      text-decoration: underline;
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

    @media (max-width: 560px) {
      .auth-card {
        padding: 26px 18px 22px;
        border-radius: 18px;
      }

      .form-row {
        grid-template-columns: 1fr;
        gap: 0;
      }

      .auth-title {
        font-size: 22px;
      }

      .auth-sub {
        font-size: 13px;
      }
    }
  </style>
</head>

<body class="auth-bg">
  <main class="auth-card" role="main" aria-labelledby="signupTitle">
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi logo" />

    <h1 id="signupTitle" class="auth-title">Create Your Account ✨</h1>
    <p class="auth-sub">Join Garbh Sakhi — your pregnancy wellness companion.</p>

    <form method="post" action="${pageContext.request.contextPath}/auth/signup" novalidate>
      <div class="form-row">
        <div class="field">
          <label for="name">Full name</label>
          <input id="name" type="text" name="name" placeholder="Your full name" required />
        </div>

        <div class="field">
          <label for="email">Email address</label>
          <input id="email" type="email" name="email" required placeholder="you@example.com" />
        </div>
      </div>

      <div class="field">
        <label for="password">Password</label>
        <div class="password-input-wrapper">
          <input
            id="password"
            type="password"
            name="password"
            required
            placeholder="Create a strong password"
            oninput="checkStrength(this,'signupStrength')"
            aria-describedby="passwordHelp"
          />
          <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)" aria-hidden="true"></i>
        </div>
        <div id="passwordHelp" class="helper-text">
          Use at least 8 characters with a mix of letters, numbers, and symbols.
        </div>
      </div>

      <div id="signupStrength" class="strength-meter" aria-live="polite">
        <div class="strength-bar">
          <div class="strength-fill"></div>
        </div>
        <div class="strength-text"></div>
      </div>

      <button type="submit" class="btn-primary">
        <i class="ri-user-add-line" aria-hidden="true"></i>
        Sign Up
      </button>
    </form>

    <% if ("empty".equals(request.getParameter("error"))) { %>
      <div class="alert-inline" role="alert">
        Please fill in all required fields.
      </div>
    <% } else if ("exists".equals(request.getParameter("error"))) { %>
      <div class="alert-inline" role="alert">
        An account with this email already exists.
      </div>
    <% } else if ("db".equals(request.getParameter("error"))) { %>
      <div class="alert-inline" role="alert">
        Something went wrong while creating your account. Please try again.
      </div>
    <% } %>

    <div class="small-link">
      Already have an account?
      <a href="login.jsp">Login</a>
    </div>
  </main>

  <script src="assets/js/password-utils.js"></script>
</body>
</html>