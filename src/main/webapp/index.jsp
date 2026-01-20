<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Garbh Sakhi</title>

  <!-- App styles -->
  <link rel="stylesheet" href="assets/css/style.css">
  <link rel="stylesheet" href="assets/css/modern-style.css">

  <style>
    /* Auth pages: Use same gradient as dashboard */
    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #f6a7d4 0%, #a9d6f7 100%);
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    }
    .auth-card {
      width: 100%;
      max-width: 480px;
      background: #ffffff;
      border-radius: 14px;
      box-shadow: 0 10px 30px rgba(12,20,30,0.08);
      padding: 28px;
      box-sizing: border-box;
      margin: 24px;
    }
    .auth-top {
      text-align: center;
      margin-bottom: 8px;
    }
    .auth-logo {
      width: 88px;
      height: auto;
      border-radius: 14px;
      display: inline-block;
      box-shadow: 0 6px 18px rgba(12,20,30,0.06);
    }
    .auth-title {
      font-size: 24px;
      margin: 12px 0 6px;
      color: #243041;
      font-weight: 700;
    }
    .auth-sub {
      color: #4b5563;
      margin-bottom: 18px;
    }

    .cta {
      display:flex;
      gap:12px;
      align-items:center;
      justify-content:center;
      margin-top: 12px;
    }
    .btn-primary {
      background: linear-gradient(180deg,#ffb3cf,#ff7aa6);
      color:#fff;
      border:none;
      padding:10px 18px;
      border-radius:10px;
      font-weight:600;
      cursor:pointer;
      box-shadow: 0 6px 18px rgba(255,122,150,0.18);
    }
    .link-muted { color:#2b6cb0; text-decoration:underline; }

    @media (max-width:420px){
      .auth-card { padding:18px; margin:12px; border-radius:12px; }
      .auth-title { font-size:20px; }
    }
  </style>
</head>
<body class="auth-bg">

  <div class="auth-card" role="main" aria-labelledby="landingTitle">
    <div class="auth-top">
      <img src="assets/garbh_sakhi_logo.png" alt="Garbh Sakhi" class="auth-logo" />
      <div id="landingTitle" class="auth-title">Welcome to Garbh Sakhi</div>
      <div class="auth-sub">Your AI-enabled pregnancy wellness companion.</div>
    </div>

    <div style="text-align:center;">
      <button class="btn-primary" onclick="location.href='signup.jsp'">Create Account</button>
    </div>

    <div class="cta" style="margin-top:18px;">
      <div style="margin:0 auto; text-align:center; width:100%;">
        <p style="margin:10px 0 0; color:#334155;">
          Already have an account?
          <a class="link-muted" href="login.jsp">Login</a>
        </p>
      </div>
    </div>
  </div>

</body>
</html>
