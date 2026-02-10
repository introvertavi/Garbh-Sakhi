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
    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      display:flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, Arial;
    }
    .auth-card {
      width:100%;
      max-width:520px;
      background:#fff;
      border-radius:14px;
      padding:28px;
      box-shadow:0 10px 30px rgba(12,20,30,0.08);
      margin:20px auto;
    }
    .auth-top { text-align:center; margin-bottom:6px; }
    .auth-logo { width:80px; border-radius:12px; }
    .auth-title { font-size:20px; font-weight:700; margin-top:12px; }
    .auth-sub { color:#4b5563; margin-bottom:16px; }

    form .row { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
    .field { display:flex; flex-direction:column; gap:6px; margin-bottom:12px; }

    input {
      padding:10px 12px;
      border-radius:8px;
      border:1px solid #e6e6e9;
      font-size:15px;
    }

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
    }

    .small-link { text-align:center; margin-top:10px; }
  </style>
</head>

<body class="auth-bg">

<div class="auth-card">
  <div class="auth-top">
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi" />
    <div class="auth-title">Create Your Account</div>
    <div class="auth-sub">Join Garbh Sakhi – Your AI pregnancy wellness companion.</div>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/auth/signup">

    <div class="row">
      <div class="field">
        <label>Full name</label>
        <input type="text" name="name" placeholder="Your full name" />
      </div>

      <div class="field">
        <label>Email address</label>
        <input type="email" name="email" required placeholder="you@example.com" />
      </div>
    </div>

    <!-- PASSWORD -->
    <div class="field password-field">
      <label>Password</label>
      <div class="password-input-wrapper">
        <input type="password"
               name="password"
               required
               placeholder="Create a password"
               oninput="checkStrength(this,'signupStrength')" />
        <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
      </div>
    </div>

    <!-- STRENGTH METER -->
    <div id="signupStrength" class="strength-meter">
      <div class="strength-bar"><div class="strength-fill"></div></div>
      <div class="strength-text"></div>
    </div>

    <button type="submit" class="btn-primary">Sign Up</button>
  </form>

  <% if ("empty".equals(request.getParameter("error"))) { %>
    <p style="color:red; text-align:center;">Please fill all fields.</p>
  <% } else if ("exists".equals(request.getParameter("error"))) { %>
    <p style="color:red; text-align:center;">Email already exists.</p>
  <% } else if ("db".equals(request.getParameter("error"))) { %>
    <p style="color:red; text-align:center;">Database error.</p>
  <% } %>

  <div class="small-link">
    <p>Already have an account? <a href="login.jsp">Login</a></p>
  </div>
</div>

<script src="assets/js/password-utils.js"></script>
</body>
</html>
