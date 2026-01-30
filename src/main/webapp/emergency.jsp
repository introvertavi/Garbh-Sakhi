<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    request.setAttribute("pageTitle", "Emergency");
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

      <div class="page-intro">
        🚑 <h2>Emergency Contacts</h2>
        <p>Quick access to people and services who can help immediately.</p>
      </div>

      <div class="gs-card emergency-card highlight">
        <div>
          <h3>National Ambulance</h3>
          <p>India Emergency Medical Service</p>
        </div>
        <a href="tel:108" class="btn-danger">Call 108</a>
      </div>

      <div class="gs-card emergency-card">
        <div>
          <h3>Primary Contact</h3>
          <p>Name: Contact Name</p>
          <p>Phone: +91 98765 43210</p>
        </div>
        <a href="tel:+919876543210" class="btn-call">Call</a>
      </div>

      <div class="gs-card emergency-card">
        <div>
          <h3>Secondary Contact</h3>
          <p>Name: Contact Name</p>
          <p>Phone: +91 91234 56789</p>
        </div>
        <a href="tel:+919123456789" class="btn-call">Call</a>
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



/* INTRO */
.page-intro{
  text-align:center;
}
.page-intro h2{
  display:inline;
  margin-left:6px;
}

/* CARDS */
.emergency-card{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:22px;
  border-radius:18px;
  background:#fff;
  box-shadow:0 8px 22px rgba(0,0,0,.08);
}

.emergency-card.highlight{
  border:2px solid #ff6b9a;
  background:#fff5f8;
}

/* BUTTONS */
.btn-call{
  background:#22c55e;
  color:#fff;
  padding:10px 18px;
  border-radius:12px;
  font-weight:600;
  text-decoration:none;
}

.btn-danger{
  background:#ff3b5f;
  color:#fff;
  padding:10px 18px;
  border-radius:12px;
  font-weight:600;
  text-decoration:none;
}
</style>


