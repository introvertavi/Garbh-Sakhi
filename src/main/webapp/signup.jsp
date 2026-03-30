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
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
      font-family: 'Poppins', system-ui, sans-serif;
      padding: 20px;
      box-sizing: border-box;
    }

    .auth-card {
      width: 100%;
      max-width: 520px;
      background: #fff;
      border-radius: 20px;
      padding: 36px 32px 28px;
      box-shadow: 0 16px 40px rgba(12,20,30,0.10);
      box-sizing: border-box;
      text-align: center;
    }

    .auth-logo  { width: 80px; border-radius: 16px; display: inline-block; }
    .auth-title { font-size: 22px; font-weight: 700; color: #243041; margin: 14px 0 4px; }
    .auth-sub   { color: #4b5563; font-size: 14px; margin-bottom: 22px; }

    /* form rows */
    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }
    @media (max-width: 460px) { .form-row { grid-template-columns: 1fr; } }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
      margin-bottom: 14px;
      text-align: left;
    }
    .field label { font-weight: 600; font-size: 14px; color: #374151; }
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

    .password-input-wrapper { position: relative; }
    .password-input-wrapper input { padding-right: 44px; }
    .toggle-eye {
      position: absolute; right: 13px; top: 50%; transform: translateY(-50%);
      font-size: 18px; color: #9ca3af; cursor: pointer;
    }
    .toggle-eye:hover { color: #ff4f93; }

    /* strength meter */
    .strength-meter { margin-top: 6px; }
    .strength-bar { height: 6px; border-radius: 999px; background: #e5e7eb; overflow: hidden; }
    .strength-fill { height: 100%; width: 0%; transition: width .3s, background .3s; }
    .strength-text { font-size: 12px; margin-top: 4px; color: #6b7280; }
    .strength-weak   { background: #ef4444; }
    .strength-medium { background: #f59e0b; }
    .strength-strong { background: #22c55e; }

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
    .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 10px 24px rgba(255,122,150,0.28); }

    .alert-inline { color: #c0392b; text-align: center; font-size: 14px; margin-top: 10px; }
    .small-link   { margin-top: 14px; font-size: 14px; color: #475569; }
    .small-link a { color: #2b6cb0; text-decoration: underline; }

    @media (max-width: 420px) {
      .auth-card { padding: 24px 18px; }
      .auth-title { font-size: 19px; }
    }
  </style>
</head>

<body class="auth-bg">
  <div class="auth-card">
    <img src="assets/garbh_sakhi_logo.png" class="auth-logo" alt="Garbh Sakhi" />
    <div class="auth-title">Create Your Account ✨</div>
    <div class="auth-sub">Join Garbh Sakhi – Your Pregnancy wellness companion.</div>

    <form method="post" action="${pageContext.request.contextPath}/auth/signup" style="text-align:left;">

      <div class="form-row">
        <div class="field">
          <label>Full name</label>
          <input type="text" name="name" placeholder="Your full name" />
        </div>
        <div class="field">
          <label>Email address</label>
          <input type="email" name="email" required placeholder="you@example.com" />
        </div>
      </div>

      <div class="field">
        <label>Password</label>
        <div class="password-input-wrapper">
          <input type="password" name="password" required placeholder="Create a password"
                 oninput="checkStrength(this,'signupStrength')" />
          <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
        </div>
      </div>

      <div id="signupStrength" class="strength-meter">
        <div class="strength-bar"><div class="strength-fill"></div></div>
        <div class="strength-text"></div>
      </div>

      <button type="submit" class="btn-primary">Sign Up</button>
    </form>

    <% if ("empty".equals(request.getParameter("error"))) { %>
      <p class="alert-inline">Please fill all fields.</p>
    <% } else if ("exists".equals(request.getParameter("error"))) { %>
      <p class="alert-inline">Email already exists.</p>
    <% } else if ("db".equals(request.getParameter("error"))) { %>
      <p class="alert-inline">Database error. Please try again.</p>
    <% } %>

    <div class="small-link">
      <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
  </div>

  <script src="assets/js/password-utils.js"></script>
</body>
</html>