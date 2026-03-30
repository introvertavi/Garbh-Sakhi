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
    :root {
      --primary: #ff6f9f;
      --primary-dark: #e85b8f;
      --secondary: #7cc7f7;
      --text-dark: #243041;
      --text-muted: #5b6472;
      --card-bg: rgba(255, 255, 255, 0.92);
      --border-soft: rgba(255, 255, 255, 0.45);
      --shadow: 0 20px 45px rgba(28, 40, 58, 0.12);
    }

    * {
      box-sizing: border-box;
    }

    body.auth-bg {
      min-height: 100vh;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background:
        radial-gradient(circle at top left, rgba(255,255,255,0.35), transparent 35%),
        radial-gradient(circle at bottom right, rgba(255,255,255,0.25), transparent 30%),
        linear-gradient(135deg, #f8b4d9 0%, #a9d6f7 100%);
    }

    .auth-card {
      width: 100%;
      max-width: 460px;
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1px solid var(--border-soft);
      border-radius: 20px;
      box-shadow: var(--shadow);
      padding: 34px 28px;
      text-align: center;
      animation: fadeInUp 0.6s ease;
    }

    .auth-top {
      margin-bottom: 10px;
    }

    .auth-logo {
      width: 92px;
      height: 92px;
      object-fit: cover;
      border-radius: 20px;
      display: inline-block;
      box-shadow: 0 8px 22px rgba(12, 20, 30, 0.08);
      background: #fff;
      padding: 6px;
    }

    .auth-title {
      font-size: 28px;
      line-height: 1.2;
      margin: 16px 0 10px;
      color: var(--text-dark);
      font-weight: 800;
      letter-spacing: -0.3px;
    }

    .auth-sub {
      color: var(--text-muted);
      font-size: 15px;
      line-height: 1.6;
      margin: 0 auto 24px;
      max-width: 320px;
    }

    .btn-primary {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      max-width: 240px;
      min-height: 48px;
      margin: 8px auto 0;
      background: linear-gradient(180deg, #ff9fc2, var(--primary));
      color: #fff;
      border: none;
      border-radius: 12px;
      padding: 12px 20px;
      font-size: 15px;
      font-weight: 700;
      letter-spacing: 0.2px;
      cursor: pointer;
      box-shadow: 0 10px 22px rgba(255, 111, 159, 0.28);
      transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 14px 28px rgba(255, 111, 159, 0.35);
      background: linear-gradient(180deg, #ff8db8, var(--primary-dark));
    }

    .btn-primary:active {
      transform: translateY(0);
    }

    .btn-primary:focus-visible,
    .link-muted:focus-visible {
      outline: 3px solid rgba(124, 199, 247, 0.45);
      outline-offset: 3px;
    }

    .auth-footer {
      margin-top: 22px;
      font-size: 15px;
      color: #334155;
    }

    .link-muted {
      color: #2563eb;
      font-weight: 600;
      text-decoration: none;
      transition: color 0.2s ease;
    }

    .link-muted:hover {
      color: #1d4ed8;
      text-decoration: underline;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(18px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @media (max-width: 480px) {
      body.auth-bg {
        padding: 16px;
      }

      .auth-card {
        padding: 24px 18px;
        border-radius: 16px;
      }

      .auth-title {
        font-size: 22px;
      }

      .auth-sub {
        font-size: 14px;
      }

      .btn-primary {
        max-width: 100%;
      }

      .auth-logo {
        width: 78px;
        height: 78px;
      }
    }
  </style>
</head>

<body class="auth-bg">

  <main class="auth-card" role="main" aria-labelledby="landingTitle">
    <div class="auth-top">
      <img src="assets/garbh_sakhi_logo.png" alt="Garbh Sakhi logo" class="auth-logo" />
      <h1 id="landingTitle" class="auth-title">Welcome to Garbh Sakhi</h1>
      <p class="auth-sub">Caring for you and your baby, every step of the way.</p>
    </div>

    <button class="btn-primary" type="button" onclick="location.href='signup.jsp'">
      Create Account
    </button>

    <div class="auth-footer">
      Already have an account?
      <a class="link-muted" href="login.jsp">Login</a>
    </div>
  </main>

</body>
</html>