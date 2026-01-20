<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.dao.UserDAO" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page session="true" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = UserDAO.getUserById(userId);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Dashboard");

    int pregWeek = 0;
    String babyFruit = null;

    if (user.getDueDate() != null && !user.getDueDate().isBlank()) {
        pregWeek = PregnancyUtil.getPregnancyWeek(user.getDueDate());
        babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);
    }
%>

<!-- Ensure proper scaling across all devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Layout Includes -->
<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<!-- Styles -->
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

<!-- DASHBOARD PAGE CONTENT -->
<div class="dashboard-page">
  <div class="content-wrapper">

    <!-- Welcome Section -->
    <div class="dash-welcome">
      <h1>👋 Welcome, <%= user.getFullName() != null ? user.getFullName() : "Guest" %>!</h1>
      <p>
        You are <b><%= user.getAge() > 0 ? user.getAge() : "N/A" %> years old</b>,
        and your due date is <b><%= user.getDueDate() != null ? user.getDueDate() : "Not set yet" %></b>.
      </p>

      <% if (pregWeek > 0) { %>
        <p>You're currently in <b>Week <%= pregWeek %></b> of pregnancy.<br>
        Baby size → <b><%= babyFruit %></b> 🍼</p>
      <% } else { %>
        <p>Please update your due date in your <b>Profile</b> to view your progress.</p>
      <% } %>
    </div>

    <!-- Dashboard Grid -->
    <div class="dash-grid">
      <div class="dash-card">💡 Health Tip</div>
      <div class="dash-card">📅 Next Appointment</div>
      <div class="dash-card">💊 Today's Medicines</div>
      <div class="dash-card">🧪 Recent Lab Report</div>
    </div>

  </div>
</div>

<style>
/* =============================
   DASHBOARD FINAL FIXED MOBILE VERSION
   ============================= */

/* Desktop Defaults */
.dashboard-page .content-wrapper {
  margin-left: var(--gs-sidebar-w);
  padding: calc(var(--gs-header-h) + 24px) 40px 100px;
  box-sizing: border-box;
}

/* Welcome Card */
.dashboard-page .dash-welcome {
  background: #fff;
  border-radius: 22px;
  padding: 26px;
  margin-bottom: 20px;
  box-shadow: 0 10px 28px rgba(20,28,40,0.06);
  line-height: 1.6;
  width: 100%;
}

.dashboard-page .dash-welcome h1 {
  font-size: 26px;
  margin-bottom: 10px;
  color: #243041;
}

.dashboard-page .dash-welcome p {
  font-size: 15px;
  color: #364254;
}

/* Grid Layout */
.dashboard-page .dash-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 22px;
  width: 100%;
}

/* Dashboard Cards */
.dashboard-page .dash-card {
  background: #fff;
  border-radius: 20px;
  padding: 22px;
  font-size: 16px;
  font-weight: 500;
  box-shadow: 0 8px 20px rgba(20, 28, 40, 0.06);
  transition: all 0.25s ease;
  text-align: center;
}

.dashboard-page .dash-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 25px rgba(255, 143, 178, 0.25);
}

/* =============================
   ✅ MOBILE FULL WIDTH FIX + SPACING TWEAK
   ============================= */
@media (max-width: 900px) {
  html, body {
    width: 100% !important;
    overflow-x: hidden !important;
    margin: 0;
    padding: 0;
  }

  /* Force all parents to be full width */
  .dashboard-page,
  .dashboard-page .content-wrapper,
  .dashboard-page .dash-grid,
  .dashboard-page .dash-welcome,
  .dashboard-page .dash-card {
    max-width: 100% !important;
    width: 100% !important;
    margin: 0 !important;
    left: 0 !important;
    right: 0 !important;
    box-sizing: border-box !important;
  }

  .dashboard-page .content-wrapper {
    padding: calc(var(--gs-header-h) + 8px) 10px calc(var(--gs-bottomnav-h) + 10px);
  }

  /* Welcome card styling */
  .dashboard-page .dash-welcome {
    padding: 20px 18px;
    border-radius: 18px;
    margin-bottom: 14px !important; /* ✅ fixed spacing below welcome card */
  }

  .dashboard-page .dash-welcome h1 {
    font-size: 22px;
    line-height: 1.4;
  }

  .dashboard-page .dash-welcome p {
    font-size: 14px;
  }

  /* Cards */
  .dashboard-page .dash-grid {
    display: flex;
    flex-direction: column;
    gap: 14px !important; /* ✅ evenly spaced cards */
  }

  .dashboard-page .dash-card {
    padding: 18px;
    font-size: 15px;
    border-radius: 14px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    margin: 0 !important;
  }

  .dashboard-page .dash-card:first-child {
    margin-top: 0 !important;
  }

  .dashboard-page .dash-card:last-child {
    margin-bottom: 10px !important;
  }
}
</style>