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
    /* ── Auth page base ── */
    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
      font-family: 'Poppins', system-ui, sans-serif;
      padding: 20px;
      box-sizing: border-box;
    }

    /* ── Card ── */
    .auth-card {
      width: 100%;
      max-width: 440px;
      background: #fff;
      border-radius: 20px;
      padding: 36px 32px 28px;
      box-shadow: 0 16px 40px rgba(12,20,30,0.10);
      box-sizing: border-box;
      text-align: center;
    }

    /* ── Logo + heading ── */
    .auth-logo {
      width: 80px;
      border-radius: 16px;
      display: inline-block;
      box-shadow: 0 6px 18px rgba(12,20,30,0.08);
    }
    .auth-title {
      font-size: 22px;
      font-weight: 700;
      color: #243041;
      margin: 14px 0 6px;
    }
    .auth-sub {
      color: #4b5563;
      font-size: 14px;
      margin-bottom: 22px;
    }

    /* ── Form fields ── */
    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
      margin-bottom: 14px;
      text-align: left;
    }
    .field label {
      font-weight: 600;
      font-size: 14px;
      color: #374151;
    }
    .field input {
      padding: 11px 13px;
      border-radius: 10px;
      border: 1px solid #e2e8f0;
      font-size: 15px;
      outline: none;
      transition: border .15s, box-shadow .15s;
      width: 100%;
      box-sizing: border-box;
    }
    .field input:focus {
      border-color: #d16aa7;
      box-shadow: 0 0 0 3px rgba(209,106,167,0.12);
    }

    /* ── Password wrapper ── */
    .password-input-wrapper {
      position: relative;
    }
    .password-input-wrapper input {
      padding-right: 44px;
    }
    .toggle-eye {
      position: absolute;
      right: 13px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 18px;
      color: #9ca3af;
      cursor: pointer;
      line-height: 1;
    }
    .toggle-eye:hover { color: #ff4f93; }

    /* ── Primary button ── */
    .btn-primary {
  width: 100%;
  background: linear-gradient(135deg, #ffb3cf, #ff7aa6);
  color: #fff; border: none;
  padding: 12px; border-radius: 12px;
  font-size: 15px; font-weight: 600; cursor: pointer;
  margin-top: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  box-shadow: 0 6px 18px rgba(255,122,150,0.18);
  transition: transform .15s, box-shadow .15s;
}
    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 24px rgba(255,122,150,0.28);
    }

    /* ── Alerts ── */
    .alert {
      padding: 10px 14px;
      border-radius: 10px;
      font-size: 14px;
      margin-bottom: 16px;
      text-align: center;
    }
    .alert-error  { background:#fff1f2; color:#b91c1c; border:1px solid #fecaca; }
    .alert-success{ background:#ecfdf5; color:#047857; border:1px solid #a7f3d0; }

    /* ── Footer link ── */
    .small-link { margin-top: 14px; font-size: 14px; color: #475569; }
    .small-link a { color: #2b6cb0; text-decoration: underline; }

    @media (max-width: 420px) {
      .auth-card { padding: 24px 18px; }
      .auth-title { font-size: 19px; }
    }
  </style>
</head>

<body class="auth-bg">
  <div class="auth-card" role="main" aria-labelledby="loginTitle">

    <!-- Logo + heading (already text-align:center from card) -->
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi" />
    <div id="loginTitle" class="auth-title">Welcome Back! 👋</div>
    <div class="auth-sub">Login to continue your pregnancy wellness journey.</div>

    <!-- Alerts -->
    <% if ("changed".equals(request.getParameter("password"))) { %>
      <div class="alert alert-success">Password updated successfully. Please log in again.</div>
    <% } %>
    <% if ("invalid".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">Wrong email or password. Please try again.</div>
    <% } else if ("empty".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">Please enter both email and password.</div>
    <% } else if ("db".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">Something went wrong. Please try again in a moment.</div>
    <% } %>

    <!-- Form -->
    <form method="post" action="${pageContext.request.contextPath}/auth/login" style="text-align:left;">

      <div class="field">
        <label for="email">Email address</label>
        <input id="email" name="email" type="email" required placeholder="you@example.com" />
      </div>

      <div class="field">
        <label for="password">Password</label>
        <div class="password-input-wrapper">
          <input id="password" name="password" type="password" required placeholder="Enter your password" />
          <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
        </div>
      </div>

      <button type="submit" class="btn-primary">Login</button>
    </form>

    <div class="small-link">
      <p>Don't have an account? <a href="signup.jsp">Create one</a></p>
    </div>
  </div>

  <script src="assets/js/password-utils.js"></script>
</body>
</html>