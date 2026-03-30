<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    request.setAttribute("pageTitle", "Settings");
%>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

<div class="page-container">
  <div class="content-wrapper">

    <div class="center-stack">

      <!-- APP PREFERENCES -->
      <div class="gs-card settings-card">
        <h3>App Preferences</h3>

        <div class="toggle-row">
          <span>Enable Notifications</span>
          <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
          </label>
        </div>

        <div class="toggle-row">
          <span>Medicine Reminders</span>
          <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
          </label>
        </div>
      </div>

      <!-- ACCOUNT -->
      <div class="gs-card settings-card">
        <h3>Account</h3>

        <a href="<%= request.getContextPath() %>/change-password.jsp" class="link">
          Change Password
        </a>

        <!-- LOGOUT -->
        <form action="<%= request.getContextPath() %>/logout"
              method="get"
              style="margin-top:20px;">
          <button type="submit"
                  class="btn-danger">
            Logout
          </button>
        </form>
      </div>

      <!-- DANGER ZONE -->
      <div class="gs-card settings-card danger-zone">
        <h3>Danger Zone</h3>

        <form action="<%= request.getContextPath() %>/delete-account"
              method="post"
              onsubmit="return confirm('This action is irreversible. Delete account?');">
          <button class="btn-danger">
            Delete Account
          </button>
        </form>
      </div>

    </div>

  </div>
</div>


<style>
/* PAGE CONTAINER */
.page-container{
  padding-top:80px;
  width:100%;
  display:flex;
  justify-content:center;
  box-sizing:border-box;
}

.content-wrapper{
  width:100%;
  max-width:720px;
  padding-left:16px;
  padding-right:64px;
}

@media(min-width:901px){
  .page-container{ padding-left:260px; }
  .content-wrapper{ padding-right:140px; }
}

@media(min-width:1280px){
  .content-wrapper{ padding-right:180px; }
}

@media(max-width:900px){
  .page-container{
    padding-left:0;
    padding-bottom:90px;
  }
  .content-wrapper{
    padding-left:16px;
    padding-right:16px;
  }
}

.center-stack{
  width:100%;
  display:flex;
  flex-direction:column;
  gap:24px;
}

/* ── IMPROVED CARDS ── */
.settings-card{
  padding:28px 26px;
  border-radius:20px;
  background:#fff;
  box-shadow:0 8px 25px rgba(0,0,0,0.07);
  margin-bottom:4px;
}

.settings-card h3{
  margin:0 0 22px 0;
  font-size:19px;
  font-weight:600;
  color:#1e293b;
}

/* TOGGLES */
.toggle-row{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:16px 0;
  border-top:1px solid #f1f5f9;
}

.toggle-row:first-child{
  border-top:none;
  padding-top:4px;
}

.toggle-row span{
  font-size:15.5px;
  color:#374151;
}

/* SWITCH - Slightly improved */
.switch{
  position:relative;
  width:46px;
  height:25px;
}
.switch input{ display:none; }
.slider{
  position:absolute;
  inset:0;
  background:#e5e7eb;
  border-radius:999px;
  cursor:pointer;
  transition:.3s;
}
.slider:before{
  content:"";
  position:absolute;
  height:19px;
  width:19px;
  left:3px;
  top:3px;
  background:#fff;
  border-radius:50%;
  transition:.3s;
  box-shadow:0 2px 4px rgba(0,0,0,0.1);
}
.switch input:checked + .slider{
  background:#ff6b9a;
}
.switch input:checked + .slider:before{
  transform:translateX(21px);
}

/* LINKS */
.link{
  color:#3b82f6;
  font-weight:500;
  text-decoration:none;
  display:block;
  padding:8px 0;
  font-size:15.5px;
}

/* DANGER ZONE */
.danger-zone{
  background:#fff3f6;
  border:1px solid #ffb3c4;
}

.btn-danger{
  background:#ff3b5f;
  color:#fff;
  border:none;
  padding:12px 24px;
  border-radius:12px;
  font-weight:600;
  cursor:pointer;
  width:100%;
  margin-top:8px;
}

/* Logout button - better alignment */
.settings-card form .btn-danger {
  width: auto;
  padding: 10px 22px;
  margin-top: 12px;
}
</style>