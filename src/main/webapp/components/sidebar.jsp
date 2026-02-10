<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String sidebarPageTitle = (String) request.getAttribute("pageTitle");
  if (sidebarPageTitle == null) sidebarPageTitle = "";
%>

<!-- DESKTOP SIDEBAR -->
<aside id="sidebar" class="gs-sidebar desktop-sidebar" role="navigation" aria-label="Main menu">
  <div class="gs-side-logo">
    <img src="<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png" class="gs-side-logo-img" alt="Garbh Sakhi">
    <span class="gs-side-logo-text">Garbh Sakhi</span>
  </div>

  <ul class="gs-side-menu">
    <li><a href="dashboard.jsp"   class="<%= sidebarPageTitle.equals("Dashboard")   ? "active" : "" %>"><i class="ri-home-5-line"></i>Dashboard</a></li>
    <li><a href="appointments.jsp" class="<%= sidebarPageTitle.equals("Appointments") ? "active" : "" %>"><i class="ri-calendar-check-line"></i>Appointments</a></li>
    <li><a href="medicines.jsp"    class="<%= sidebarPageTitle.equals("Medicines")    ? "active" : "" %>"><i class="ri-capsule-line"></i>Medicines</a></li>
    <li><a href="profile.jsp"      class="<%= sidebarPageTitle.equals("Profile")      ? "active" : "" %>"><i class="ri-user-line"></i>Profile</a></li>
    <li><a href="labreports.jsp"   class="<%= sidebarPageTitle.equals("Lab Reports")  ? "active" : "" %>"><i class="ri-file-list-3-line"></i>Lab Reports</a></li>
    <li><a href="emergency.jsp"    class="<%= sidebarPageTitle.equals("Emergency")    ? "active" : "" %>"><i class="ri-phone-line"></i>Emergency</a></li>
    <li><a href="settings.jsp"     class="<%= sidebarPageTitle.equals("Settings")     ? "active" : "" %>"><i class="ri-settings-3-line"></i>Settings</a></li>
  </ul>
</aside>

<style>
:root{ --gs-sidebar-w:260px; --gs-header-h:64px; }

/* Desktop sidebar (always visible) */
.gs-sidebar{
  position:fixed; left:0; top:0; bottom:0;
  width:var(--gs-sidebar-w);
  background:#fff;
  box-shadow:2px 0 12px rgba(0,0,0,.05);
  padding:20px 16px;
  z-index:1000;
  overflow-y:auto;
}

/* Logo block (centered, visible) */
.gs-side-logo{
  display:flex; flex-direction:column; align-items:center; text-align:center;
  margin-top:12px; margin-bottom:18px;
}
.gs-side-logo-img{ width:78px; height:78px; border-radius:18px; object-fit:cover; box-shadow:0 6px 16px rgba(255,155,177,.25); }
.gs-side-logo-text{ margin-top:8px; font:600 19px/1.2 'Poppins',sans-serif; color:#243041; }

/* Menu */
.gs-side-menu{ list-style:none; padding:0; margin:8px 0 0; display:flex; flex-direction:column; gap:8px; }
.gs-side-menu a{
  display:flex; align-items:center; gap:12px;
  padding:11px 14px; border-radius:14px; text-decoration:none;
  color:#364254; background:#faf8fc; transition:all .25s ease; position:relative;
}
.gs-side-menu a i{ font-size:18px; }
.gs-side-menu a:hover{ background:linear-gradient(135deg,#ffe0ef,#e6f2ff); color:#ff4f93; transform:translateY(-2px); box-shadow:0 6px 12px rgba(255,143,178,.15); }
.gs-side-menu a.active{ background:linear-gradient(135deg,#ffe0ef,#e6f2ff); color:#ff4f93; font-weight:600; box-shadow:0 8px 20px rgba(255,143,178,.2); }
.gs-side-menu a::before{
  content:""; position:absolute; left:6px; top:50%; transform:translateY(-50%) scaleY(0);
  width:3px; height:70%; background:#ff8ab4; border-radius:2px; transition:transform .25s ease;
}
.gs-side-menu a:hover::before, .gs-side-menu a.active::before{ transform:translateY(-50%) scaleY(1); }

/* Mobile: hide desktop sidebar (we use the drawer from header.jsp) */
@media (max-width:900px){
  .gs-sidebar{ display:none !important; }
}

/* CONTENT OFFSET — keep pages out from under header */
.content-wrapper, .main-content{
  margin-left:var(--gs-sidebar-w);
  padding-top:calc(var(--gs-header-h) + 24px);
  position: relative;
  z-index: 1;
}

@media (max-width:900px){
  .content-wrapper, .main-content{ margin-left:0; padding-top:calc(var(--gs-header-h) + 12px); }
}
</style>


