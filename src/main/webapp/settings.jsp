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

      <div class="gs-card settings-card">
        <h3>Account</h3>
        <a href="#" class="link">Change Password</a><br>
        <a href="logout" class="link danger">Logout</a>
      </div>

      <div class="gs-card settings-card danger-zone">
        <h3>Danger Zone</h3>
        <button class="btn-danger">Delete Account</button>
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

/* CONTENT WRAPPER */
.content-wrapper{
  width:100%;
  max-width:720px;
  padding-left:16px;
  padding-right:64px; /* base breathing space */
}

/* DESKTOP: heavy visual compensation */
@media(min-width:901px){
  .page-container{
    padding-left:260px; /* sidebar width */
  }

  .content-wrapper{
    padding-right:140px; /* 🔥 STRONG optical balance */
  }
}

/* LARGE DESKTOP / WIDE SCREENS */
@media(min-width:1280px){
  .content-wrapper{
    padding-right:180px; /* 🔥🔥 very premium spacing */
  }
}

/* MOBILE */
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

/* STACK */
.center-stack{
  width:100%;
  display:flex;
  flex-direction:column;
  gap:20px;
}


/* CARDS */
.settings-card{
  padding:22px;
  border-radius:18px;
  background:#fff;
  box-shadow:0 8px 22px rgba(0,0,0,.08);
}

/* TOGGLES */
.toggle-row{
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-top:14px;
}

/* SWITCH */
.switch{
  position:relative;
  width:44px;
  height:24px;
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
  height:18px;
  width:18px;
  left:3px;
  top:3px;
  background:#fff;
  border-radius:50%;
  transition:.3s;
}
.switch input:checked + .slider{
  background:#ff6b9a;
}
.switch input:checked + .slider:before{
  transform:translateX(20px);
}

/* LINKS */
.link{
  color:#3b82f6;
  font-weight:500;
  text-decoration:none;
}
.link.danger{
  color:#ff3b5f;
}

/* DANGER */
.danger-zone{
  background:#fff3f6;
  border:1px solid #ffb3c4;
}

.btn-danger{
  background:#ff3b5f;
  color:#fff;
  border:none;
  padding:10px 18px;
  border-radius:12px;
  font-weight:600;
  cursor:pointer;
}
</style>

