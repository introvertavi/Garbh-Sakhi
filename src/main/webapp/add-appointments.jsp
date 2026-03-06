<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Add Appointment");
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/modern-style.css">
</head>

<body>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<div class="main-content">
  <div style="max-width:800px;margin:0 auto;padding:24px;">

    <div class="gs-card">
      <h2 style="margin-bottom:20px;">➕ Add Appointment</h2>

      <!-- ✅ FIXED ACTION -->
      <form method="post" action="add-appointment">

        <div class="row-2">
          <div class="field">
            <label>Title</label>
            <input type="text" name="title" required placeholder="e.g. Prenatal Checkup">
          </div>

          <div class="field">
            <label>Doctor Name</label>
            <input type="text" name="doctorName">
          </div>
        </div>

        <div class="row-2">
          <div class="field">
            <label>Hospital / Clinic</label>
            <input type="text" name="hospitalName">
          </div>

          <div class="field">
            <label>Date</label>
            <input type="date" name="appointmentDate" required>
          </div>
        </div>

        <div class="row-2">
          <div class="field">
            <label>Time</label>
            <input type="time" name="appointmentTime" required>
          </div>
        </div>

        <div class="field">
          <label>Notes</label>
          <textarea name="notes" rows="3"></textarea>
        </div>

        <div class="actions" style="margin-top:20px;">
          <button type="submit" class="btn-primary">Save</button>
          <a href="appointments" class="btn-ghost">Cancel</a>
        </div>

      </form>
    </div>

  </div>
</div>

</body>
</html>
