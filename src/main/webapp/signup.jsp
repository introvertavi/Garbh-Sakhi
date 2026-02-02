<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Create Account – Garbh Sakhi</title>
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
      max-width:520px;
      background:#fff;
      border-radius:14px;
      padding:28px;
      box-shadow:0 10px 30px rgba(12,20,30,0.08);
      box-sizing:border-box;
      margin:20px auto;
    }
    .auth-top { text-align:center; margin-bottom:6px; }
    .auth-logo { width:80px; border-radius:12px; display:inline-block; }
    .auth-title { font-size:20px; font-weight:700; color:#243041; margin-top:12px; }
    .auth-sub { color:#4b5563; margin-bottom:16px; }

    form .row { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
    .field { display:flex; flex-direction:column; gap:6px; margin-bottom:12px; }
    input {
      padding:10px 12px; border-radius:8px; border:1px solid #e6e6e9;
      font-size:15px; outline:none; box-sizing:border-box;
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
      margin-top:6px;
      box-shadow: 0 6px 18px rgba(255,122,150,0.14);
    }

    .small-link { text-align:center; margin-top:10px; color:#475569; }
    .small-link a { color:#2b6cb0; text-decoration:underline; }

    @media (max-width:700px) {
      form .row { grid-template-columns:1fr; }
      .auth-card { padding:18px; margin:12px auto; }
    }
  </style>
</head>

<body class="auth-bg">

<div class="auth-card" role="main" aria-labelledby="signupTitle">
  <div class="auth-top">
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi" />
    <div id="signupTitle" class="auth-title">Create Your Account</div>
    <div class="auth-sub">Join Garbh Sakhi – Your AI pregnancy wellness companion.</div>
  </div>

  <form action="${pageContext.request.contextPath}/auth/signup" method="post" novalidate>

    <div class="row">
      <div class="field">
        <label for="name">Full name</label>
        <input id="name" name="name" type="text" required placeholder="Your full name" />
      </div>

      <div class="field">
        <label for="email">Email address</label>
        <input id="email" name="email" type="email" required placeholder="you@example.com" />
      </div>
    </div>

    <!-- PASSWORD FIELD -->
    <div class="form-group password-field">
      <label>New Password</label>

      <div class="password-input-wrapper">
        <input type="password"
               name="newPassword"
               placeholder="Create a new password"
               oninput="checkStrength(this,'signupStrength')"
>
        <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
      </div>
    </div>

    <!-- STRENGTH METER -->
    <div id="signupStrength" class="strength-meter">
      <div class="strength-bar">
        <div class="strength-fill"></div>
      </div>
      <div class="strength-text"></div>
    </div>

    <button type="submit" class="btn-primary">Sign Up</button>
  </form>

  <% String error = request.getParameter("error"); %>
  <% if ("empty".equals(error)) { %>
    <p style="color:red; text-align:center;">Please fill all fields.</p>
  <% } else if ("db".equals(error)) { %>
    <p style="color:red; text-align:center;">Email already exists or database error.</p>
  <% } %>

  <div class="small-link">
    <p>Already have an account? <a href="login.jsp">Login</a></p>
  </div>
</div>

<script src="assets/js/password-utils.js"></script>

</body>
</html>
