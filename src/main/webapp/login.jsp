<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login – Garbh Sakhi</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">

  <!-- App styles -->
  <link rel="stylesheet" href="assets/css/style.css">
  <link rel="stylesheet" href="assets/css/modern-style.css">

  <style>
    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      display:flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    }
    .auth-card {
      width:100%;
      max-width:440px;
      background:#fff;
      border-radius:14px;
      padding:28px;
      box-shadow:0 10px 30px rgba(12,20,30,0.08);
      box-sizing:border-box;
      margin:20px auto; /* ✅ CENTER FIX (ONLY CHANGE) */
    }
    .auth-top { text-align:center; margin-bottom:6px; }
    .auth-logo { width:72px; border-radius:12px; display:inline-block; }
    .auth-title { font-size:20px; font-weight:700; color:#243041; margin-top:12px; }
    .auth-sub { color:#4b5563; margin-bottom:16px; }

    form .field { display:flex; flex-direction:column; gap:6px; margin-bottom:14px; }
    input[type="email"], input[type="password"] {
      padding:10px 12px; border-radius:8px; border:1px solid #e6e6e9;
      font-size:15px; outline:none;
      transition:border .15s, box-shadow .15s;
      box-sizing:border-box;
    }
    input:focus { border-color:#d16aa7; box-shadow:0 4px 18px rgba(209,106,167,0.12); }

    .btn-primary {
      width:100%;
      background: linear-gradient(180deg,#ffb3cf,#ff7aa6);
      color:#fff;
      border:none;
      padding:10px 14px;
      border-radius:10px;
      font-weight:600;
      cursor:pointer;
      margin-top:4px;
      box-shadow: 0 6px 18px rgba(255,122,150,0.14);
    }

    /* ALERTS */
    .alert {
      padding:10px 12px;
      border-radius:10px;
      font-size:14px;
      margin-bottom:14px;
      text-align:center;
    }
    .alert-error {
      background:#fff1f2;
      color:#b91c1c;
      border:1px solid #fecaca;
    }
    .alert-success {
      background:#ecfdf5;
      color:#047857;
      border:1px solid #a7f3d0;
    }

    .small-link { text-align:center; margin-top:10px; color:#475569; }
    .small-link a { color:#2b6cb0; text-decoration:underline; }

    @media (max-width:420px){
      .auth-card { padding:18px; margin:12px auto; }
      .auth-title { font-size:18px; }
    }
  </style>
</head>
<body class="auth-bg">

  <div class="auth-card" role="main" aria-labelledby="loginTitle">
    <div class="auth-top">
      <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi" />
      <div id="loginTitle" class="auth-title">Welcome Back!</div>
      <div class="auth-sub">Login to continue your pregnancy wellness journey.</div>
    </div>

    <% if ("changed".equals(request.getParameter("password"))) { %>
      <div class="alert alert-success">
        Password updated successfully. Please log in again.
      </div>
    <% } %>

    <% if ("invalid".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">
        Wrong email or password. Please try again.
      </div>
    <% } else if ("empty".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">
        Please enter both email and password.
      </div>
    <% } else if ("db".equals(request.getParameter("error"))) { %>
      <div class="alert alert-error">
        Something went wrong. Please try again in a moment.
      </div>
    <% } %>

    <form action="auth/login" method="post" novalidate>

  <div class="field">
    <label for="email">Email address</label>
    <input id="email"
           name="email"
           type="email"
           required
           placeholder="you@example.com" />
  </div>

  <div class="field password-field">
    <label for="password">Password</label>

    <div class="password-input-wrapper">
      <input id="password"
             name="password"
             type="password"
             required
             placeholder="Enter your password" />
      <i class="ri-eye-line toggle-eye"
         onclick="togglePassword(this)"></i>
    </div>
  </div>

  <button type="submit" class="btn-primary">Login</button>
</form>


    <div class="small-link">
      <p>Don’t have an account? <a href="signup.jsp">Create One</a></p>
    </div>
  </div>

  <!-- ✅ REQUIRED FOR SHOW / HIDE -->
  <script src="assets/js/password-utils.js"></script>

</body>
</html>

