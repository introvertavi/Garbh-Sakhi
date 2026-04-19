<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>
<%@ page import="com.garbhsakhi.dao.MedicineDAO" %>
<%@ page import="com.garbhsakhi.dao.AppointmentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">

<%
User headerUser = (User) session.getAttribute("user");
String headerAvatarUrl = request.getContextPath() + "/assets/garbh_sakhi_logo.png";

if (headerUser != null && headerUser.getAvatarPath() != null && !headerUser.getAvatarPath().isBlank()) {
  String storedAvatarPath = headerUser.getAvatarPath().trim();
  if (storedAvatarPath.startsWith("http://")
          || storedAvatarPath.startsWith("https://")
          || storedAvatarPath.startsWith(request.getContextPath() + "/")) {
      headerAvatarUrl = storedAvatarPath;
  } else if (storedAvatarPath.startsWith("/")) {
      headerAvatarUrl = request.getContextPath() + storedAvatarPath;
  } else {
      headerAvatarUrl = request.getContextPath() + "/" + storedAvatarPath;
  }
}

int visibleNotificationCount = 0;
String notificationSignature = "";
Integer pending = 0;
Integer missed = 0;
Appointment upcoming = null;
List<String[]> notifications = new ArrayList<>();

if (headerUser != null) {
  MedicineDAO medicineDAO = new MedicineDAO();
  AppointmentDAO.updateMissedAppointments(headerUser.getId());

  pending = medicineDAO.getPendingDoseCount(headerUser.getId());
  missed = medicineDAO.getMissedDoseCount(headerUser.getId());
  upcoming = AppointmentDAO.getNextTodayAppointment(headerUser.getId());

  if (upcoming == null) {
      List<Appointment> upcomingAppointments = AppointmentDAO.getUpcomingAppointments(headerUser.getId());
      if (upcomingAppointments != null && !upcomingAppointments.isEmpty()) {
          upcoming = upcomingAppointments.get(0);
      }
  }

  Set<String> dismissedNotifications =
          (Set<String>) session.getAttribute("dismissedNotifications");
  if (dismissedNotifications == null) {
      dismissedNotifications = new HashSet<>();
  }

  if (pending != null && pending > 0 && !dismissedNotifications.contains("pending-medicines")) {
      notifications.add(new String[]{
              "pending-medicines",
              "Medicine Reminder",
              pending + " pending medicine dose(s)",
              request.getContextPath() + "/medicines",
              ""
      });
  }

  if (upcoming != null) {
      String appointmentKey = "appointment-" + upcoming.getId();
      if (!dismissedNotifications.contains(appointmentKey)) {
          String appointmentMessage = upcoming.getTitle() + " at " + upcoming.getAppointmentTime();
          notifications.add(new String[]{
                  appointmentKey,
                  "Upcoming Appointment",
                  appointmentMessage,
                  request.getContextPath() + "/appointments",
                  ""
          });
      }
  }

  if (missed != null && missed > 0 && !dismissedNotifications.contains("missed-medicines")) {
      notifications.add(new String[]{
              "missed-medicines",
              "Missed Medicines",
              missed + " missed dose(s) from yesterday",
              request.getContextPath() + "/dashboard",
              "danger"
      });
  }

  visibleNotificationCount = notifications.size();
  notificationSignature = Integer.toString(notifications.toString().hashCode());
}

String seenNotificationSignature =
        (String) session.getAttribute("seenNotificationSignature");
boolean showNotificationBadge =
        visibleNotificationCount > 0 && !notificationSignature.equals(seenNotificationSignature);
%>

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
    <div class="notification-wrapper">

  <button class="gs-icon notification-bell" onclick="toggleNotifications()" title="Notifications">
    <i class="ri-notification-line"></i>

    <% if (showNotificationBadge) { %>
      <span class="notification-count" id="notificationCount"><%= visibleNotificationCount %></span>
    <% } %>

  </button>

  <!-- DROPDOWN -->
  <div id="notificationDropdown" class="notification-dropdown"
       data-signature="<%= notificationSignature %>">

    <% if (notifications.isEmpty()) { %>
      <div class="notif-empty">No notifications 🎉</div>
    <% } else { for (String[] notification : notifications) { %>
      <div class="notif-item <%= notification[4] %>" data-key="<%= notification[0] %>">
        <a href="<%= notification[3] %>"
           class="notif-link"
           onclick="handleNotificationClick(event, '<%= notificationSignature %>')">
          <strong><%= notification[1] %></strong>
          <span><%= notification[2] %></span>
        </a>
        <button type="button"
                class="notif-dismiss"
                title="Dismiss notification"
                onclick="dismissNotification(event, '<%= notification[0] %>', '<%= notificationSignature %>')">
          <i class="ri-close-line"></i>
        </button>
      </div>
    <% } %>
    <% } %>

  </div>

</div>
    <a href="profile.jsp" class="gs-avatar-link" title="Profile">
      <img src="<%= headerAvatarUrl %>" class="gs-avatar" alt="Profile"
           onerror="this.onerror=null;this.src='<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png';">
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
.notification-bell {
  position: relative;
}
.notification-dropdown {
  position: absolute;
  top: 42px;
  right: 0;
  width: 300px;
  background: #fff;
  border-radius: 14px;
  box-shadow: 0 14px 32px rgba(36, 48, 65, 0.16);
  padding: 10px;
  display: none;
  z-index: 1200;
}
.notification-count {
  position: absolute;
  top: -4px;
  right: -6px;
  min-width: 18px;
  height: 18px;
  padding: 0 5px;
  border-radius: 999px;
  background: #ff4f93;
  color: #fff;
  font-size: 11px;
  font-weight: 700;
  line-height: 18px;
  text-align: center;
}
.notif-item {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  border-radius: 12px;
  padding: 10px;
  transition: background 0.2s ease;
}
.notif-item:hover {
  background: #fff4f8;
}
.notif-item.danger {
  background: #fff5f5;
}
.notif-link {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
  color: #243041;
  text-decoration: none;
}
.notif-link strong {
  font-size: 14px;
}
.notif-link span {
  font-size: 13px;
  color: #5b6677;
}
.notif-dismiss {
  border: none;
  background: transparent;
  color: #8a94a6;
  font-size: 18px;
  cursor: pointer;
  padding: 2px;
  border-radius: 8px;
}
.notif-dismiss:hover {
  color: #ff4f93;
  background: rgba(255, 79, 147, 0.08);
}
.notif-empty {
  padding: 12px 10px;
  color: #5b6677;
  font-size: 14px;
  text-align: center;
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
async function updateNotificationState(action, signature, key) {
  try {
    const params = new URLSearchParams();
    params.set("action", action);
    params.set("signature", signature || "");
    if (key) {
      params.set("key", key);
    }

    await fetch("<%= request.getContextPath() %>/notification-state", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: params.toString()
    });
  } catch (error) {
    console.error("Notification state update failed", error);
  }
}

function hideNotificationBadge() {
  const badge = document.getElementById("notificationCount");
  if (badge) {
    badge.remove();
  }
}

async function handleNotificationClick(event, signature) {
  event.preventDefault();
  const href = event.currentTarget.getAttribute("href");
  hideNotificationBadge();
  await updateNotificationState("seen", signature);
  window.location.href = href;
}

async function dismissNotification(event, key, signature) {
  event.preventDefault();
  event.stopPropagation();

  const item = event.currentTarget.closest(".notif-item");
  if (item) {
    item.remove();
  }

  await updateNotificationState("dismiss", signature, key);

  const dropdown = document.getElementById("notificationDropdown");
  if (dropdown && !dropdown.querySelector(".notif-item")) {
    dropdown.innerHTML = '<div class="notif-empty">No notifications 🎉</div>';
  }

  const remainingItems = dropdown ? dropdown.querySelectorAll(".notif-item").length : 0;
  const badge = document.getElementById("notificationCount");
  if (badge) {
    if (remainingItems > 0) {
      badge.textContent = remainingItems;
    } else {
      badge.remove();
    }
  }
}

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
<form action="<%= request.getContextPath() %>/logout" method="get">
    <button type="submit">Logout</button>
</form>

<script>
async function toggleNotifications() {
  const box = document.getElementById("notificationDropdown");
  const willOpen = box.style.display !== "block";
  box.style.display = willOpen ? "block" : "none";

  if (willOpen) {
    hideNotificationBadge();
    await updateNotificationState("seen", box.dataset.signature || "");
  }
}

// close when clicking outside
document.addEventListener("click", function(e) {
  const wrapper = document.querySelector(".notification-wrapper");
  if (wrapper && !wrapper.contains(e.target)) {
    const box = document.getElementById("notificationDropdown");
    if (box) box.style.display = "none";
  }
});
</script>
