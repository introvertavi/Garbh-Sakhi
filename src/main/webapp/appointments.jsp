<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>
<%@ page session="true" %>

<%
    // 🔐 AUTH CHECK
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 🛡️ ENSURE PAGE IS OPENED VIA SERVLET
    if (request.getAttribute("appointments") == null) {
        response.sendRedirect("appointments");
        return;
    }

    request.setAttribute("pageTitle", "Appointments");
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/modern-style.css">

    <!-- CALENDAR -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>

<body>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<div class="main-content">
  <div style="max-width:1100px;margin:0 auto;padding:24px;">

    <div class="gs-card">

      <!-- HEADER -->
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
        <h2>📅 Appointments</h2>
        <a href="add-appointments.jsp" class="btn-primary">+ Add Appointment</a>
      </div>

      <!-- LAYOUT -->
      <div class="appt-layout">

        <!-- CALENDAR -->
        <div class="calendar-mini gs-card">
          <h3 class="calendar-title">Select Date</h3>
          <div class="calendar-box">
            <input type="text" id="appointmentCalendar" class="calendar-input">
          </div>
        </div>

        <!-- APPOINTMENT LIST -->
        <div class="appt-list gs-card">
          <h3 style="margin-bottom:16px;">Upcoming Appointments</h3>

          <%
              List<Appointment> appointments =
                  (List<Appointment>) request.getAttribute("appointments");

              if (appointments.isEmpty()) {
          %>
              <p class="muted">No appointments yet.</p>
          <%
              } else {
                  for (Appointment a : appointments) {
          %>

          <div class="appointment-item">

            <!-- DATE BADGE -->
            <div class="appt-date">
              <span class="day"><%= a.getAppointmentDate().getDayOfMonth() %></span>
              <span class="month">
                <%= a.getAppointmentDate().getMonth().toString().substring(0,3) %>
              </span>
            </div>

            <!-- INFO -->
            <div class="appt-info">
              <strong><%= a.getTitle() %></strong>

              <p class="muted">
                <%= a.getDoctorName() %> • <%= a.getAppointmentTime() %>
              </p>

              <p class="muted small"><%= a.getHospitalName() %></p>

              <!-- STATUS -->
              <span class="status-badge <%= a.getStatus().toLowerCase() %>">
                <%= a.getStatus() %>
              </span>
            </div>

            <!-- ACTIONS -->
            <div class="appt-actions">
              <a href="edit-appointment?id=<%= a.getId() %>" class="btn-icon">✏️</a>

              <form method="post" action="delete-appointment"
                    onsubmit="return confirm('Delete this appointment?');">
                <input type="hidden" name="id" value="<%= a.getId() %>">
                <button type="submit" class="btn-icon danger">🗑️</button>
              </form>
            </div>

          </div>

          <%
                  }
              }
          %>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  flatpickr("#appointmentCalendar", {
    inline: true,
    defaultDate: "today",
    dateFormat: "d-m-Y"
  });
</script>

</body>
</html>
