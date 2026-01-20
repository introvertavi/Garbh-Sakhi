<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">

<nav class="bottom-nav">
  <a href="dashboard.jsp" class="<%= request.getAttribute("pageTitle").equals("Dashboard") ? "active" : "" %>">
    <i class="ri-home-5-line"></i>
    <span>Home</span>
  </a>

  <a href="appointments.jsp" class="<%= request.getAttribute("pageTitle").equals("Appointments") ? "active" : "" %>">
    <i class="ri-calendar-check-line"></i>
    <span>Appointments</span>
  </a>

  <a href="medicines.jsp" class="<%= request.getAttribute("pageTitle").equals("Medicines") ? "active" : "" %>">
    <i class="ri-capsule-line"></i>
    <span>Medicines</span>
  </a>

  <a href="profile.jsp" class="<%= request.getAttribute("pageTitle").equals("Profile") ? "active" : "" %>">
    <i class="ri-user-line"></i>
    <span>Profile</span>
  </a>
</nav>

<style>
/* 🌸 Bottom Navigation (Pastel theme, mobile only) */
.bottom-nav {
  display: none; /* hidden on desktop */
}

@media (max-width: 1024px) {
  .bottom-nav {
    display: flex !important;
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    height: 64px;
    background: #ffffffcc;
    backdrop-filter: blur(10px);
    border-top: 1px solid rgba(0, 0, 0, 0.08);
    justify-content: space-around;
    align-items: center;
    z-index: 2000;
    box-shadow: 0 -4px 14px rgba(0, 0, 0, 0.05);
  }

  .bottom-nav a {
    text-decoration: none;
    color: #364254;
    display: flex;
    flex-direction: column;
    align-items: center;
    font-size: 0.8rem;
    font-weight: 500;
    gap: 4px;
    transition: all 0.3s ease;
  }

  .bottom-nav a i {
    font-size: 1.4rem;
  }

  .bottom-nav a.active {
    color: #ff4f93;
  }

  .bottom-nav a.active i {
    transform: scale(1.15);
  }
}
</style>
