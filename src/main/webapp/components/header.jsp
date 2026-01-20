<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">

<!-- ================= HEADER ================= -->
<header class="gs-header">
  <!-- Mobile hamburger -->
  <button id="gsHamburger" class="gs-ham" aria-label="Open menu">
    <i class="ri-menu-line"></i>
  </button>

  <!-- Page title -->
  <h1 class="gs-title">
    <%= (request.getAttribute("pageTitle") != null) ? request.getAttribute("pageTitle") : "Garbh Sakhi" %>
  </h1>

  <!-- Right icons -->
  <div class="gs-actions">
    <button class="gs-icon" title="Notifications"><i class="ri-notification-line"></i></button>
    <a href="profile.jsp" class="gs-avatar-link" title="Profile">
      <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png" class="gs-avatar" alt="Profile">
    </a>
  </div>
</header>

<!-- ================= MOBILE DRAWER ================= -->
<div id="gsOverlay" class="gs-overlay"></div>

<aside id="gsDrawer" class="gs-drawer">
  <div class="gs-drawer-head">
    <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png" class="gs-drawer-logo" alt="Garbh Sakhi">
    <span class="gs-drawer-text">Garbh Sakhi</span>
  </div>
  <ul class="gs-drawer-links">
    <li><a href="labreports.jsp"><i class="ri-file-list-3-line"></i>Lab Reports</a></li>
    <li><a href="emergency.jsp"><i class="ri-phone-line"></i>Emergency</a></li>
    <li><a href="settings.jsp"><i class="ri-settings-3-line"></i>Settings</a></li>
  </ul>
</aside>

<!-- ================= CSS ================= -->
<style>
:root {
  --gs-sidebar-w: 260px;
  --gs-header-h: 64px;
}

/* ===== Base Header ===== */
.gs-header {
  position: fixed;
  top: 0;
  right: 0;
  height: var(--gs-header-h);
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
  z-index: 1100;
  transition: all 0.25s ease;
}

/* ===== Desktop Layout ===== */
@media (min-width: 901px) {
  .gs-header {
    left: var(--gs-sidebar-w);
    width: calc(100% - var(--gs-sidebar-w));
  }
  .gs-ham {
    display: none;
  }
}

/* ===== Mobile Layout ===== */
@media (max-width: 900px) {
  .gs-header {
    left: 0;
    width: 100%;
    height: 60px;
  }
  .gs-title {
    font-size: 18px;
  }
  .gs-ham {
    display: inline-flex;
  }
}

/* ===== Header Elements ===== */
.gs-ham {
  position: absolute;
  left: 14px;
  background: none;
  border: none;
  cursor: pointer;
  font-size: 24px;
  color: #243041;
  padding: 8px;
  border-radius: 10px;
  transition: background 0.25s;
}
.gs-ham:hover {
  background: rgba(255, 143, 178, 0.1);
}
.gs-title {
  margin: 0;
  font: 600 20px/1 'Poppins', sans-serif;
  color: #243041;
  text-align: center;
}
.gs-actions {
  position: absolute;
  right: 14px;
  display: flex;
  gap: 10px;
  align-items: center;
}
.gs-icon {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: #243041;
  transition: color 0.25s ease;
}
.gs-icon:hover {
  color: #ff4f93;
}
.gs-avatar {
  width: 32px;
  height: 32px;
  border-radius: 8px;
  object-fit: cover;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

/* ===== Drawer Overlay ===== */
.gs-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.35);
  opacity: 0;
  visibility: hidden;
  transition: 0.3s ease;
  z-index: 1090;
}
.gs-overlay.show {
  opacity: 1;
  visibility: visible;
}

/* ===== Drawer Panel ===== */
.gs-drawer {
  position: fixed;
  top: var(--gs-header-h);
  left: -260px;
  width: 240px;
  height: calc(100vh - var(--gs-header-h));
  background: #fff;
  box-shadow: 4px 0 16px rgba(0, 0, 0, 0.12);
  transition: left 0.28s ease;
  z-index: 1095;
  padding: 16px;
  border-top-right-radius: 16px;
  border-bottom-right-radius: 16px;
}
.gs-drawer.open {
  left: 0;
}

/* Drawer header */
.gs-drawer-head {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 14px;
  font-weight: 600;
  color: #243041;
}
.gs-drawer-logo {
  width: 40px;
  height: 40px;
  border-radius: 10px;
}
.gs-drawer-text {
  font-size: 18px;
  font-weight: 600;
}

/* Drawer links */
.gs-drawer-links {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.gs-drawer-links a {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  border-radius: 12px;
  color: #243041;
  text-decoration: none;
  font-size: 15px;
  transition: all 0.25s ease;
}
.gs-drawer-links a:hover {
  background: linear-gradient(135deg, #ffe0ef, #e6f2ff);
  color: #ff4f93;
}
</style>

<!-- ================= SCRIPT ================= -->
<script>
const gsHam = document.getElementById('gsHamburger');
const gsDrawer = document.getElementById('gsDrawer');
const gsOverlay = document.getElementById('gsOverlay');

function closeDrawer() {
  gsDrawer.classList.remove('open');
  gsOverlay.classList.remove('show');
}
function toggleDrawer() {
  const open = gsDrawer.classList.toggle('open');
  gsOverlay.classList.toggle('show', open);
}
gsHam?.addEventListener('click', toggleDrawer);
gsOverlay?.addEventListener('click', closeDrawer);
</script>