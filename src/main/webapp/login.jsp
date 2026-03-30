<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login – Garbh Sakhi</title>

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
      --success-bg: #ecfdf5;
      --success-text: #047857;
      --success-border: #a7f3d0;
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
      max-width: 460px;
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
      transition: border-color .2s ease, box-shadow .2s ease;
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
      padding-right: 48px;
    }

    .toggle-eye-btn {
      position: absolute;
      top: 50%;
      right: 12px;
      transform: translateY(-50%);
      border: none;
      background: transparent;
      padding: 4px;
      cursor: pointer;
      color: #94a3b8;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
    }

    .toggle-eye-btn:hover {
      color: var(--primary);
    }

    .toggle-eye-btn:focus-visible,
    .btn-primary:focus-visible,
    .small-link a:focus-visible,
    .helper-link:focus-visible,
    .field input:focus-visible {
      outline: 3px solid rgba(124, 199, 247, 0.45);
      outline-offset: 2px;
      border-radius: 10px;
    }

    .form-options {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 12px;
      margin: 4px 0 18px;
      flex-wrap: wrap;
    }

    .remember-me {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: #475569;
    }

    .remember-me input[type="checkbox"] {
      width: 16px;
      height: 16px;
      accent-color: var(--primary);
    }

    .helper-link {
      font-size: 13px;
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .helper-link:hover {
      text-decoration: underline;
    }

    .btn-primary {
      width: 100%;
      border: none;
      border-radius: 14px;
      padding: 13px 16px;
      margin-top: 2px;
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

    .alert {
      margin-bottom: 16px;
      padding: 12px 14px;
      border-radius: 12px;
      font-size: 14px;
      text-align: left;
      line-height: 1.5;
    }

    .alert-error {
      background: var(--danger-bg);
      color: var(--danger-text);
      border: 1px solid var(--danger-border);
    }

    .alert-success {
      background: var(--success-bg);
      color: var(--success-text);
      border: 1px solid var(--success-border);
    }

    .small-link {
      margin-top: 18px;
      font-size: 14px;
      color: #475569;
      text-align: center;
    }

    .small-link a {
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .small-link a:hover {
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

      .auth-title {
        font-size: 22px;
      }

      .auth-sub {
        font-size: 13px;
      }

      .form-options {
        align-items: flex-start;
        flex-direction: column;
      }
    }
  </style>
</head>

<body class="auth-bg">
  <main class="auth-card" role="main" aria-labelledby="loginTitle">
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi logo" />

    <h1 id="loginTitle" class="auth-title">Welcome Back! 👋</h1>
    <p class="auth-sub">Login to continue your pregnancy wellness journey.</p>

    <% if ("changed".equals(request.getParameter("password"))) { %>
      <div class="alert alert-success" role="alert">
        Password updated successfully. Please log in again.
      </div>
    <% } %>

    <% if ("invalid".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error" role="alert">
        Wrong email or password. Please try again.
      </div>
    <% } else if ("empty".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error" role="alert">
        Please enter both email and password.
      </div>
    <% } else if ("db".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error" role="alert">
        Something went wrong. Please try again in a moment.
      </div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/auth/login" novalidate>
      <div class="field">
        <label for="email">Email address</label>
        <input
          id="email"
          name="email"
          type="email"
          required
          autocomplete="email"
          placeholder="you@example.com"
          value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
        />
      </div>

      <div class="field">
        <label for="password">Password</label>
        <div class="password-input-wrapper">
          <input
            id="password"
            name="password"
            type="password"
            required
            autocomplete="current-password"
            placeholder="Enter your password"
          />
          <button
            type="button"
            class="toggle-eye-btn"
            onclick="togglePassword(this)"
            aria-label="Show or hide password"
          >
            <i class="ri-eye-line" aria-hidden="true"></i>
          </button>
        </div>
      </div>

      <div class="form-options">
        <label class="remember-me" for="rememberMe">
          <input id="rememberMe" type="checkbox" name="rememberMe" />
          Remember me
        </label>
      </div>

      <button type="submit" class="btn-primary">
        <i class="ri-login-box-line" aria-hidden="true"></i>
        Login
      </button>
    </form>

    <div class="small-link">
      Don't have an account?
      <a href="signup.jsp">Create one</a>
    </div>
  </main>

  <script src="assets/js/password-utils.js"></script>
</body>
</html>